S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S17                      .INT                     2                        
S35                      .INT                     1000                     
S39                      .INT                     512                      
S41                      .INT                     256                      
S45                      .INT                     100                      
S46                      .BYT                     '5'                      
S47                      .INT                     10                       
S49                      .INT                     7                        
S50                      .BYT                     'c'                      
S66                      .BYT                     '>'                      
S67                      .BYT                     A                        
S70                      .INT                     5                        
S71                      .INT                     -1                       
S73                      .BYT                     0                        
S75                      .INT                     3                        
S83                      .INT                     200                      
S84                      .INT                     300                      
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
FREE                     .INT                     11468                    


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -92                  ; Space for Function
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
g_DemoC_DemoC             ADI SP, -12                  
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
                          JMP g_DemoC_StaticInit       
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_DemoC_fib               ADI SP, -26                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; k == 0 -> T91
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L166                 ; P12 < S2 GOTO L166
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -16                  
                          STB R3, R6                   
                          JMP L167                     
L166                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -16                  
                          STB R3, R6                   
L167                      MOV R1, FP                   ; BranchFalse T91, skipif92
                          ADI R1, -16                  
                          LDB R1, R1                   
                          BNZ R1, skipif92             ; Branch False
                          MOV R1, FP                   ; 
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return P12
                          JMR R2                       ; goto rtn addr
                          JMP skipelse93               ; Generate as Part of ELSE
skipif92                  MOV R1, FP                   ; k == 1 -> T94
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L168                 ; P12 < S0 GOTO L168
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -17                  
                          STB R3, R6                   
                          JMP L169                     
L168                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -17                  
                          STB R3, R6                   
L169                      MOV R1, FP                   ; BranchFalse T94, skipif95
                          ADI R1, -17                  
                          LDB R1, R1                   
                          BNZ R1, skipif95             ; Branch False
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
                          JMP skipelse93               ; Generate as Part of ELSE
skipif95                  MOV R1, FP                   ; k - 1 -> T97
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -18                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -26                  ; Space for Function
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; 
                          ADI R1, -18                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Store 4 bytes.
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_DemoC_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -22                  
                          STR R1, R4                   
                          MOV R1, FP                   ; k - 2 -> T99
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S17                  
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -22                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -26                  ; Space for Function
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; 
                          ADI R1, -22                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Store 4 bytes.
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_DemoC_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -26                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T98 + T100 -> T101
                          ADI R1, -22                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -26                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -26                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -26                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return T101
                          JMR R2                       ; goto rtn addr
skipelse93                MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_DemoC_StaticInit        ADI SP, -12                  
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
g_Syntax_Syntax           ADI SP, -17                  
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
                          JMP g_Syntax_StaticInit      
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Syntax_checkit          ADI SP, -64                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R1, S0                   ; sizeof(char) * S35 -> T110
                          LDR R2, S35                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T111 -> cc
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -28                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -12                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(int) * S39 -> T114
                          LDR R2, S39                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -32                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T115 -> ii
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -36                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(pointer) * S41 -> T116
                          LDR R2, S41                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -40                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T117 -> ss
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -44                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T119 -> T118
                          ADI R1, -48                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -49                  
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -48                  
                          STB R1, R4                   
                          MOV R1, FP                   ; '5' -> T120
                          ADI R1, -50                  
                          LDB R1, R1                   
                          LDB R2, S46                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -50                  
                          STB R1, R4                   
                          MOV R1, FP                   ; c -> T121
                          ADI R1, -51                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, 4                    
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STB R1, R4                   
                          MOV R1, FP                   ; ii -> ii
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -16                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Test Overflow
                          ADI R1, -17                  ; Space for Function
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          STR R2, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S49                  ; 
                          STR R1, SP                   ; Store 4 bytes.
                          ADI SP, -4                   
                          LDB R1, S50                  ; 
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Syntax_Syntax          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -60                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T124 -> T122
                          ADI R1, -52                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -60                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -52                  
                          STR R1, R4                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Syntax_which            ADI SP, -20                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; i * i -> T128
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -12                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T128 -> i
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -16                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -12                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return P54
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
g_Syntax_StaticInit       ADI SP, -12                  
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
g_main                    ADI SP, -92                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; 2 -> two
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDR R2, S17                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          LDB R1, S66                  ; 
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          STB R0, S66                  
                          MOV R1, FP                   ; 
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; read int for print.
                          TRP 2                        
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STR R0, R5                   
                          LDB R1, S67                  ; 
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          STB R0, S67                  
begin133                  MOV R1, FP                   ; k != 0 -> T134
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BNZ R3, L170                 ; L57 < S2 GOTO L170
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -32                  
                          STB R3, R6                   
                          JMP L171                     
L170                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -32                  
                          STB R3, R6                   
L171                      MOV R1, FP                   ; BranchFalse T134, endWhile135
                          ADI R1, -32                  
                          LDB R1, R1                   
                          BNZ R1, endWhile135          ; Branch False
                          MOV R1, FP                   ; k != 0 -> T136
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BNZ R3, L172                 ; L57 < S2 GOTO L172
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -33                  
                          STB R3, R6                   
                          JMP L173                     
L172                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -33                  
                          STB R3, R6                   
