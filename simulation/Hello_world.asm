// Jump to display_uart function.
// The address of display_uart is stored in $2
lagay_itaas 0000
lagay_ibaba 1000
lipat $2, $4

// "H"
lagay_itaas 0100
lagay_ibaba 1000
lipat $1, $4
tawag $2

halt 0000 //Stop

//display_uart
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