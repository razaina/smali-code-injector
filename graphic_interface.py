import os
import sys
import process
import metadata
import helper

def display_banner():

	banner = '\t                     _ _                     _            _        _           _               \n' + \
			 '\t ___ _ __ ___   __ _| (_)       ___ ___   __| | ___      (_)_ __  (_) ___  ___| |_ ___  _ __   \n' + \
			 '\t/ __| "_ ` _ \ / _` | | |_____ / __/ _ \ / _` |/ _ \_____| | "_ \ | |/ _ \/ __| __/ _ \| "__|  \n' + \
			 '\t\__ \ | | | | | (_| | | |_____| (_| (_) | (_| |  __/_____| | | | || |  __/ (__| || (_) | |     \n' + \
			 '\t|___/_| |_| |_|\__,_|_|_|      \___\___/ \__,_|\___|     |_|_| |_|/ |\___|\___|\__\___/|_|     \n' + \
			 '\t                                                                |__/                           \n'
	print(banner)  
	  
def copyright():
	
	copyright = '\t\t\t[---] The Smali Hacking Toolkit (smali-code-injector) [---] \n' + \
				'\t\t\t[---]       Created by: Alexandre Teyar (Ares)        [---] \n' + \
				'\t\t\t[---]                 Version: 0.2                    [---] \n' + \
				'\t\t\t[---]         Follow me on github: @AresS31           [---] \n' 
	print(copyright)
	
def main_menu():
	bool = False
	menu = 	'\nSelect from the menu: \n' 			+ \
				'\t1)  Inject a custom code \n'  			+ \
				'\t2)  Check directory/.smali file for injected codes \n'  			+ \
				'\t3)  Edit the .smali file containing the injectable custom codes \n'  + \
				'\t99) Exit from the script \n' + \
				'\tPress ctrl+c to escape at anytime \n'
			
	display_banner()
	copyright()
	
	while (not bool):
		print(menu)
		choice = input('>> ')
		
		if (choice == '1'):
			bool = True
			inject_menu()
			
		elif (choice == '2'):
			bool = True
			check_menu()
			
		elif (choice == '3'):
			bool = True
			os.startfile(os.path.abspath('./smali/Class.smali'))
			main_menu()
			
		elif (choice == '99'):
			sys.exit(0)
				
def inject_menu():
	bool = False
	bool1 = False
	formatted_injectable_code = helper.format_injectable_codes('./smali/Logger.smali')
	formatted_injectable_code.extend( helper.format_injectable_codes('./smali/Hacker.smali'))
	
	while (not bool):		
		print('\nEnter a valid directory/.smali file path - absolute or relative -: \n')
		target = input('>> ')
		
		if ((os.path.exists(target)) and (os.path.isdir(target) \
		or (os.path.isfile(target) and target.endswith('.smali')))):
			bool = True
			menu = '\nSelect a code to inject: \n' 
			
			for injectable_code in formatted_injectable_code:
				menu = menu + injectable_code + '\n'  
			
			while (not bool1):
				print(menu)
				choice = input('>> ')
				
				for injectable_code in formatted_injectable_code:
					if (choice in injectable_code):
						words = injectable_code.split(')  ')
						code_to_inject = words[-1]
						bool1 = True
			
			inject_submenu(target, code_to_inject)
	
		else:
			print('\n::WARN  {0} does not exist/is not valid, please try again... ' .format(target))
			bool = False
			
def inject_submenu(target, code_to_inject):
	class_file_path = None
	bool = False
	menu = 	'\nSelect an injection option: \n' + \
			'\t1)  Inject everywhere \n' + \
			'\t2)  Inject into specific methods \n' 
	
	while (not bool):	
		print(menu)
		choice = input('>> ')
		
		if (choice == '1'):
			bool = True
			
			print('\n::INFO  Creation of metadata...')
			
			if (os.path.isdir(target)):
				my_metadata = metadata.create_metadata(target)
				class_file_path = process.copy_class_file(target)
				process.process_dir(target, class_file_path, my_metadata, code_to_inject)
				process.processed_dir_info(os.path.basename(target), code_to_inject, my_metadata)
			
			else:
				print(target)
				file_metadata = metadata.create_file_metadata(target)
				class_file_path = process.copy_class_file(os.path.dirname(target))
				process.process_file(target, file_metadata, code_to_inject)
				process.processed_file_info(os.path.basename(target), code_to_inject, file_metadata)
			
		elif (choice == '2'):
			keywords = []
			networking_kws_list = ['apache', 'bouncycastle', 'cert', 'client', 'http', 'inet', 'network', 'socket', 'ssl', 'url', 'x509']
			bool = True
			submenu=	'\nEnter a keywords list - a list of method names, for example - separated by the \',\' char, or use a pre-compiled list: \n' 	+ \
						'-------------------------\n' + \
						'Pre-compiled lists: \n' + \
						'\t1) Networking \n' + \
						'-------------------------\n'
			
			print(submenu)
			choice = input('>> ')
			
			print('\n::INFO  Creation of metadata...')
			
			if (choice == '1' and choice.isdigit()):
				keywords = networking_kws_list
				
				if (os.path.isdir(target)):
					my_metadata = metadata.create_metadata(target)
					class_file_path = process.copy_class_file(target)
					process.process_dir(target, class_file_path, my_metadata, code_to_inject, keywords)
					process.processed_dir_info(os.path.basename(target), code_to_inject, my_metadata)
					
				else:
					file_metadata = metadata.create_file_metadata(target)
					class_file_path = process.copy_class_file(os.path.dirname(target))
					process.process_file(target, file_metadata, code_to_inject, keywords)
					process.processed_file_info(os.path.basename(target), code_to_inject, file_metadata)
				
				
			else:
				keywords = choice.split(',')
				
				if (os.path.isdir(target)):
					my_metadata = metadata.create_metadata(target)
					class_file_path = process.copy_class_file(target)
					process.process_dir(target, class_file_path, my_metadata, code_to_inject, keywords)
					process.processed_dir_info(os.path.basename(target), code_to_inject, my_metadata)
				
				else:
					file_metadata = metadata.create_file_metadata(target)
					class_file_path = process.copy_class_file(os.path.dirname(target))
					process.process_file(target, file_metadata, code_to_inject, keywords)
					process.processed_file_info(os.path.basename(target), code_to_inject, file_metadata)
		
		else:
			bool = False
	
def check_menu():
	bool = False
	
	while (not bool):
		print('\nEnter a valid directory/.smali file path - absolute or relative -: \n')
		target = input('>> ')
		
		if ((os.path.exists(target)) and (os.path.isdir(target) \
		or (os.path.isfile(target) and target.endswith('.smali')))):
			bool = True
			menu = '\nSearch for injected code: \n' 
	
			if (os.path.isdir(target)):
				my_metadata = {}
				print('\n::INFO  Creation of metadata...')
				my_metadata = metadata.create_metadata(target)
				metadata.check_dir(os.path.basename(target), my_metadata)
				
			else:
				file_metadata = {}
				print('\n::INFO  Creation of metadata...')
				file_metadata = metadata.create_file_metadata(target)
				metadata.check_file(os.path.basename(target), file_metadata)
			
		else:
			print('\n::WARN  {0} does not exist/is not valid, please try again... ' .format(target))
			bool = False		
	