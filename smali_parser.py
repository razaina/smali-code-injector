import re
import helper
		
def get_var_from_line(line):
	'''
	Search any variable into a code line.
	
	:param 	line:	code line to search in
	:type		line:	str
	'''		
	regs = []
	pattern = r'^{?,?[vp]\d+,?}?,?$'
	words = line.split()
	
	for word in words:
		match = re.match(pattern, word)
		if match:
			regs.append(helper.clean_reg_name(word, [',', '{', '}']))
	
	return regs

def get_injected_method(line):
	words = line.split()
	
	return words[1]
