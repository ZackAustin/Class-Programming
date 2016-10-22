S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S10                      .INT                     0                        
S37                      .INT                     2                        
S43                      .BYT                     0                        
S55                      .BYT                     1                        
S60                      .BYT                     20                       
S61                      .BYT                     A                        
S70                      .INT                     3                        
S74                      .INT                     5                        
S81                      .BYT                     ','                      
S82                      .BYT                     '('                      
S84                      .BYT                     ')'                      
S95                      .INT                     100                      
S97                      .BYT                     'A'                      
S99                      .BYT                     'd'                      
S103                     .BYT                     'e'                      
S108                     .INT                     6                        
S109                     .BYT                     'E'                      
S110                     .INT                     7                        
S111                     .BYT                     'l'                      
S112                     .INT                     8                        
S114                     .INT                     9                        
S115                     .BYT                     'm'                      
S116                     .INT                     10                       
S118                     .INT                     11                       
S119                     .BYT                     'n'                      
S120                     .INT                     12                       
S121                     .BYT                     't'                      
S122                     .INT                     13                       
S123                     .BYT                     ':'                      
S124                     .INT                     14                       
S125                     .BYT                     'D'                      
S127                     .BYT                     'u'                      
S129                     .BYT                     'p'                      
S133                     .BYT                     'i'                      
S135                     .BYT                     'c'                      
S137                     .BYT                     'a'                      
S144                     .INT                     24                       
S146                     .INT                     25                       
S148                     .INT                     26                       
S150                     .INT                     27                       
S152                     .INT                     28                       
S153                     .BYT                     'r'                      
S188                     .INT                     42                       
S211                     .INT                     37                       
S212                     .BYT                     'g'                      
S215                     .BYT                     '!'                      
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
FREE                     .INT                     38536                    


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -83                  ; Space for Function
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
g_iNode_iNode             ADI SP, -13                  
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
                          JMP g_iNode_StaticInit       
                          MOV R6, FP                   ; key -> root
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
                          MOV R6, FP                   ; 1 -> cnt
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 1                    
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 1                    
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
g_iNode_inc               ADI SP, -16                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; cnt + 1 -> T221
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 1                    
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T221 -> cnt
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 1                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 1                    
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
g_iNode_StaticInit        ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; 0 -> cnt
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 1                    
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 1                    
                          STR R1, R4                   
                          MOV R6, FP                   ; null -> left
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 5                    
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 5                    
                          STR R1, R4                   
                          MOV R6, FP                   ; null -> right
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 9                    
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 9                    
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
g_iTree_iTree             ADI SP, -12                  
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
                          JMP g_iTree_StaticInit       
                          MOV R6, FP                   ; null -> root
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S10                  
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
g_iTree_fib               ADI SP, -38                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; root == 0 -> T225
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L379                 ; P31 < S2 GOTO L379
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
                          JMP L380                     
L379                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
L380                      MOV R1, FP                   ; BranchFalse T225, skipif226
                          ADI R1, -16                  
                          LDB R1, R1                   
                          BNZ R1, skipif226            ; Branch False
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
                          JMP skipelse227              ; Generate as Part of ELSE
skipif226                 MOV R1, FP                   ; root == 1 -> T228
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L381                 ; P31 < S0 GOTO L381
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -17                  
                          STB R3, R5                   
                          JMP L382                     
L381                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -17                  
                          STB R3, R5                   
L382                      MOV R1, FP                   ; BranchFalse T228, skipif229
                          ADI R1, -17                  
                          LDB R1, R1                   
                          BNZ R1, skipif229            ; Branch False
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
                          JMP skipelse227              ; Generate as Part of ELSE
skipif229                 MOV R1, FP                   ; root - 1 -> T231
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
                          MOV R1, R9                   ; PUSH T231
                          ADI R1, -21                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -25                  
                          STR R1, R4                   
                          MOV R1, FP                   ; root - 2 -> T233
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S37                  
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
                          MOV R1, R9                   ; PUSH T233
                          ADI R1, -29                  
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -33                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T232 + T234 -> T235
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
                          STR R1, SP                   ; return T235
                          JMR R2                       ; goto rtn addr
