S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S16                      .INT                     5                        
S21                      .BYT                     'x'                      
S22                      .BYT                     '1'                      
S23                      .BYT                     ':'                      
S24                      .BYT                     20                       
S25                      .BYT                     A                        
S27                      .BYT                     '2'                      
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
FREE                     .INT                     3457                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -25                  ; Space for Function
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
g_dog_factorial           ADI SP, -29                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; x <= 1 -> T34
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L42                  ; P8 < S0 GOTO L42
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L42                  ; P8 < S0 GOTO L42
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
                          JMP L43                      
L42                       MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
L43                       MOV R1, FP                   ; BranchFalse T34, skipif35
                          ADI R1, -20                  
                          LDB R1, R1                   
                          BNZ R1, skipif35             ; Branch False
                          LDR R1, S0                   ; 
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return S0
                          JMR R2                       ; goto rtn addr
skipif35                  MOV R1, FP                   ; x - 1 -> T36
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -29                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH T36
                          ADI R1, -24                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_dog_factorial          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, FP                   ; x * T37 -> T38
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -24                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -28                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T38 -> temp
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -28                  
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
                          STR R1, SP                   ; return L10
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
g_dog_StaticInit          ADI SP, -12                  
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
g_main                    ADI SP, -25                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; 5 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S16                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          LDB R1, S21                  ; Write out char: S21
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S22                  ; Write out char: S22
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S23                  ; Write out char: S23
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S24                  ; Write out char: S24
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out int: L17
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S25                  ; Write out char: S25
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record L20
                          ADI R1, -29                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -20                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH  L17
                          ADI R1, -15                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_dog_factorial          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -24                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; T41 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -24                  
                          LDR R2, R2                   
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          LDB R1, S21                  ; Write out char: S21
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S27                  ; Write out char: S27
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S23                  ; Write out char: S23
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S24                  ; Write out char: S24
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out int: L17
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S25                  ; Write out char: S25
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
