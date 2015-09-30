import fnmatch
import os
import smali_parser

def check_file(file_name, file_metadata):
	count = {}
	
	print('::INFO  Checking...')
	with open('./logs/' + file_name + '_checking-log.txt', 'w') as file:
		for method in file_metadata:
			if (method[5]):
				for injected_code in method[5]:
					if (injected_code in count):
						count[injected_code] += 1
					else:
						count[injected_code] = 1
							
					file.write(method[0] + '->' + method[1] + '\n')
	
	if (count):
		for injected_code in count:
			print('::INFO  {0} is injected into {1}/{2} methods' .format(injected_code, count[injected_code], len(file_metadata))) 
	else:
		print('::INFO  No injected code found')
		
	print('::INFO  logfile created at {0} \n'.format(os.path.abspath(file.name))) 
	
def check_dir(dir_name, my_metadata):
	count = {}
	meth_number = 0
	
	print('::INFO  Checking...')
	with open('./logs/' + dir_name + '_checking-log.txt', 'w') as file:
		for key, value in my_metadata.items():
			for method in value:
				meth_number += 1
				if (method[5]):
					for injected_code in method[5]:
						if (injected_code in count):
							count[injected_code] += 1
						else:
							count[injected_code] = 1
								
						file.write(method[0] + '->' + method[1] + '\n')
	
	if (count):
		for injected_code in count:
			print('::INFO  {0} is injected into {1}/{2} methods' .format(injected_code, count[injected_code], meth_number)) 
	else:
		print('::INFO  No injected code found') 
		
	print('::INFO  logfile created at {0} \n'.format(os.path.abspath(file.name)))  
	
def get_meth_data(method_name, file_metadata):
	'''
	Return the information of a method from a metadata file.
	
	:param	file_path:		path of a .smali file
	:param metadata:		empty dictionary
	:type 	root_path:		str
	:type 	metadata:		dict
	:return: 						list of the variable used inside a method
	:rtype:						list
	'''
	for method_data in file_metadata:
		if (method_name == method_data[1]):
			return method_data
			
def create_file_metadata(file_path):
	'''
	Extract the information concerning the methods inside of a .smali 
	file ([method name, reg number, [variables], class name]).
	
	:param	root_path:	path of the root folder
	:param 	metadata:	empty dictionary
	:type 	metadata:	dict
	:type 	root_path:	str
	:return: 				dictionary which contains the metadata of all the methods inside 
	of a root folder
	:rtype:					dict
	'''	
	with open(file_path, "r") as file:	
		file_metadata = {}
		methods = []
		regs = []
		returned_reg = {}	
		injected_codes = []
		monitor_function = False
		inside = False		
		
		for line in file:
			if (line.find('.class ') == 0):
				words = line.split()
				class_name = words[-1]
			
			# We ignore the abstract methods
			elif ((line.find('.method ') == 0) and (line.find('abstract ') < 0)):
				# We get the method name
				words = line.split()
				method_name = words[-1]
				
				# We get the returned reg type from the method name
				words1  = method_name.split(')')
				returned_reg['reg_type'] = words1[-1]
				
				inside = True
			
			# We check if any code has previsouly been injected to the method
			if ((line.find('has been injected on ') > 0) and (inside)):
				words = line.split()
				injected_codes.append(words[1])
			
			# monitor-enter, monitor-exit and return-wide screw the things up!
			if (((line.find('monitor-enter ') > 0) or (line.find('return-wide ') > 0)) and (inside)):
				monitor_function = True	
				
			elif ((line.find('return', 0, 20) > 0) and (inside)):
				words = line.split()
				
				if (len(words) > 1):
					returned_reg['reg'] = words[-1]
					regs.extend([words[-1]])
				# return-void case
				else:
					returned_reg['reg'] = 'v-1'
				
			elif ((line.find('.end method') == 0) and (inside)):
				regs = sorted(set(regs))
				# In the case where the method contains no return statement 
				if (len(returned_reg) < 2):
					returned_reg['reg'] = 'v-1'
					
				# Store the data related to the current methods
				methods.append([class_name, method_name, regs, returned_reg, monitor_function , injected_codes])
				
				# Reset the vars for the next method 
				regs = []	
				returned_reg = {}
				injected_codes = []
				monitor_function = False
				inside = False
						
			elif (inside):
				regs.extend(smali_parser.get_var_from_line(line))
				
			else:
				continue
		
		# dict containing data related to all the methods present in the file
		file_metadata[file_path] = methods
		
	return file_metadata[file_path]	
	
def create_metadata(dir_path):
	'''
	Extract the information concerning the methods inside of a .smali 
	file ([method name, reg number, [variables], class name]).
	
	:param	root_path:	path of the root folder
	:param 	metadata:	empty dictionary
	:type 	metadata:	dict
	:type 	root_path:	str
	:return: 				dictionary which contains the metadata of all the methods inside 
	of a root folder
	:rtype:					dict
	'''	
	my_metadata = {}
	
	for root, dirs, files in os.walk(dir_path):
		for file_name in fnmatch.filter(files, '*.smali'):
			file_path = os.path.join(root, file_name)
			my_metadata[file_path] = create_file_metadata(file_path)
	
	return my_metadata	