skipelse227               MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_iTree_add               ADI SP, -27                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; true -> added
                          ADI R1, -13                  
                          LDB R1, R1                   
                          LDB R2, S43                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -13                  
                          STB R1, R4                   
                          MOV R6, FP                   ; root == null -> T239
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L383                 ; V23 < S10 GOTO L383
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -14                  
                          STB R3, R5                   
                          JMP L384                     
L383                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -14                  
                          STB R3, R5                   
L384                      MOV R1, FP                   ; BranchFalse T239, skipif240
                          ADI R1, -14                  
                          LDB R1, R1                   
                          BNZ R1, skipif240            ; Branch False
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 13                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -18                  
                          STR R4, R2                   ; Store T241
                          MOV R1, SP                   ; Create an activation record T241
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -18                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P41
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iNode_iNode            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -22                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T242 -> root
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -22                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return L44
                          JMR R2                       ; goto rtn addr
                          JMP skipelse243              ; Generate as Part of ELSE
skipif240                 MOV R1, SP                   ; Create an activation record this
                          ADI R1, -81                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH P41
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R6, R9                   ; PUSH V23
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_insert           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -26                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T244 -> added
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -26                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -13                  
                          STB R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return L44
                          JMR R2                       ; goto rtn addr
skipelse243               MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_iTree_insert            ADI SP, -81                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; node + offset(root) -> T247
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; key < T247 -> T248
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          LDB R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L385                 ; P49 < T247 GOTO L385
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -21                  
                          STB R3, R5                   
                          JMP L386                     
L385                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -21                  
                          STB R3, R5                   
L386                      MOV R1, FP                   ; BranchFalse T248, skipif249
                          ADI R1, -21                  
                          LDB R1, R1                   
                          BNZ R1, skipif249            ; Branch False
                          MOV R1, FP                   ; node + offset(left) -> T250
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 5                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -25                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T250 == null -> T251
                          ADI R1, -25                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L387                 ; T250 < S10 GOTO L387
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -26                  
                          STB R3, R5                   
                          JMP L388                     
L387                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -26                  
                          STB R3, R5                   
L388                      MOV R1, FP                   ; BranchFalse T251, skipif252
                          ADI R1, -26                  
                          LDB R1, R1                   
                          BNZ R1, skipif252            ; Branch False
                          MOV R1, FP                   ; node + offset(left) -> T253
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 5                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -30                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 13                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -34                  
                          STR R4, R2                   ; Store T254
                          MOV R1, SP                   ; Create an activation record T254
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -34                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P49
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iNode_iNode            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -38                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T255 -> T253
                          ADI R1, -30                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -38                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -30                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          LDB R1, S43                  ; 
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return S43
                          JMR R2                       ; goto rtn addr
                          JMP skipelse256              ; Generate as Part of ELSE
skipif252                 MOV R1, FP                   ; node + offset(left) -> T257
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 5                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -42                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -81                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH P49
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, R9                   ; PUSH T257
                          ADI R1, -42                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_insert           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -46                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -46                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return T258
                          JMR R2                       ; goto rtn addr
skipelse256               JMP skipelse259              ; Generate as Part of ELSE
skipif249                 MOV R1, FP                   ; node + offset(root) -> T260
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -50                  
                          STR R1, R4                   
                          MOV R1, FP                   ; key > T260 -> T261
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -50                  
                          LDR R2, R2                   
                          LDB R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L389                 ; P49 < T260 GOTO L389
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -51                  
                          STB R3, R5                   
                          JMP L390                     
L389                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -51                  
                          STB R3, R5                   
L390                      MOV R1, FP                   ; BranchFalse T261, skipif262
                          ADI R1, -51                  
                          LDB R1, R1                   
                          BNZ R1, skipif262            ; Branch False
                          MOV R1, FP                   ; node + offset(right) -> T263
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 9                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T263 == null -> T264
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L391                 ; T263 < S10 GOTO L391
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -56                  
                          STB R3, R5                   
                          JMP L392                     
L391                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -56                  
                          STB R3, R5                   
