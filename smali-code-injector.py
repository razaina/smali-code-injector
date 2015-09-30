#!/usr/bin/env python
# --*-- coding: UTF-8 --*--
import os
import sys
import shutil
import zipfile
import subprocess
import argparse
import graphic_interface
import helper
import process
import metadata

def parseArgs():
	""" 
	Parse command line arguments.
	
	:return:	command line
	:rtype:	argument object
	"""
	parser = argparse.ArgumentParser(description='inject custom code into .smali inject_user_inputs')
	
	parser.add_argument('-g', '--graphic', dest = 'graph', help = 'launch the graphic user interface',	 action='store_true') 
	parser.add_argument('-a', '--app', dest = 'app', help = 'path of the Android application (.apk) to reverse engineer', type = str)
	parser.add_argument('-t', '--target',  dest = 'target', help = 'path of the dir/file containing the .smali codes to edit',  type = str) 
	parser.add_argument('-i', '--inject', dest = 'code_to_inject', help = 'method name or a string contained in the method name of the code to inject', type = str) 
	parser.add_argument('-k', '--keywords', dest = 'keywords', help = 	'type a list of keywords - separated by \',\' - to filter on the inject_user_inputs to edit or ' + \
																		'type 1 to use the predefined networking keywords list', required = False, type = str) 
	parser.add_argument('-c', '--check', help = 'search for injected codes inside of a directory/file', required = False, action='store_true')
	
	args = parser.parse_args()
	
	return args

# Improve this shit!
def check_inject_arg(inject_arg):
	injectable_codes = helper.get_injectable_codes()
	
	for injectable_code in injectable_codes:
		if (inject_arg in injectable_code):					
			return injectable_code
	
	return None
	
def treat_dir(target, code_to_inject):
	print('::INFO  Creation of metadata...')
	my_metadata = metadata.create_metadata(target)
	process.copy_smali_class_files(target)	
	args = parseArgs()
	
	if (args.keywords):
		keywords = args.keywords.split(',')
		process.process_dir(target, my_metadata, code_to_inject, keywords)
		
	else:		
		process.process_dir(target, my_metadata, code_to_inject)
		
	process.processed_dir_info(os.path.basename(target), code_to_inject, my_metadata)		
						
def treat_file(target, code_to_inject):
	print('::INFO  Creation of metadata...')
	file_metadata = metadata.create_file_metadata(target)				
	process.copy_smali_class_files(os.path.dirname(target))
	args = parseArgs()
	
	if (args.keywords):
		keywords = args.keywords.split(',')
		process.process_file(target, file_metadata, code_to_inject, keywords)
		
	else:		
		process.process_file(target, file_metadata, code_to_inject)
		
	process.processed_file_info(os.path.basename(target), code_to_inject, file_metadata)	
		
