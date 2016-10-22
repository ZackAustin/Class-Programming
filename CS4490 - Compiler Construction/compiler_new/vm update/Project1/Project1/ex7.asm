S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S5                       .INT                     -4                       
S7                       .INT                     10                       
S8                       .INT                     20                       
S10                      .BYT                     'y'                      
S11                      .BYT                     'n'                      
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
FREE                     .INT                     1757                     


                         LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                         LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                         MOV R1, SP                   ; Test Overflow
                         ADI R1, -21                  ; Space for Function
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
g_main                   ADI SP, -21                  
                         MOV R1, SP                   ; Test Overflow
                         CMP R1, SL                   
                         BLT R1, OVERFLOW             
                         MOV R1, FP                   ; -4 -> x
                         ADI R1, -12                  
                         LDR R1, R1                   
                         LDR R2, S5                   
                         MOV R1, R2                   ; Move Data.
                         MOV R4, FP                   
                         ADI R4, -12                  
                         STR R1, R4                   
                         MOV R1, FP                   ; x < 10 -> T13
                         ADI R1, -12                  
                         LDR R1, R1                   
                         LDR R2, S7                   
                         MOV R3, R1                   ; Move data into 3rd register for compare.
                         CMP R3, R2                   ; Compare Data.
                         BLT R3, L20                  ; L6 < S7 GOTO L20
                         MOV R3, R8                   ; Set FALSE
                         MOV R6, FP                   
                         ADI R6, -16                  
                         STB R3, R6                   
                         JMP L21                      
L20                      MOV R3, R7                   ; Set TRUE
                         MOV R6, FP                   
                         ADI R6, -16                  
                         STB R3, R6                   
L21                      MOV R1, FP                   ; x < 20 -> T14
                         ADI R1, -12                  
                         LDR R1, R1                   
                         LDR R2, S8                   
                         MOV R3, R1                   ; Move data into 3rd register for compare.
                         CMP R3, R2                   ; Compare Data.
                         BLT R3, L22                  ; L6 < S8 GOTO L22
                         MOV R3, R8                   ; Set FALSE
                         MOV R6, FP                   
                         ADI R6, -17                  
                         STB R3, R6                   
                         JMP L23                      
L22                      MOV R3, R7                   ; Set TRUE
                         MOV R6, FP                   
                         ADI R6, -17                  
                         STB R3, R6                   
L23                      MOV R1, FP                   ; T13 || T14 -> T15
                         ADI R1, -16                  
                         LDB R1, R1                   
                         MOV R2, FP                   
                         ADI R2, -17                  
                         LDB R2, R2                   
                         MOV R3, R1                   
                         OR R3, R2                   
                         MOV R6, FP                   
                         ADI R6, -18                  
                         STB R3, R6                   
                         MOV R1, FP                   ; T15 && T16 -> T17
                         ADI R1, -18                  
                         LDB R1, R1                   
                         MOV R2, FP                   
                         ADI R2, -19                  
                         LDB R2, R2                   
                         MOV R3, R1 
						 TRP 99
                         AND R3, R2                   
                         MOV R6, FP                   
                         ADI R6, -20                  
                         STB R3, R6                   
                         MOV R1, FP                   ; BranchFalse T17, skipif18
                         ADI R1, -20                  
                         LDB R1, R1                   
                         BNZ R1, skipif18             ; Branch False
                         LDB R1, S10                  ; 
                         MOV R0, R1                   ; load byt for print.
                         TRP 3                        
                         STB R0, S10                  
                         JMP skipelse19               ; Generate as Part of ELSE
skipif18                 LDB R1, S11                  ; 
                         MOV R0, R1                   ; load byt for print.
                         TRP 3                        
                         STB R0, S11                  
skipelse19               MOV SP, FP                   ; Test for Underflow
                         MOV R1, SP                   
                         CMP R1, SB                   
                         BGT R1, UNDERFLOW            
                         LDR R1, FP                   ; rtn addr
                         MOV R2, FP                   
                         ADI R2, -4                   
                         LDR FP, R2                   ; PFP -> FP
                         JMR R1                       ; goto rtn addr
OVERFLOW                 LDB R0, O                    ; output something if overflow occurs.
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
UNDERFLOW                LDB R0, U                    ; output something if underflow occurs.
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