L392                      MOV R1, FP                   ; BranchFalse T264, skipif265
                          ADI R1, -56                  
                          LDB R1, R1                   
                          BNZ R1, skipif265            ; Branch False
                          MOV R1, FP                   ; node + offset(right) -> T266
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 9                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -60                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 13                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -64                  
                          STR R4, R2                   ; Store T267
                          MOV R1, SP                   ; Create an activation record T267
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -64                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH P49
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iNode_iNode            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -68                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T268 -> T266
                          ADI R1, -60                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -68                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -60                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          LDB R1, S43                  ; 
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return S43
                          JMR R2                       ; goto rtn addr
                          JMP skipelse269              ; Generate as Part of ELSE
skipif265                 MOV R1, FP                   ; node + offset(right) -> T270
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 9                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -72                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -81                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH P49
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, R9                   ; PUSH T270
                          ADI R1, -72                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_insert           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -76                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -76                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return T271
                          JMR R2                       ; goto rtn addr
skipelse269               JMP skipelse259              ; Generate as Part of ELSE
skipif262                 MOV R1, SP                   ; Create an activation record P50
                          ADI R1, -16                  ; Space for Function
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
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iNode_inc              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -80                  
                          STR R1, R4                   
                          LDB R1, S55                  ; 
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return S55
                          JMR R2                       ; goto rtn addr
skipelse259               MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_iTree_print             ADI SP, -16                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; true -> first
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          LDB R2, S43                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STB R1, R4                   
                          LDR R1, S2                   ; Write out int: S2
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S60                  ; Write out char: S60
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -25                  ; Space for Function
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
                          MOV R6, R9                   ; PUSH V23
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_inorder          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          LDB R1, S61                  ; Write out char: S61
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
g_iTree_inorder           ADI SP, -25                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R1, S0                   ; Write out int: S0
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S60                  ; Write out char: S60
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; node == null -> T277
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L393                 ; P64 < S10 GOTO L393
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
                          JMP L394                     
L393                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
L394                      MOV R1, FP                   ; BranchFalse T277, skipif278
                          ADI R1, -16                  
                          LDB R1, R1                   
                          BNZ R1, skipif278            ; Branch False
                          MOV R1, FP                   ; 
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return T275
                          JMR R2                       ; goto rtn addr