def main():
	args = parseArgs()
	
	if (args.graph):
		graphic_interface.main_menu()

	elif (args.app and args.code_to_inject):
		app = os.path.abspath(args.app)
		
		if (os.path.isfile(app) and app.endswith('.apk')):
			inject_user_input = args.code_to_inject
			code_to_inject = check_inject_arg(inject_user_input)
			head, tail = os.path.split(app)
			tail = os.path.splitext(tail)[0]
			
			if (code_to_inject):				
				if (not os.getenv('JAVA_HOME') or (os.getenv('JAVA_HOME') not in os.getenv('PATH'))):
					nenv = os.environ.copy()
					nenv['JAVA_HOME'] = 'C:/Program Files/Java/jdk1.8.0_45'
					nenv['PATH'] += ';C:/Program Files/Java/jdk1.8.0_45/bin'
				
				print('\n::INFO  Disassembly {0}...\n'.format(tail))
				sp = subprocess.Popen([	'java', '-jar', os.path.join('modules', 'baksmali.jar'), 
										'-p', app, '-o', os.path.join('smali', tail)], shell=True, env=nenv)
				sp.wait()	
				
				if (args.target):
					# For the target to be ./smali/skandiabanken-smali-mod/se just enter --target se
					target = os.path.join('smali', tail + '-mod', args.target)
					helper.copy(os.path.join('smali', tail ), os.path.join('smali', tail + '-mod'))	
					
					if ((os.path.exists(target)) and (os.path.isdir(target) \
					or (os.path.isfile(target) and target.endswith('.smali')))):
						if (os.path.isdir(target)):
							treat_dir(target, code_to_inject)
						else:
							treat_file(target, code_to_inject)
					
					else:
						print('\n::WARN  {0} does not exist/is not valid, please try again... \n' .format(target))
						sys.exit(0)
						
				else:
					target = os.path.join('smali', tail + '-mod')
					helper.copy(os.path.join('smali', tail), target)	
					treat_dir(target, code_to_inject)
				
				
				print('::INFO  Assembly {0} into classes.dex...'.format(os.path.join('smali', tail + '-mod')))
				sp1 = subprocess.Popen(['java', '-jar', os.path.join('modules', 'smali.jar'), os.path.join('smali', tail + '-mod'), 
										'-o', os.path.join('apps', 'classes.dex')], shell=True, env=nenv)
				sp1.wait()
				
				# We create an app-mod folder and erase its certificates
				zfile = zipfile.ZipFile(app).extractall(os.path.join('apps', tail + '-mod'))
				
				for root, subdirs, files in os.walk(os.path.join('apps', tail + '-mod', 'META-INF')):
					for file in files:
						file_path = os.path.join('apps', tail + '-mod', 'META-INF', file)
						if (file != 'MANIFEST.MF' and ('.RSA' in file or '.SF' in file)):
							os.remove(os.path.abspath(file_path))
				
				# We move the new classes.dex to the app-mod folder
				helper.move(os.path.join('apps' ,'classes.dex'), os.path.join('apps', tail + '-mod', 'classes.dex'))
				
				# We create the app-mod.zip, rename it to  app-mod.apk and remove the app-mod folder
				shutil.make_archive(os.path.join('apps', tail + '-mod'), 'zip', os.path.join('apps', tail + '-mod'))
				helper.move(os.path.join('apps', tail + '-mod.zip'), os.path.join('apps', tail + '-mod.apk'))
				shutil.rmtree(os.path.join('apps', tail + '-mod'))
				
				# We sign the app-mod.apk with our certificate
				print('::INFO  Signing {0}... \n'.format(tail + '-mod.apk'))
				sp1 = subprocess.Popen(['jarsigner', '-verbose', '-sigalg', 'SHA1withRSA', 
										'-digestalg', 'SHA1', '-keystore', './modules/my-release-key.keystore', 
										'-storepass', 'password', os.path.join('apps', tail + '-mod.apk'), 
										'alias_name'], shell=True, stdout=subprocess.DEVNULL, env=nenv)
				sp1.wait()
				
			else:
				print('\n::WARN  Incorrect usage [-i]: smali-code-injector -h for help \n')
				sys.exit(0)		
		
		else:
			print('::WARN  {0} does not exist/is not valid, please try again... \n' .format(app))
			sys.exit(0)
		
	elif (args.target and args.code_to_inject):
		target = args.target
		
		if ((os.path.exists(target)) and (os.path.isdir(target) or \
		(os.path.isfile(target) and target.endswith('.smali')))):
			inject_user_input = args.code_to_inject
			code_to_inject = check_inject_arg(inject_user_input)
			
			if (code_to_inject):			
				if (os.path.isdir(target)):
					treat_dir(target, code_to_inject)
				else:
					treat_file(target, code_to_inject)		
					
			else:
				print('Incorrect usage [-i]: smali-code-injector -h for help\n')
				sys.exit(0)	
				
		else:
			print('\n::WARN  {0} does not exist/is not valid, please try again... \n' .format(target))
			sys.exit(0)
	
	elif (args.target and args.check):
		target = args.target
		
		if ((os.path.exists(target)) and (os.path.isdir(target) or (os.path.isfile(target) and target.endswith('.smali')))):
			if (os.path.isdir(target)):
				print('\n::INFO  Creation of metadata...')
				my_metadata = metadata.create_metadata(target)
				metadata.check_dir(os.path.basename(target), my_metadata)
	
			else:
				print('\n::INFO  Creation of metadata...')
				file_metadata = metadata.create_file_metadata(target)
				metadata.check_file(os.path.basename(target), file_metadata)
				
	else:
		print('::WARN  Incorrect usage: smali-code-injector -h for help \n')
		sys.exit(0)
		
if __name__ == '__main__':
	main()
