S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S8                       .INT                     5                        
S18                      .BYT                     'Z'                      
S20                      .BYT                     'a'                      
S21                      .INT                     2                        
S22                      .BYT                     'c'                      
S23                      .INT                     3                        
S24                      .BYT                     'k'                      
S26                      .BYT                     '!'                      
S28                      .BYT                     A                        
S35                      .BYT                     ':'                      
S36                      .BYT                     20                       
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
FREE                     .INT                     6887                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -123                 ; Space for Function
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
g_main                    ADI SP, -123                 
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; 0 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
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
                          LDR R1, S0                   ; sizeof(char) * L9 -> T50
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -31                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T50) -> T51
                          ADI R1, -31                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -35                  
                          STR R4, R2                   ; Store T51
                          MOV R1, FP                   ; T51 -> someChars
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -35                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; arraySize + 4 -> T54
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S1                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -39                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(int) * T54 -> T55
                          MOV R2, FP                   
                          ADI R2, -39                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T55) -> T56
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -47                  
                          STR R4, R2                   ; Store T56
                          MOV R1, FP                   ; T56 -> someInts
                          ADI R1, -27                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -47                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'Z' -> T57
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S18                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -51                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'a' -> T58
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S20                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -55                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S21                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'c' -> T59
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S22                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -59                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S23                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'k' -> T60
                          ADI R1, -63                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S24                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -63                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S1                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; '!' -> T61
                          ADI R1, -67                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S26                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -67                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S8                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R1, FP                   ; '\n' -> T62
                          ADI R1, -71                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S28                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -71                  
                          LDR R4, R4                   
                          STB R1, R4                   
begin63                   MOV R1, FP                   ; arraySize + 4 -> T64
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S1                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          MOV R1, FP                   ; x < T64 -> T65
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -75                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L84                  ; L6 < T64 GOTO L84
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -76                  
                          STB R3, R5                   
                          JMP L85                      
L84                       MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -76                  
                          STB R3, R5                   
L85                       MOV R1, FP                   ; BranchFalse T65, endWhile66
                          ADI R1, -76                  
                          LDB R1, R1                   
                          BNZ R1, endWhile66           ; Branch False
                          MOV R1, FP                   ; arraySize + 4 -> T67
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S1                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -80                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T67 - x -> T68
                          ADI R1, -80                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -84                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T68
                          ADI R1, -84                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S28                  ; Write out char: S28
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; compute address
                          ADI R1, -27                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -88                  
                          STR R1, R4                   
                          MOV R1, FP                   ; arraySize + 4 -> T70
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S1                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -92                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T70 - x -> T71
                          ADI R1, -92                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -96                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T71 -> T69
                          ADI R1, -88                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -96                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -88                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; x + 1 -> T72
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -100                 
                          STR R1, R4                   
                          MOV R1, FP                   ; T72 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -100                 
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin63                  ; 
endWhile66                MOV R1, FP                   ; 0 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
begin73                   MOV R1, FP                   ; x < arraySize -> T74
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L86                  ; L6 < L9 GOTO L86
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -101                 
                          STB R3, R5                   
                          JMP L87                      
L86                       MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -101                 
                          STB R3, R5                   
L87                       MOV R1, FP                   ; BranchFalse T74, endWhile75
                          ADI R1, -101                 
                          LDB R1, R1                   
                          BNZ R1, endWhile75           ; Branch False
                          MOV R1, FP                   ; Write out int: L6
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S35                  ; Write out char: S35
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S36                  ; Write out char: S36
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -105                 
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T76
                          ADI R1, -105                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S28                  ; Write out char: S28
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x + 1 -> T77
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -109                 
                          STR R1, R4                   
                          MOV R1, FP                   ; T77 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -109                 
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin73                  ; 
endWhile75                MOV R1, FP                   ; 0 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
begin78                   MOV R1, FP                   ; arraySize + 4 -> T79
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S1                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -113                 
                          STR R1, R4                   
                          MOV R1, FP                   ; x <= T79 -> T80
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -113                 
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L88                  ; L6 < T79 GOTO L88
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L88                  ; L6 < T79 GOTO L88
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -114                 
                          STB R3, R5                   
                          JMP L89                      
L88                       MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -114                 
                          STB R3, R5                   
L89                       MOV R1, FP                   ; BranchFalse T80, endWhile81
                          ADI R1, -114                 
                          LDB R1, R1                   
                          BNZ R1, endWhile81           ; Branch False
                          MOV R1, FP                   ; Write out int: L6
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S35                  ; Write out char: S35
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S36                  ; Write out char: S36
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; compute address
                          ADI R1, -27                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -118                 
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T82
                          ADI R1, -118                 
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S36                  ; Write out char: S36
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x + 1 -> T83
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -122                 
                          STR R1, R4                   
                          MOV R1, FP                   ; T83 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -122                 
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin78                  ; 
endWhile81                LDB R1, S28                  ; Write out char: S28
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
