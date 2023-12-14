// Jump to display_uart function.
// The address of display_uart is stored in $2
lagay_itaas 0011
lagay_ibaba 0000
lipat $2, $4

// "H"
lagay_itaas 0100
lagay_ibaba 1000
lipat $1, $4
tawag $2

// "e"
lagay_itaas 0110
lagay_ibaba 0101
lipat $1, $4
tawag $2    

// "l"
lagay_itaas 0110
lagay_ibaba 1100
lipat $1, $4
tawag $2    

// "l"
lagay_itaas 0110
lagay_ibaba 1100
lipat $1, $4
tawag $2    

// "o"
lagay_itaas 0110
lagay_ibaba 1111
lipat $1, $4
tawag $2    

// "Space"
lagay_itaas 0010
lagay_ibaba 0000
lipat $1, $4
tawag $2    

// "W"
lagay_itaas 0101
lagay_ibaba 0111
lipat $1, $4
tawag $2   

// "o"
lagay_itaas 0110
lagay_ibaba 1111
lipat $1, $4
tawag $2  

// "r"
lagay_itaas 0111
lagay_ibaba 0010
lipat $1, $4
tawag $2  

// "l"
lagay_itaas 0110
lagay_ibaba 1100
lipat $1, $4
tawag $2  

// "d"
lagay_itaas 0110
lagay_ibaba 0100
lipat $1, $4
tawag $2  

halt 0000 //Stop

//display_uart function
//Check if uart is not busy. If it is, loop back until its not
lagay_itaas 1111
lagay_ibaba 1111
basa_mula_mem $3, $4 // Read the status register of the Uart
lagay_itaas 0000
lagay_ibaba 0001
xor $3, $4 // Xor. Used to compare if two values is equal. I compared it against 00000000 because zero means its not busy
sanga_kung_zero_signed 1010 // Looop back at the start if the comparison return zero

// Store the character you want to display in $1
lagay_itaas 1111
lagay_ibaba 1100 //Store Address of the DataInBuffer of the Uart in $4
lagay_sa_mem $1, $4

// Set First Bit of the Control Register to 1. To start sending
lagay_itaas 1111
lagay_ibaba 1110
lipat $3, $4 // Address of control Register
lagay_itaas 0000
lagay_ibaba 0001 // Value of Control Register
lagay_sa_mem $4, $3

//Return
balik 0000