import serial
from bitstring import BitArray
import struct

def bytes_to_bits(byte_data):
    # Unpack the byte data to an integer
    num = struct.unpack('>B', byte_data)[0]
    # Format the number as a binary string
    return format(num, '08b')

# Example usage
byte_data = b'\x80'
bit_representation = bytes_to_bits(byte_data)
print(f"The bit representation of {byte_data} is {bit_representation}")


ser = serial.Serial('COM4', 115200, 8, stopbits=1)

while True:
    print(bytes_to_bits(ser.read()))