skipif278                 LDR R1, S37                  ; Write out int: S37
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S60                  ; Write out char: S60
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; node + offset(left) -> T279
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 5                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -25                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH T279
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_inorder          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          LDR R1, S70                  ; Write out int: S70
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S60                  ; Write out char: S60
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDR R1, S1                   ; Write out int: S1
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S60                  ; Write out char: S60
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDR R1, S74                  ; Write out int: S74
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S60                  ; Write out char: S60
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
g_iTree_visit             ADI SP, -32                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; BranchFalse V25, skipif282
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          BNZ R1, skipif282            ; Branch False
                          MOV R6, FP                   ; false -> first
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          LDB R2, S55                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STB R1, R4                   
                          LDB R1, S60                  ; Write out char: S60
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP skipelse283              ; Generate as Part of ELSE
skipif282                 LDB R1, S81                  ; Write out char: S81
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
skipelse283               MOV R1, FP                   ; node + offset(root) -> T284
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T284
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S82                  ; Write out char: S82
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; node + offset(cnt) -> T285
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 1                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T285
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S81                  ; Write out char: S81
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; node + offset(cnt) -> T286
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 1                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -27                  
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
                          MOV R1, R9                   ; PUSH T286
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_fib              
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -31                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T287
                          ADI R1, -31                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S84                  ; Write out char: S84
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
g_iTree_StaticInit        ADI SP, -12                  
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
g_Message_Message         ADI SP, -172                 
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
                          JMP g_Message_StaticInit     
                          LDR R1, S0                   ; sizeof(char) * S95 -> T292
                          LDR R2, S95                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T292) -> T293
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -19                  
                          STR R4, R2                   ; Store T293
                          MOV R6, FP                   ; T293 -> msg
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'A' -> T294
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S97                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'd' -> T295
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S99                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -27                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S37                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -31                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'd' -> T296
                          ADI R1, -31                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S99                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -31                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S70                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T297
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S103                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -35                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S1                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -39                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'd' -> T298
                          ADI R1, -39                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S99                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -39                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S74                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; ' ' -> T299
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S60                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S108                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'E' -> T300
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S109                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -47                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S110                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'l' -> T301
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S111                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -51                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S112                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T302
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S103                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -55                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S114                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'm' -> T303
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S115                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -59                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S116                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T304
                          ADI R1, -63                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S103                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -63                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S118                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'n' -> T305
                          ADI R1, -67                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S119                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -67                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S120                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T306
                          ADI R1, -71                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S121                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -71                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S122                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          MOV R1, FP                   ; ':' -> T307
                          ADI R1, -75                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S123                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -75                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; 14 -> i
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S124                 
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R2, R6                   
                          ADI R2, 4                    
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -79                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'D' -> T308
                          ADI R1, -79                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S125                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -79                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 1 -> T309
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -83                  
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -83                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -87                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'u' -> T310
                          ADI R1, -87                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S127                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -87                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 2 -> T311
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S37                  
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -91                  
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -91                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -95                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'p' -> T312
                          ADI R1, -95                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S129                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -95                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 3 -> T313
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S70                  
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -99                  
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -99                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -103                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'l' -> T314
                          ADI R1, -103                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S111                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -103                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 4 -> T315
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S1                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -107                 
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -107                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -111                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'i' -> T316
                          ADI R1, -111                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S133                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -111                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 5 -> T317
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S74                  
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -115                 
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -115                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -119                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'c' -> T318
                          ADI R1, -119                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S135                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -119                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 6 -> T319
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S108                 
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -123                 
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -123                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -127                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'a' -> T320
                          ADI R1, -127                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S137                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -127                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 7 -> T321
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S110                 
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -131                 
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -131                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -135                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T322
                          ADI R1, -135                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S121                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -135                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 8 -> T323
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S112                 
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -139                 
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -139                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -143                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T324
                          ADI R1, -143                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S103                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -143                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 9 -> T325
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S114                 
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -147                 
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -147                 
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -151                 
                          STR R1, R4                   
                          MOV R1, FP                   ; ' ' -> T326
                          ADI R1, -151                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S60                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -151                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S144                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -155                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'E' -> T327
                          ADI R1, -155                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S109                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -155                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S146                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -159                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'n' -> T328
                          ADI R1, -159                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S119                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -159                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S148                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -163                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T329
                          ADI R1, -163                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S121                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -163                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S150                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -167                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T330
                          ADI R1, -167                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S103                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -167                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S152                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -171                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'r' -> T331
                          ADI R1, -171                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S153                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -171                 
                          LDR R4, R4                   
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
g_Message_print           ADI SP, -29                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
begin335                  MOV R1, FP                   ; i <= end -> T336
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L395                 ; P158 < P159 GOTO L395
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L395                 ; P158 < P159 GOTO L395
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
                          JMP L396                     
