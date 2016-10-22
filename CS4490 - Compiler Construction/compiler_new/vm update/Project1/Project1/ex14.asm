S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S8                       .INT                     5                        
S15                      .BYT                     'Z'                      
S17                      .BYT                     'a'                      
S18                      .INT                     2                        
S19                      .BYT                     'c'                      
S20                      .INT                     3                        
S21                      .BYT                     'k'                      
S23                      .BYT                     '!'                      
S25                      .BYT                     ':'                      
S26                      .BYT                     20                       
S27                      .BYT                     A                        
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
FREE                     .INT                     3919                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -65                  ; Space for Function
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
g_main                    ADI SP, -65                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; 1 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 5 -> arraySize
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S8                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4
                          LDR R1, S0                   ; sizeof(char) * S8 -> T33
                          LDR R2, S8                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T33) -> T34
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -31                  
                          STR R4, R2                   ; Store T34
                          MOV R1, FP                   ; T34 -> someChars
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -31                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4
						  TRP 99
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'Z' -> T35
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S15                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -35                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -39                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'a' -> T36
                          ADI R1, -39                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S17                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -39                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'c' -> T37
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S19                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'k' -> T38
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S21                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -47                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; '!' -> T39
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S23                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -51                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T40
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
begin41                   MOV R1, FP                   ; x <= arraySize -> T42
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L46                  ; L6 < L9 GOTO L46
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L46                  ; L6 < L9 GOTO L46
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -56                  
                          STB R3, R5                   
                          JMP L47                      
L46                       MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -56                  
                          STB R3, R5                   
L47                       MOV R1, FP                   ; BranchFalse T42, endWhile43
                          ADI R1, -56                  
                          LDB R1, R1                   
                          BNZ R1, endWhile43           ; Branch False
                          MOV R1, FP                   ; Write out int: L6
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S25                  ; Write out char: S25
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S26                  ; Write out char: S26
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -60                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T44
                          ADI R1, -60                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S27                  ; Write out char: S27
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x + 1 -> T45
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -64                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T45 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -64                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin41                  ; 
endWhile43                MOV SP, FP                   ; Test for Underflow
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