L173                      MOV R1, FP                   ; BranchFalse T136, skipif137
                          ADI R1, -33                  
                          LDB R1, R1                   
                          BNZ R1, skipif137            ; Branch False
                          LDR R1, S70                  ; 5 * -1 -> T138
                          LDR R2, S71                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -34                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T138 - two -> T139
                          ADI R1, -34                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -24                  
                          LDR R2, R2                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -38                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T139 -> k
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -38                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -12                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 0 -> sum
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
begin140                  LDB R1, S73                  ; BranchFalse S73, endWhile141
                          BNZ R1, endWhile141          ; Branch False
                          MOV R1, FP                   ; k -> j
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -12                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
begin142                  MOV R1, FP                   ; j > 0 -> T143
                          ADI R1, -16                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L174                 ; L59 < S2 GOTO L174
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -42                  
                          STB R3, R6                   
                          JMP L175                     
L174                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -42                  
                          STB R3, R6                   
L175                      MOV R1, FP                   ; BranchFalse T143, endWhile144
                          ADI R1, -42                  
                          LDB R1, R1                   
                          BNZ R1, endWhile144          ; Branch False
                          MOV R1, FP                   ; j / 3 -> T145
                          ADI R1, -16                  
                          LDR R1, R1                   
                          LDR R2, S75                  
                          DIV R1, R2                   ; Divide Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T145 == 0 -> T146
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L176                 ; T145 < S2 GOTO L176
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -47                  
                          STB R3, R6                   
                          JMP L177                     
L176                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -47                  
                          STB R3, R6                   
L177                      MOV R1, FP                   ; BranchFalse T146, skipif147
                          ADI R1, -47                  
                          LDB R1, R1                   
                          BNZ R1, skipif147            ; Branch False
                          MOV R1, FP                   ; sum + j -> T148
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -16                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -48                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T148 -> sum
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -48                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
skipif147                 MOV R1, FP                   ; j - 1 -> T149
                          ADI R1, -16                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -52                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T149 -> j
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -52                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          JMP begin142                 ; 
endWhile144               MOV R1, FP                   ; k - 1 -> T150
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -56                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T150 -> k
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -56                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -12                  
                          STR R1, R4                   
                          JMP begin140                 ; 
endWhile141               MOV R1, FP                   ; 
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STR R0, R5                   
                          LDB R1, S67                  ; 
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          STB R0, S67                  
                          JMP skipelse151              ; Generate as Part of ELSE
skipif137                 MOV R1, FP                   ; 1 -> j
                          ADI R1, -16                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 0 -> sum
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
begin152                  MOV R1, FP                   ; k * 100 -> T153
                          ADI R1, -12                  
                          LDR R1, R1                   
                          LDR R2, S45                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -60                  
                          STR R1, R4                   
                          MOV R1, FP                   ; j < T153 -> T154
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -60                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L178                 ; L59 < T153 GOTO L178
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -64                  
                          STB R3, R6                   
                          JMP L179                     
L178                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -64                  
                          STB R3, R6                   
L179                      MOV R1, FP                   ; BranchFalse T154, endWhile155
                          ADI R1, -64                  
                          LDB R1, R1                   
                          BNZ R1, endWhile155          ; Branch False
                          MOV R1, FP                   ; j + sum -> T156
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -65                  
                          STR R1, R4                   
                          MOV R1, FP                   ; sum - j -> T157
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -16                  
                          LDR R2, R2                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -69                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T156 / T157 -> T158
                          ADI R1, -65                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -69                  
                          LDR R2, R2                   
                          DIV R1, R2                   ; Divide Data.
                          MOV R4, FP                   
                          ADI R4, -73                  
                          STR R1, R4                   
                          MOV R1, FP                   ; sum + T158 -> T159
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -73                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -77                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T159 -> sum
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -77                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; sum == 200 -> T160
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S83                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L180                 ; L61 < S83 GOTO L180
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -81                  
                          STB R3, R6                   
                          JMP L181                     
L180                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -81                  
                          STB R3, R6                   
L181                      MOV R1, FP                   ; sum == 300 -> T161
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S84                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L182                 ; L61 < S84 GOTO L182
                          MOV R3, R8                   ; Set FALSE
                          MOV R6, FP                   
                          ADI R6, -82                  
                          STB R3, R6                   
                          JMP L183                     
L182                      MOV R3, R7                   ; Set TRUE
                          MOV R6, FP                   
                          ADI R6, -82                  
                          STB R3, R6                   
L183                      MOV R1, FP                   ; T160 || T161 -> T162
                          ADI R1, -81                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -82                  
                          LDB R2, R2                   
                          MOV R3, R1                   
                          OR R3, R2                   
                          MOV R6, FP                   
                          ADI R6, -83                  
                          STB R3, R6                   
                          MOV R1, FP                   ; BranchFalse T162, skipif163
                          ADI R1, -83                  
                          LDB R1, R1                   
                          BNZ R1, skipif163            ; Branch False
                          MOV R1, FP                   ; sum + two -> T164
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -24                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -84                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T164 -> sum
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -84                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
skipif163                 MOV R1, FP                   ; j + 1 -> T165
                          ADI R1, -16                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -88                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T165 -> j
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -88                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          JMP begin152                 ; 
endWhile155               MOV R1, FP                   ; 
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STR R0, R5                   
                          LDB R1, S67                  ; 
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          STB R0, S67                  
skipelse151               LDB R1, S66                  ; 
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          STB R0, S66                  
                          MOV R1, FP                   ; 
                          ADI R1, -12                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; read int for print.
                          TRP 2                        
                          MOV R5, FP                   
                          ADI R5, -12                  
                          STR R0, R5                   
                          LDB R1, S67                  ; 
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          STB R0, S67                  
                          JMP begin133                 ; 
endWhile135               MOV SP, FP                   ; Test for Underflow
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
