S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S14                      .BYT                     'p'                      
S15                      .BYT                     '1'                      
S16                      .BYT                     ':'                      
S17                      .BYT                     20                       
S27                      .BYT                     '2'                      
S38                      .BYT                     'a'                      
S40                      .BYT                     A                        
S41                      .BYT                     'r'                      
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
FREE                     .INT                     6259                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -34                  ; Space for Function
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
                          ADI R1, 4                    
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -13                  
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
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
g_Cat_makeKitties         ADI SP, -21                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDB R1, S14                  ; Write out char: S14
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S17                  ; Write out char: S17
                          MOV R0, R1                   ; load byt for print.
                          TRP 3
						  TRP 99
                          MOV R1, FP                   ; Write out char: P13
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 1                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -13                  
                          STR R4, R2                   ; Store T46
                          MOV R1, SP                   ; Create an activation record T46
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -13                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P13
                          ADI R1, -13                  
                          LDB R1, R1                   
                          ADI SP, -1                   
                          STB R1, SP                   ; Store 1 byte.
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Kitten_Kitten          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -17                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T47 -> k
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -17                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R6, FP                   ; 
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return V5
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
                          LDB R1, S17                  ; Write out char: S17
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S14                  ; Write out char: S14
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S27                  ; Write out char: S27
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S17                  ; Write out char: S17
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out char: P24
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; z -> c
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -13                  
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
                          ADI R2, -16                  
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
g_main                    ADI SP, -34                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 5                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -16                  
                          STR R4, R2                   ; Store T52
                          MOV R1, SP                   ; Create an activation record T52
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
                          LDB R1, S38                  ; PUSH S38
                          ADI SP, -1                   
                          STB R1, SP                   ; Store 1 byte.
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_Cat                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T53 -> c
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c + offset(c) -> T54
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 4                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T54
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S40                  ; Write out char: S40
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record L39
                          ADI R1, -21                  ; Space for Function
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
                          LDB R1, S41                  ; PUSH  S41
                          ADI SP, -1                   
                          STB R1, SP                   ; Store 1 byte.
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_makeKitties        
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -25                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; c + offset(k) -> T56
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -29                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c.k + offset(c) -> T57
                          ADI R1, -29                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -33                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T57
                          ADI R1, -33                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S40                  ; Write out char: S40
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
