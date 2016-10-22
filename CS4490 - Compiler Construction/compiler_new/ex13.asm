S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S19                      .INT                     5                        
S74                      .BYT                     'a'                      
S76                      .BYT                     A                        
S78                      .BYT                     'r'                      
S79                      .BYT                     '^'                      
S83                      .INT                     12                       
S84                      .BYT                     20                       
S85                      .INT                     15                       
S86                      .INT                     25                       
O                        .BYT                     'O'                      
v                        .BYT                     'v'                      
e                        .BYT                     'e'                      
r                        .BYT                     'r'                      
f                        .BYT                     'f'                      
l                        .BYT                     'l'                      
o                        .BYT                     'o'                      
w                        .BYT                     'w'                      
U                        .BYT                     'U'                      
n                        .BYT                     'n'                      
d                        .BYT                     'd'                      
FREE                     .INT                     12924                    


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -84                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_main                   
                          TRP 0                        
g_Cat_Cat                 ADI SP, -13                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R2, R9                   ; Old Frame to R2
                          ADI R2, -8                   ; address of this
                          LDR R2, R2                   ; value of this
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_StaticInit         
                          MOV R6, FP                   ; a -> c
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 7                    
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -12                  
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 7                    
                          STB R1, R4                   
                          MOV R6, FP                   ; 5 -> i
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 8                    
                          LDR R1, R1                   
                          LDR R2, S19                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 8                    
                          STR R1, R4                   
                          MOV R1, FP                   
                          ADI R1, -8                   
                          LDR R1, R1                   ; this -> R1
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return this
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Cat_makeKitties         ADI SP, -21                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 13                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -16                  
                          STR R4, R2                   ; Store T95
                          MOV R1, SP                   ; Create an activation record T95
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -16                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P22
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Kitten_Kitten          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T96 -> k
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 2                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 2                    
                          STR R1, R4                   
                          MOV R6, FP                   ; 
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 2                    
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return V9
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Cat_makeAnonymousDog    ADI SP, -28                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 4                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -23                  
                          STR R4, R2                   ; Store T98
                          MOV R1, SP                   ; Create an activation record T98
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -23                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P25
                          ADI R1, -15                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Dog_Dog                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T99 -> d
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -27                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return L26
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Cat_StaticInit          ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Kitten_Kitten           ADI SP, -13                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R2, R9                   ; Old Frame to R2
                          ADI R2, -8                   ; address of this
                          LDR R2, R2                   ; value of this
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Kitten_StaticInit      
                          MOV R6, FP                   ; z -> c
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 2                    
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -12                  
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 2                    
                          STB R1, R4                   
                          MOV R1, FP                   
                          ADI R1, -8                   
                          LDR R1, R1                   ; this -> R1
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return this
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Kitten_makeAMonster     ADI SP, -21                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 1                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -16                  
                          STR R4, R2                   ; Store T108
                          MOV R1, SP                   ; Create an activation record T108
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -16                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P47
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_alienKitten_alienKitten
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T109 -> ak
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 8                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 8                    
                          STR R1, R4                   
                          MOV R6, FP                   ; 
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 8                    
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return V39
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Kitten_StaticInit       ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_alienKitten_alienKitten ADI SP, -13                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R2, R9                   ; Old Frame to R2
                          ADI R2, -8                   ; address of this
                          LDR R2, R2                   ; value of this
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_alienKitten_StaticInit 
                          MOV R6, FP                   ; passedInSomething -> weirdSymbol
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -12                  
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STB R1, R4                   
                          MOV R1, FP                   
                          ADI R1, -8                   
                          LDR R1, R1                   ; this -> R1
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return this
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_alienKitten_StaticInit  ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Dog_Dog                 ADI SP, -16                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R2, R9                   ; Old Frame to R2
                          ADI R2, -8                   ; address of this
                          LDR R2, R2                   ; value of this
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Dog_StaticInit         
                          MOV R6, FP                   ; y -> x
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R1, FP                   
                          ADI R1, -8                   
                          LDR R1, R1                   ; this -> R1
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return this
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Dog_makeAnonymousCatDog ADI SP, -28                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 4                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -23                  
                          STR R4, R2                   ; Store T115
                          MOV R1, SP                   ; Create an activation record T115
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -23                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P64
                          ADI R1, -15                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_CatDog_CatDog          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T116 -> cd
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -27                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return L65
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Dog_StaticInit          ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_CatDog_CatDog           ADI SP, -16                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R2, R9                   ; Old Frame to R2
                          ADI R2, -8                   ; address of this
                          LDR R2, R2                   ; value of this
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_CatDog_StaticInit      
                          MOV R6, FP                   ; ywey -> q
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R1, FP                   
                          ADI R1, -8                   
                          LDR R1, R1                   ; this -> R1
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return this
                          JMR R2                       ; goto rtn addr
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_CatDog_StaticInit       ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_main                    ADI SP, -84                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 12                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -19                  
                          STR R4, R2                   ; Store T119
                          MOV R1, SP                   ; Create an activation record T119
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -19                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDB R1, S74                  ; PUSH S74
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_Cat                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T120 -> c
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c + offset(c) -> T121
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 7                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T121
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S76                  ; Write out char: S76
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(i) -> T122
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 8                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -31                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T122
                          ADI R1, -31                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S76                  ; Write out char: S76
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record L75
                          ADI R1, -21                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -15                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDB R1, S78                  ; PUSH  S78
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_makeKitties        
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record T123
                          ADI R1, -21                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -35                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDB R1, S79                  ; PUSH  S79
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Kitten_makeAMonster    
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -39                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.makeKitties.makeAMonster + offset(weirdSymbol) -> T125
                          ADI R1, -39                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T125
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S76                  ; Write out char: S76
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(k) -> T126
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 2                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.k + offset(c) -> T127
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 2                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T127
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S76                  ; Write out char: S76
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(k) -> T128
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 2                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.k + offset(ak) -> T129
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 8                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.k.ak + offset(weirdSymbol) -> T130
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T130
                          ADI R1, -63                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S76                  ; Write out char: S76
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record L75
                          ADI R1, -28                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -15                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S83                  ; PUSH  S83
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_makeAnonymousDog   
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.makeAnonymousDog + offset(x) -> T132
                          ADI R1, -67                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T132
                          ADI R1, -71                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S84                  ; Write out char: S84
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record L75
                          ADI R1, -28                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -15                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S85                  ; PUSH  S85
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_makeAnonymousDog   
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record T133
                          ADI R1, -28                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -75                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S86                  ; PUSH  S86
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Dog_makeAnonymousCatDog
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -79                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.makeAnonymousDog.makeAnonymousCatDog + offset(q) -> T135
                          ADI R1, -79                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -83                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T135
                          ADI R1, -83                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S76                  ; Write out char: S76
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
OVERFLOW                  LDB R0, O                    ; output something if overflow occurs.
                          TRP 3                        
                          LDB R0, v                    
                          TRP 3                        
                          LDB R0, e                    
                          TRP 3                        
                          LDB R0, r                    
                          TRP 3                        
                          LDB R0, f                    
                          TRP 3                        
                          LDB R0, l                    
                          TRP 3                        
                          LDB R0, o                    
                          TRP 3                        
                          LDB R0, w                    
                          TRP 3                        
                          TRP 0                        
UNDERFLOW                 LDB R0, U                    ; output something if underflow occurs.
                          TRP 3                        
                          LDB R0, n                    
                          TRP 3                        
                          LDB R0, d                    
                          TRP 3                        
                          LDB R0, e                    
                          TRP 3                        
                          LDB R0, r                    
                          TRP 3                        
                          LDB R0, f                    
                          TRP 3                        
                          LDB R0, l                    
                          TRP 3                        
                          LDB R0, o                    
                          TRP 3                        
                          LDB R0, w                    
                          TRP 3                        
                          TRP 0                        
