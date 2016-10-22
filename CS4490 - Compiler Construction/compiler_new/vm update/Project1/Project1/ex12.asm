S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S10                      .BYT                     'I'                      
S11                      .BYT                     'n'                      
S12                      .BYT                     A                        
S13                      .BYT                     'x'                      
S14                      .BYT                     '1'                      
S15                      .BYT                     ':'                      
S16                      .BYT                     20                       
S19                      .BYT                     '2'                      
S24                      .INT                     7                        
S27                      .BYT                     '3'                      
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
FREE                     .INT                     3252                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -28                  ; Space for Function
                          CMP R1, SL                   
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
g_Cat_Cat                 ADI SP, -16                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   
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
                          JMP g_Cat_StaticInit         
                          LDB R1, S10                  ; Write out char: S10
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S11                  ; Write out char: S11
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S12                  ; Write out char: S12
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S14                  ; Write out char: S14
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out int: V6
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; y -> x
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -12                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out int: V6
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
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
g_main                    ADI SP, -28                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 4                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -16                  
                          STR R4, R2                   ; Store T33
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   
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
                          LDR R1, S24                  ; 
                          STR R1, SP                   ; Store 4 bytes.
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_Cat                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T34 -> c
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -12                  
                          STR R1, R4                   
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S27                  ; Write out char: S27
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3
						  TRP 99
                          MOV R1, FP                   ; c + offset(x) -> T35
                          ADI R1, -12                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -24                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T35
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
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
