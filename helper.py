import os
import re
import fnmatch
import shutil
import errno

def copy(src, dest):
	if os.path.exists(dest):
		shutil.rmtree(dest)
		
	try:
		shutil.copytree(src, dest)
	except OSError as e:
		# If the error was caused because the source wasn't a directory
		if e.errno == errno.ENOTDIR:
			shutil.copy(src, dest)
			
		else:
			print('Directory not copied. Error: %s' % e)
			exit(0)
						
def move(src, dest):
    if os.path.exists(dest):
        os.remove(dest)
		
    shutil.move(src, dest)
	
def get_injectable_codes():
	injectable_codes = []
	
	for root, dirs, files in os.walk(os.path.join('smali', 'ares')):		
		for file in fnmatch.filter(files, '*.smali'):
			file_path = os.path.join(root, file)
			
			with open(file_path, 'r') as file:	
				for line in file:
						if (line.find('#injectable') > 0):
							words = line.split()
							injectable_codes.append(words[-2])

	return injectable_codes

def get_valid_regs(returned_reg, regs):
	valid_regs = []

	for reg in regs:
		if ((reg[0] == 'v') and (reg != returned_reg) and (int(reg[1:]) < 16)):
			valid_regs.append(reg)
		
	return valid_regs

def get_reg_max_index(regs):
	index = -1
	max_index = -1
	
	if not regs:
		max_index = -1
		return max_index
		
	else:
		for reg in regs:
			index = int(reg[1:])
			if (index > max_index):
				max_index = index
					
	return max_index
	
def clean_reg_name(reg, list):
	for char in list:
		reg = reg.replace(char, '')
		
	return reg
