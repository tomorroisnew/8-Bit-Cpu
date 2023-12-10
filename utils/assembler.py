import sys

registers = {
    '$1': '00',
    '$2': '01',
    '$3': '10',
    '$4': '11' 
}

RTYPE = 0
IMMTYPE = 1
JTYPE = 2
NOTYPE = 3

opcodes = {
    'halt': ('0000', IMMTYPE),
    'lagay_itaas': ('0001', IMMTYPE),
    'lagay_ibaba': ('0010', IMMTYPE),
    'basa_mula_mem': ('0011', RTYPE),
    'lagay_sa_mem': ('0100', RTYPE),
    'lipat': ('0101', RTYPE),
    'dagdag': ('0110', RTYPE),
    'hindi_tsaka': ('0111', RTYPE),
    'tsaka': ('1000', RTYPE),
    'o_kaya': ('1001', RTYPE),
    'xor': ('1010', RTYPE),
    'tawag': ('1011', JTYPE),
    'tawag_kung_zero': ('1100', JTYPE),
    'balik': ('1101', IMMTYPE),
    'sanga': ('1110', IMMTYPE),
    'sanga_kung_zero': ('1111', IMMTYPE)
}

def parse(assembly: str):
    try:
        assem = assembly.split(' ', maxsplit=1)
        opcode = assem[0]
        param = assem[1]
    except:
        return None
    
    toReturn = None
    if(opcode in opcodes):
        if (opcodes[opcode][1] == RTYPE):
            params = param.split(',')
            return opcodes[opcode][0] + registers[params[0].strip()] + registers[params[1].strip()]
        elif(opcodes[opcode][1] == IMMTYPE):
            return opcodes[opcode][0] + param
        elif(opcodes[opcode][1] == JTYPE):
            return opcodes[opcode][0] + '00' + registers[param.strip()]

assembled = []

with open(f'{sys.argv[1]}') as f:


    for line in f:
        parsed = parse(line.strip())
        if(parsed != None):
            assembled.append(parsed)

with open('simulation/out.txt', 'w') as f:
    for line in assembled:
        f.write(f"{line}\n")
