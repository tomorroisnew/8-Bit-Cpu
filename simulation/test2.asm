.variables
    Led_Addresses = 251
    Led_Value = 0

.code    
    lagay $1, Led_Value
    tawag :function1
.function1
    lagay $4, Led_Addresses
    lagay_sa_mem $1, $4