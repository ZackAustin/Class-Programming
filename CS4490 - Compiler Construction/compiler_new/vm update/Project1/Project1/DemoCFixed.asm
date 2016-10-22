S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S15                      .INT                     2                        
S40                      .INT                     1000                     
S44                      .INT                     512                      
S46                      .INT                     256                      
S50                      .INT                     10                       
S51                      .INT                     5000                     
S52                      .INT                     5                        
S55                      .INT                     7                        
S56                      .BYT                     'c'                      
S59                      .INT                     3                        
S68                      .BYT                     '>'                      
S69                      .BYT                     A                        
S72                      .INT                     -1                       
S77                      .INT                     15                       
S88                      .INT                     39                       
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
FREE                     .INT                     14594                    


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -77                  ; Space for Function
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
g_DemoC_DemoC             ADI SP, -12                  
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
                          JMP g_DemoC_StaticInit       
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
g_DemoC_fib               ADI SP, -38                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; k == 0 -> T92
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L169                 ; P9 < S2 GOTO L169
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
                          JMP L170                     
L169                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
L170                      MOV R1, FP                   ; BranchFalse T92, skipif93
                          ADI R1, -16                  
                          LDB R1, R1                   
                          BNZ R1, skipif93             ; Branch False
                          LDR R1, S2                   ; 
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return S2
                          JMR R2                       ; goto rtn addr
                          JMP skipelse94               ; Generate as Part of ELSE
skipif93                  MOV R1, FP                   ; k == 1 -> T95
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L171                 ; P9 < S0 GOTO L171
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -17                  
                          STB R3, R5                   
                          JMP L172                     
L171                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -17                  
                          STB R3, R5                   
L172                      MOV R1, FP                   ; BranchFalse T95, skipif96
                          ADI R1, -17                  
                          LDB R1, R1                   
                          BNZ R1, skipif96             ; Branch False
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
                          JMP skipelse94               ; Generate as Part of ELSE
skipif96                  MOV R1, FP                   ; k - 1 -> T98
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -21                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -38                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH T98
                          ADI R1, -21                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_DemoC_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -25                  
                          STR R1, R4                   
                          MOV R1, FP                   ; k - 2 -> T100
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S15                  
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -29                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -38                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH T100
                          ADI R1, -29                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_DemoC_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -33                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T99 + T101 -> T102
                          ADI R1, -25                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -33                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -37                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -37                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return T102
                          JMR R2                       ; goto rtn addr
skipelse94                MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_DemoC_inc               ADI SP, -20                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; i + 1 -> T105
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
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
                          STR R1, SP                   ; return T105
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
                          JMP g_Syntax_StaticInit      
                          MOV R6, FP                   ; j -> i
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
                          MOV R6, FP                   ; d -> c
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -16                  
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
g_Syntax_split            ADI SP, -16                  
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
g_Syntax_checkit          ADI SP, -116                 
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R1, S0                   ; sizeof(char) * S40 -> T116
                          LDR R2, S40                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T116) -> T117
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -31                  
                          STR R4, R2                   ; Store T117
                          MOV R1, FP                   ; T117 -> cc
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -31                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(int) * S44 -> T120
                          LDR R2, S44                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T120) -> T121
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -39                  
                          STR R4, R2                   ; Store T121
                          MOV R1, FP                   ; T121 -> ii
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -39                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(pointer) * S46 -> T122
                          LDR R2, S46                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T122) -> T123
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -47                  
                          STR R4, R2                   ; Store T123
                          MOV R1, FP                   ; T123 -> ss
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -47                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S15                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T125 -> T124
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -55                  
                          LDR R2, R2                   
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -51                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S50                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c -> T126
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R2, R6                   
                          ADI R2, 4                    
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -59                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S51                  
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          LDR R1, S52                  ; 5 + i -> T128
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R2, R6                   
                          ADI R2, 0                    
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T128 -> T127
                          ADI R1, -63                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -67                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -63                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T129 -> i
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -71                  
                          LDR R2, R2                   
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 6                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -79                  
                          STR R4, R2                   ; Store T131
                          MOV R1, SP                   ; Create an activation record T131
                          ADI R1, -17                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -79                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S55                  ; PUSH S55
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDB R1, S56                  ; PUSH S56
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Syntax_Syntax          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -83                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T132 -> T130
                          ADI R1, -75                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -83                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -75                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R2, R6                   
                          ADI R2, 0                    
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -87                  
                          STR R1, R4                   
                          MOV R6, FP                   ; i + 1 -> T134
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -91                  
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -91                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -95                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T135 -> T133
                          ADI R1, -87                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -95                  
                          LDR R2, R2                   
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -87                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          LDR R1, S55                  ; 7 / 3 -> T136
                          LDR R2, S59                  
                          DIV R1, R2                   ; Divide Data.
                          MOV R4, FP                   
                          ADI R4, -99                  
                          STR R1, R4                   
                          MOV R6, FP                   ; i + T136 -> T137
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -99                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -103                 
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -103                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -107                 
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 6                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -111                 
                          STR R4, R2                   ; Store T139
                          MOV R1, SP                   ; Create an activation record T139
                          ADI R1, -17                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -111                 
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R6, R9                   ; PUSH V24
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R6, R9                   ; PUSH V26
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Syntax_Syntax          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -115                 
                          STR R1, R4                   
                          MOV R1, FP                   ; T140 -> T138
                          ADI R1, -107                 
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -115                 
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -107                 
                          LDR R4, R4                   
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
g_main                    ADI SP, -77                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDB R1, S68                  ; Write out char: S68
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Read in int: L62
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; read int for print.
                          TRP 2                        
                          MOV R5, FP                   
                          ADI R5, -15                  
                          STR R0, R5                   
                          LDB R1, S69                  ; Write out char: S69
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
begin144                  MOV R1, FP                   ; k != 0 -> T145
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BNZ R3, L173                 ; L62 < S2 GOTO L173
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -28                  
                          STB R3, R5                   
                          JMP L174                     
