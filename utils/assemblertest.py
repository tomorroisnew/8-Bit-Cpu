import sys

# First step, read the file, remove all comments and spaces
with open('simulation/test2.asm') as f:
    lines = f.read().splitlines()

# Remove Comments
removed_comments = []
for i in lines:
    if("//" in i):
        comment_index = i.find("//")
        removed_comments.append(i[:comment_index])
    else:
        removed_comments.append(i)

stripped = []
for i in removed_comments:
    if(i.strip() == ""):
        continue
    else:
        stripped.append(i.strip())

# Seperate the variable and the code part. Parse Variables
code = []
variables = {}
functions = {}

variables_list = []#Temporary list of variables to process
for i in stripped:
    code_index = stripped.index(".code")
    variables_index = stripped.index(".variables")
    code = stripped[code_index + 1:]
    variables_list = stripped[variables_index + 1 : code_index]

for i in variables_list:
    var_name, value = i.split('=')
    variables[var_name.strip()] = int(value.strip())

for i in code:
    if("tawag")

def processMicroCode(microcode: str):
    # The current MicroCodes are lagay which translate to lagay_itaas lagay_ibaba lipat sa register
    pass

# Expand MicroCodes into OpCodes
for i in code:
    print(i)