L395                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
L396                      MOV R1, FP                   ; BranchFalse T336, endWhile337
                          ADI R1, -20                  
                          LDB R1, R1                   
                          BNZ R1, endWhile337          ; Branch False
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T338
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; i + 1 -> T339
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -28                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T339 -> i
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -28                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin335                 ; 
endWhile337               MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Message_msg1            ADI SP, -17                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
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
                          LDR R1, S2                   ; PUSH S2
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S122                 ; PUSH S122
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: P164
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S61                  ; Write out char: S61
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
g_Message_msg2            ADI SP, -29                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; 14 -> i
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S124                 
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STR R1, R4                   
                          MOV R6, FP                   ; i + 8 -> T345
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S112                 
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T345 -> end
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 8                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -16                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 8                    
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
                          MOV R6, R9                   ; PUSH V90
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R6, R9                   ; PUSH V92
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 8                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R6, FP                   ; compute address
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S74                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T347
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
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
                          LDR R1, S108                 ; PUSH S108
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S122                 ; PUSH S122
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -28                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: P171
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S61                  ; Write out char: S61
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
g_Message_msg3            ADI SP, -24                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
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
                          LDR R1, S144                 ; PUSH S144
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S152                 ; PUSH S152
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R6, FP                   ; 5 -> i
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S74                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
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
                          MOV R6, R9                   ; PUSH V90
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R6, R9                   ; PUSH V90
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -19                  
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
                          LDR R1, S108                 ; PUSH S108
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S122                 ; PUSH S122
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -23                  
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
g_Message_StaticInit      ADI SP, -12                  
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
g_Butterfly_Butterfly     ADI SP, -17                  
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
                          JMP g_Butterfly_StaticInit   
                          MOV R1, FP                   ; Write out int: P196
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S61                  ; Write out char: S61
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out char: P197
                          ADI R1, -16                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S61                  ; Write out char: S61
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
g_Butterfly_nest          ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; Write out int: V189
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S61                  ; Write out char: S61
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out char: V192
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S61                  ; Write out char: S61
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
g_Butterfly_StaticInit    ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; 42 -> age
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S188                 
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R6, FP                   ; 'm' -> type
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          LDB R2, S115                 
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STB R1, R4                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_main                    ADI SP, -83                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 12                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -29                  
                          STR R4, R2                   ; Store T360
                          MOV R1, SP                   ; Create an activation record T360
                          ADI R1, -172                 ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -29                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_Message        
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -33                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T361 -> msg
                          ADI R1, -21                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -33                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -21                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 5                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -37                  
                          STR R4, R2                   ; Store T362
                          MOV R1, SP                   ; Create an activation record T362
                          ADI R1, -17                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -37                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S211                 ; PUSH S211
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDB R1, S212                 ; PUSH S212
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Butterfly_Butterfly    
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -41                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T363 -> bff
                          ADI R1, -25                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -41                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -25                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 5                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -45                  
                          STR R4, R2                   ; Store T364
                          MOV R1, SP                   ; Create an activation record T364
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -45                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_iTree            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -49                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T365 -> tree
                          ADI R1, -17                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -49                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -17                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L213
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -25                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Butterfly_nest         
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -53                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L210
                          ADI R1, -24                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -21                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_msg3           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -57                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Read in char: L206
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; read byt for print.
                          TRP 4                        
                          MOV R5, FP                   
                          ADI R5, -12                  
                          STB R0, R5                   
                          LDB R1, S61                  ; Write out char: S61
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
begin368                  MOV R1, FP                   ; key != '!' -> T369
                          ADI R1, -12                  
                          LDB R1, R1                   
                          LDB R2, S215                 
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BNZ R3, L397                 ; L206 < S215 GOTO L397
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -58                  
                          STB R3, R5                   
                          JMP L398                     
L397                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -58                  
                          STB R3, R5                   
L398                      MOV R1, FP                   ; BranchFalse T369, endWhile370
                          ADI R1, -58                  
                          LDB R1, R1                   
                          BNZ R1, endWhile370          ; Branch False
                          MOV R1, SP                   ; Create an activation record L209
                          ADI R1, -27                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -17                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH  L206
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_add              
                          LDB R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -62                  
                          STB R1, R4                   
                          MOV R1, FP                   ; BranchFalse T371, skipif372
                          ADI R1, -62                  
                          LDB R1, R1                   
                          BNZ R1, skipif372            ; Branch False
                          MOV R1, SP                   ; Create an activation record L210
                          ADI R1, -17                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -21                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH  L206
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_msg1           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -66                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L209
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -17                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_print            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -70                  
                          STR R1, R4                   
                          JMP skipelse375              ; Generate as Part of ELSE
skipif372                 MOV R1, SP                   ; Create an activation record L210
                          ADI R1, -29                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -21                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, R9                   ; PUSH  L206
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_msg2           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -74                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L209
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -17                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_print            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -78                  
                          STR R1, R4                   
skipelse375               MOV R1, SP                   ; Create an activation record L210
                          ADI R1, -24                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -21                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_msg3           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -82                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Read in char: L208
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; read byt for print.
                          TRP 4                        
                          MOV R5, FP                   
                          ADI R5, -13                  
                          STB R0, R5                   
                          MOV R1, FP                   ; Read in char: L206
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; read byt for print.
                          TRP 4                        
                          MOV R5, FP                   
                          ADI R5, -12                  
                          STB R0, R5                   
                          LDB R1, S61                  ; Write out char: S61
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP begin368                 ; 
endWhile370               MOV SP, FP                   ; Test for Underflow
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