L173                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -28                  
                          STB R3, R5                   
L174                      MOV R1, FP                   ; BranchFalse T145, endWhile146
                          ADI R1, -28                  
                          LDB R1, R1                   
                          BNZ R1, endWhile146          ; Branch False
                          MOV R1, FP                   ; k < 0 -> T147
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L175                 ; L62 < S2 GOTO L175
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -29                  
                          STB R3, R5                   
                          JMP L176                     
L175                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -29                  
                          STB R3, R5                   
L176                      MOV R1, FP                   ; BranchFalse T147, skipif148
                          ADI R1, -29                  
                          LDB R1, R1                   
                          BNZ R1, skipif148            ; Branch False
                          MOV R1, FP                   ; k * -1 -> T149
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S72                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -33                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T149 -> k
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -33                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 0 -> sum
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
begin150                  MOV R1, FP                   ; k > 0 -> T151
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L177                 ; L62 < S2 GOTO L177
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -34                  
                          STB R3, R5                   
                          JMP L178                     
L177                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -34                  
                          STB R3, R5                   
L178                      MOV R1, FP                   ; BranchFalse T151, endWhile152
                          ADI R1, -34                  
                          LDB R1, R1                   
                          BNZ R1, endWhile152          ; Branch False
                          MOV R1, FP                   ; k -> j
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
begin153                  MOV R1, FP                   ; j >= 1 -> T154
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L179                 ; L64 < S0 GOTO L179
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L179                 ; L64 < S0 GOTO L179
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -35                  
                          STB R3, R5                   
                          JMP L180                     
L179                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -35                  
                          STB R3, R5                   
L180                      MOV R1, FP                   ; BranchFalse T154, endWhile155
                          ADI R1, -35                  
                          LDB R1, R1                   
                          BNZ R1, endWhile155          ; Branch False
                          MOV R1, FP                   ; j * 3 -> T156
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S59                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -39                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T156 > 15 -> T157
                          ADI R1, -39                  
                          LDR R1, R1                   
                          LDR R2, S77                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L181                 ; T156 < S77 GOTO L181
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -40                  
                          STB R3, R5                   
                          JMP L182                     
L181                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -40                  
                          STB R3, R5                   
L182                      MOV R1, FP                   ; BranchFalse T157, skipif158
                          ADI R1, -40                  
                          LDB R1, R1                   
                          BNZ R1, skipif158            ; Branch False
                          LDR R1, S15                  ; 2 * sum -> T159
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -44                  
                          STR R1, R4                   
                          MOV R1, FP                   ; j * 3 -> T160
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S59                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -48                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T159 + T160 -> T161
                          ADI R1, -44                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -48                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -52                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T161 -> sum
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -52                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
skipif158                 MOV R1, FP                   ; j - 1 -> T162
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -56                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T162 -> j
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -56                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          JMP begin153                 ; 
endWhile155               MOV R1, FP                   ; k - 1 -> T163
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R1, R2                   ; Subtract Data.
                          MOV R4, FP                   
                          ADI R4, -60                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T163 -> k
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -60                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin150                 ; 
endWhile152               MOV R1, FP                   ; Write out int: L66
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S69                  ; Write out char: S69
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP skipelse164              ; Generate as Part of ELSE
skipif148                 MOV R1, SP                   ; Create an activation record L67
                          ADI R1, -38                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -27                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH  L62
                          ADI R1, -15                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_DemoC_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -64                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          LDR R1, S15                  ; 2 * 3 -> T166
                          LDR R2, S59                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -68                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T165 + T166 -> T167
                          ADI R1, -64                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -68                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -72                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T167 -> sum
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -72                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: L66
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S69                  ; Write out char: S69
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
skipelse164               LDB R1, S68                  ; Write out char: S68
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Read in int: L62
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; read int for print.
                          TRP 2                        
                          MOV R5, FP                   
                          ADI R5, -15                  
                          STR R0, R5                   
                          LDB R1, S69                  ; Write out char: S69
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP begin144                 ; 
endWhile146               MOV R1, SP                   ; Create an activation record L67
                          ADI R1, -20                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -27                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4
                          LDR R1, S88                  ; PUSH  S88
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_DemoC_inc
						  TRP 99
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -76                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T168
                          ADI R1, -76                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S69                  ; Write out char: S69
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
