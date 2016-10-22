S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S10                      .INT                     0                        
S37                      .INT                     2                        
S43                      .BYT                     0                        
S53                      .BYT                     1                        
S57                      .BYT                     A                        
S66                      .BYT                     20                       
S67                      .BYT                     ','                      
S68                      .BYT                     '('                      
S70                      .BYT                     ')'                      
S81                      .INT                     100                      
S83                      .BYT                     'A'                      
S85                      .BYT                     'd'                      
S88                      .INT                     3                        
S89                      .BYT                     'e'                      
S92                      .INT                     5                        
S94                      .INT                     6                        
S95                      .BYT                     'E'                      
S96                      .INT                     7                        
S97                      .BYT                     'l'                      
S98                      .INT                     8                        
S100                     .INT                     9                        
S101                     .BYT                     'm'                      
S102                     .INT                     10                       
S104                     .INT                     11                       
S105                     .BYT                     'n'                      
S106                     .INT                     12                       
S107                     .BYT                     't'                      
S108                     .INT                     13                       
S109                     .BYT                     ':'                      
S110                     .INT                     14                       
S111                     .BYT                     'D'                      
S113                     .BYT                     'u'                      
S115                     .BYT                     'p'                      
S119                     .BYT                     'i'                      
S121                     .BYT                     'c'                      
S123                     .BYT                     'a'                      
S130                     .INT                     24                       
S132                     .INT                     25                       
S134                     .INT                     26                       
S136                     .INT                     27                       
S138                     .INT                     28                       
S139                     .BYT                     'r'                      
S189                     .INT                     1000                     
S193                     .INT                     512                      
S195                     .INT                     256                      
S200                     .INT                     5000                     
S217                     .INT                     42                       
S240                     .INT                     37                       
S241                     .BYT                     'g'                      
S244                     .BYT                     '!'                      
S245                     .BYT                     'k'                      
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
FREE                     .INT                     44865                    


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
                          MOV R6, FP                   ; cnt + 1 -> T251
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
                          MOV R6, FP                   ; T251 -> cnt
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
                          MOV R1, FP                   ; root == 0 -> T255
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L447                 ; P31 < S2 GOTO L447
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
                          JMP L448                     
L447                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
L448                      MOV R1, FP                   ; BranchFalse T255, skipif256
                          ADI R1, -16                  
                          LDB R1, R1                   
                          BNZ R1, skipif256            ; Branch False
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
                          JMP skipelse257              ; Generate as Part of ELSE
skipif256                 MOV R1, FP                   ; root == 1 -> T258
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L449                 ; P31 < S0 GOTO L449
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -17                  
                          STB R3, R5                   
                          JMP L450                     
L449                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -17                  
                          STB R3, R5                   
L450                      MOV R1, FP                   ; BranchFalse T258, skipif259
                          ADI R1, -17                  
                          LDB R1, R1                   
                          BNZ R1, skipif259            ; Branch False
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
                          JMP skipelse257              ; Generate as Part of ELSE
skipif259                 MOV R1, FP                   ; root - 1 -> T261
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
                          MOV R1, R9                   ; PUSH T261
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
                          MOV R1, FP                   ; root - 2 -> T263
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
                          MOV R1, R9                   ; PUSH T263
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
                          MOV R1, FP                   ; T262 + T264 -> T265
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
                          STR R1, SP                   ; return T265
                          JMR R2                       ; goto rtn addr
skipelse257               MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_iTree_add               ADI SP, -26                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; root == null -> T268
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L451                 ; V23 < S10 GOTO L451
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -13                  
                          STB R3, R5                   
                          JMP L452                     
L451                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -13                  
                          STB R3, R5                   
L452                      MOV R1, FP                   ; BranchFalse T268, skipif269
                          ADI R1, -13                  
                          LDB R1, R1                   
                          BNZ R1, skipif269            ; Branch False
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 13                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -17                  
                          STR R4, R2                   ; Store T270
                          MOV R1, SP                   ; Create an activation record T270
                          ADI R1, -13                  ; Space for Function
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
                          ADI R4, -21                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T271 -> root
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -21                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
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
                          JMP skipelse272              ; Generate as Part of ELSE
skipif269                 MOV R1, SP                   ; Create an activation record this
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
                          ADI R4, -25                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 
                          ADI R1, -25                  
                          LDR R1, R1                   
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return T273
                          JMR R2                       ; goto rtn addr
skipelse272               MOV SP, FP                   ; Test for Underflow
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
                          MOV R1, FP                   ; node + offset(root) -> T276
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; key < T276 -> T277
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -20                  
                          LDR R2, R2                   
                          LDB R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L453                 ; P47 < T276 GOTO L453
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -21                  
                          STB R3, R5                   
                          JMP L454                     
L453                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -21                  
                          STB R3, R5                   
L454                      MOV R1, FP                   ; BranchFalse T277, skipif278
                          ADI R1, -21                  
                          LDB R1, R1                   
                          BNZ R1, skipif278            ; Branch False
                          MOV R1, FP                   ; node + offset(left) -> T279
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 5                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -25                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T279 == null -> T280
                          ADI R1, -25                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L455                 ; T279 < S10 GOTO L455
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -26                  
                          STB R3, R5                   
                          JMP L456                     
L455                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -26                  
                          STB R3, R5                   
L456                      MOV R1, FP                   ; BranchFalse T280, skipif281
                          ADI R1, -26                  
                          LDB R1, R1                   
                          BNZ R1, skipif281            ; Branch False
                          MOV R1, FP                   ; node + offset(left) -> T282
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
                          STR R4, R2                   ; Store T283
                          MOV R1, SP                   ; Create an activation record T283
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
                          MOV R1, R9                   ; PUSH P47
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
                          MOV R1, FP                   ; T284 -> T282
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
                          JMP skipelse285              ; Generate as Part of ELSE
skipif281                 MOV R1, FP                   ; node + offset(left) -> T286
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
                          MOV R1, R9                   ; PUSH P47
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, R9                   ; PUSH T286
                          ADI R1, -42                  
                          LDR R1, R1                   
                          LDR R1, R1                   
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
                          STR R1, SP                   ; return T287
                          JMR R2                       ; goto rtn addr
skipelse285               JMP skipelse288              ; Generate as Part of ELSE
skipif278                 MOV R1, FP                   ; node + offset(root) -> T289
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -50                  
                          STR R1, R4                   
                          MOV R1, FP                   ; key > T289 -> T290
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -50                  
                          LDR R2, R2                   
                          LDB R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L457                 ; P47 < T289 GOTO L457
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -51                  
                          STB R3, R5                   
                          JMP L458                     
L457                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -51                  
                          STB R3, R5                   
L458                      MOV R1, FP                   ; BranchFalse T290, skipif291
                          ADI R1, -51                  
                          LDB R1, R1                   
                          BNZ R1, skipif291            ; Branch False
                          MOV R1, FP                   ; node + offset(right) -> T292
                          ADI R1, -16                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 9                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T292 == null -> T293
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L459                 ; T292 < S10 GOTO L459
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -56                  
                          STB R3, R5                   
                          JMP L460                     
L459                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -56                  
                          STB R3, R5                   
L460                      MOV R1, FP                   ; BranchFalse T293, skipif294
                          ADI R1, -56                  
                          LDB R1, R1                   
                          BNZ R1, skipif294            ; Branch False
                          MOV R1, FP                   ; node + offset(right) -> T295
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
                          STR R4, R2                   ; Store T296
                          MOV R1, SP                   ; Create an activation record T296
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
                          MOV R1, R9                   ; PUSH P47
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
                          MOV R1, FP                   ; T297 -> T295
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
                          JMP skipelse298              ; Generate as Part of ELSE
skipif294                 MOV R1, FP                   ; node + offset(right) -> T299
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
                          MOV R1, R9                   ; PUSH P47
                          ADI R1, -12                  
                          LDB R1, R1                   
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, R9                   ; PUSH T299
                          ADI R1, -72                  
                          LDR R1, R1                   
                          LDR R1, R1                   
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
                          STR R1, SP                   ; return T300
                          JMR R2                       ; goto rtn addr
skipelse298               JMP skipelse288              ; Generate as Part of ELSE
skipif291                 MOV R1, SP                   ; Create an activation record P48
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          LDB R1, S53                  ; 
                          MOV SP, FP                   ; Test for Underflow
                          MOV R2, SP                   
                          CMP R2, SB                   
                          BGT R2, UNDERFLOW            
                          LDR R2, FP                   ; rtn addr
                          MOV R3, FP                   
                          ADI R3, -4                   
                          LDR FP, R3                   ; PFP -> FP
                          STR R1, SP                   ; return S53
                          JMR R2                       ; goto rtn addr
skipelse288               MOV SP, FP                   ; Test for Underflow
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
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -37                  ; Space for Function
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
                          LDB R1, S57                  ; Write out char: S57
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
g_iTree_inorder           ADI SP, -37                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; node == null -> T306
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L461                 ; P60 < S10 GOTO L461
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
                          JMP L462                     
L461                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -16                  
                          STB R3, R5                   
L462                      MOV R1, FP                   ; BranchFalse T306, skipif307
                          ADI R1, -16                  
                          LDB R1, R1                   
                          BNZ R1, skipif307            ; Branch False
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
                          STR R1, SP                   ; return T304
                          JMR R2                       ; goto rtn addr
skipif307                 MOV R1, FP                   ; node + offset(left) -> T308
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 5                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -37                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH T308
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_inorder          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -32                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH P60
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_visit            
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -28                  
                          STR R1, R4                   
                          MOV R1, FP                   ; node + offset(right) -> T311
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 9                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -32                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record this
                          ADI R1, -37                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH T311
                          ADI R1, -32                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_iTree_inorder          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -36                  
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
g_iTree_visit             ADI SP, -32                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; BranchFalse V25, skipif314
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          BNZ R1, skipif314            ; Branch False
                          MOV R6, FP                   ; false -> first
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          LDB R2, S53                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STB R1, R4                   
                          LDB R1, S66                  ; Write out char: S66
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP skipelse315              ; Generate as Part of ELSE
skipif314                 LDB R1, S67                  ; Write out char: S67
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
skipelse315               MOV R1, FP                   ; node + offset(root) -> T316
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T316
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S68                  ; Write out char: S68
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; node + offset(cnt) -> T317
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 1                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T317
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S67                  ; Write out char: S67
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; node + offset(cnt) -> T318
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
                          MOV R1, R9                   ; PUSH T318
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
                          MOV R1, FP                   ; Write out int: T319
                          ADI R1, -31                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S70                  ; Write out char: S70
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
                          LDR R1, S0                   ; sizeof(char) * S81 -> T324
                          LDR R2, S81                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T324) -> T325
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -19                  
                          STR R4, R2                   ; Store T325
                          MOV R6, FP                   ; T325 -> msg
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
                          MOV R1, FP                   ; 'A' -> T326
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S83                  
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
                          MOV R1, FP                   ; 'd' -> T327
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S85                  
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
                          MOV R1, FP                   ; 'd' -> T328
                          ADI R1, -31                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S85                  
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
                          LDR R2, S88                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T329
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S89                  
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
                          MOV R1, FP                   ; 'd' -> T330
                          ADI R1, -39                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S85                  
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
                          LDR R2, S92                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; ' ' -> T331
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S66                  
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
                          LDR R2, S94                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'E' -> T332
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S95                  
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
                          LDR R2, S96                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'l' -> T333
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S97                  
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
                          LDR R2, S98                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T334
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S89                  
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
                          LDR R2, S100                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'm' -> T335
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S101                 
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
                          LDR R2, S102                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T336
                          ADI R1, -63                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S89                  
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
                          LDR R2, S104                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'n' -> T337
                          ADI R1, -67                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S105                 
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
                          LDR R2, S106                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T338
                          ADI R1, -71                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S107                 
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
                          LDR R2, S108                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          MOV R1, FP                   ; ':' -> T339
                          ADI R1, -75                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S109                 
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
                          LDR R2, S110                 
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
                          MOV R1, FP                   ; 'D' -> T340
                          ADI R1, -79                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S111                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -79                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 1 -> T341
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
                          MOV R1, FP                   ; 'u' -> T342
                          ADI R1, -87                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S113                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -87                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 2 -> T343
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
                          MOV R1, FP                   ; 'p' -> T344
                          ADI R1, -95                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S115                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -95                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 3 -> T345
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S88                  
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
                          MOV R1, FP                   ; 'l' -> T346
                          ADI R1, -103                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S97                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -103                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 4 -> T347
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
                          MOV R1, FP                   ; 'i' -> T348
                          ADI R1, -111                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S119                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -111                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 5 -> T349
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S92                  
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
                          MOV R1, FP                   ; 'c' -> T350
                          ADI R1, -119                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S121                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -119                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 6 -> T351
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S94                  
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
                          MOV R1, FP                   ; 'a' -> T352
                          ADI R1, -127                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S123                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -127                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 7 -> T353
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S96                  
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
                          MOV R1, FP                   ; 't' -> T354
                          ADI R1, -135                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S107                 
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -135                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 8 -> T355
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S98                  
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
                          MOV R1, FP                   ; 'e' -> T356
                          ADI R1, -143                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S89                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -143                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 9 -> T357
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S100                 
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
                          MOV R1, FP                   ; ' ' -> T358
                          ADI R1, -151                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S66                  
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
                          LDR R2, S130                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -155                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'E' -> T359
                          ADI R1, -155                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S95                  
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
                          LDR R2, S132                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -159                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'n' -> T360
                          ADI R1, -159                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S105                 
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
                          LDR R2, S134                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -163                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T361
                          ADI R1, -163                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S107                 
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
                          LDR R2, S136                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -167                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T362
                          ADI R1, -167                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S89                  
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
                          LDR R2, S138                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -171                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'r' -> T363
                          ADI R1, -171                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S139                 
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
begin367                  MOV R1, FP                   ; i <= end -> T368
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L463                 ; P144 < P145 GOTO L463
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L463                 ; P144 < P145 GOTO L463
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
                          JMP L464                     
L463                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
L464                      MOV R1, FP                   ; BranchFalse T368, endWhile369
                          ADI R1, -20                  
                          LDB R1, R1                   
                          BNZ R1, endWhile369          ; Branch False
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
                          MOV R1, FP                   ; Write out char: T370
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; i + 1 -> T371
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -28                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T371 -> i
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -28                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin367                 ; 
endWhile369               MOV SP, FP                   ; Test for Underflow
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
                          LDR R1, S108                 ; PUSH S108
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
                          MOV R1, FP                   ; Write out char: P150
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S57                  ; Write out char: S57
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
                          LDR R2, S110                 
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STR R1, R4                   
                          MOV R6, FP                   ; i + 8 -> T377
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S98                  
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R6, FP                   ; T377 -> end
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
                          MOV R6, R9                   ; PUSH V76
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R6, R9                   ; PUSH V78
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
                          LDR R2, S92                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -24                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T379
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
                          LDR R1, S94                  ; PUSH S94
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S108                 ; PUSH S108
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
                          MOV R1, FP                   ; Write out char: P157
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S57                  ; Write out char: S57
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
g_Message_msg3            ADI SP, -16                  
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
                          LDR R1, S130                 ; PUSH S130
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S138                 ; PUSH S138
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
                          LDR R2, S92                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
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
g_Syntax_checkit          ADI SP, -124                 
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R1, S0                   ; sizeof(char) * S189 -> T391
                          LDR R2, S189                 
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T391) -> T392
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -31                  
                          STR R4, R2                   ; Store T392
                          MOV R1, FP                   ; T392 -> cc
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -31                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(int) * S193 -> T395
                          LDR R2, S193                 
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T395) -> T396
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -39                  
                          STR R4, R2                   ; Store T396
                          MOV R1, FP                   ; T396 -> ii
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -39                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(pointer) * S195 -> T397
                          LDR R2, S195                 
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T397) -> T398
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -47                  
                          STR R4, R2                   ; Store T398
                          MOV R1, FP                   ; T398 -> ss
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
                          LDR R2, S37                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T400 -> T399
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
                          LDR R2, S102                 
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c -> T401
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
                          LDR R2, S200                 
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          LDR R1, S92                  ; 5 + i -> T403
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
                          MOV R1, FP                   ; T403 -> T402
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
                          MOV R6, FP                   ; T404 -> i
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
                          STR R4, R2                   ; Store T406
                          MOV R1, SP                   ; Create an activation record T406
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
                          LDR R1, S96                  ; PUSH S96
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDB R1, S121                 ; PUSH S121
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
                          MOV R1, FP                   ; T407 -> T405
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
                          MOV R6, FP                   ; i + 1 -> T409
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
                          MOV R1, FP                   ; T410 -> T408
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
                          LDR R1, S96                  ; 7 / 3 -> T411
                          LDR R2, S88                  
                          DIV R1, R2                   ; Divide Data.
                          MOV R4, FP                   
                          ADI R4, -99                  
                          STR R1, R4                   
                          MOV R6, FP                   ; i + T411 -> T412
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
                          STR R4, R2                   ; Store T414
                          MOV R1, SP                   ; Create an activation record T414
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
                          MOV R6, R9                   ; PUSH V173
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R6, R9                   ; PUSH V176
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
                          MOV R1, FP                   ; T415 -> T413
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
g_Syntax_which            ADI SP, -20                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; i * i -> T420
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -15                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T420 -> i
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
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
                          STR R1, SP                   ; return P213
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
                          MOV R6, FP                   ; 7 -> i
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          LDR R2, S96                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
                          STR R1, R4                   
                          MOV R6, FP                   ; 'a' -> c
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          LDB R2, S123                 
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 4                    
                          STB R1, R4                   
                          MOV R6, FP                   ; false -> b
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 5                    
                          LDB R1, R1                   
                          LDB R2, S53                  
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 5                    
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
                          MOV R1, FP                   ; Write out int: P225
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S57                  ; Write out char: S57
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out char: P226
                          ADI R1, -16                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S57                  ; Write out char: S57
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
                          MOV R6, FP                   ; Write out int: V218
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S57                  ; Write out char: S57
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out char: V221
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S57                  ; Write out char: S57
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
                          LDR R2, S217                 
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
                          LDB R2, S101                 
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
                          STR R4, R2                   ; Store T428
                          MOV R1, SP                   ; Create an activation record T428
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
                          MOV R1, FP                   ; T429 -> msg
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
                          STR R4, R2                   ; Store T430
                          MOV R1, SP                   ; Create an activation record T430
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
                          LDR R1, S240                 ; PUSH S240
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDB R1, S241                 ; PUSH S241
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
                          MOV R1, FP                   ; T431 -> bff
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
                          STR R4, R2                   ; Store T432
                          MOV R1, SP                   ; Create an activation record T432
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
                          MOV R1, FP                   ; T433 -> tree
                          ADI R1, -17                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -49                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -17                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L242
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L239
                          ADI R1, -16                  ; Space for Function
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; Read in char: L235
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; read byt for print.
                          TRP 4                        
                          MOV R5, FP                   
                          ADI R5, -12                  
                          STB R0, R5                   
                          LDB R1, S57                  ; Write out char: S57
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
begin436                  MOV R1, FP                   ; key != '!' -> T437
                          ADI R1, -12                  
                          LDB R1, R1                   
                          LDB R2, S244                 
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BNZ R3, L465                 ; L235 < S244 GOTO L465
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -58                  
                          STB R3, R5                   
                          JMP L466                     
L465                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -58                  
                          STB R3, R5                   
L466                      MOV R1, FP                   ; BranchFalse T437, endWhile438
                          ADI R1, -58                  
                          LDB R1, R1                   
                          BNZ R1, endWhile438          ; Branch False
                          MOV R1, SP                   ; Create an activation record L238
                          ADI R1, -26                  ; Space for Function
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
                          MOV R1, R9                   ; PUSH  L235
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
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R1, FP                   ; BranchFalse T439, skipif440
                          ADI R1, -62                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          BNZ R1, skipif440            ; Branch False
                          MOV R1, SP                   ; Create an activation record L239
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
                          MOV R1, R9                   ; PUSH  L235
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L238
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          JMP skipelse443              ; Generate as Part of ELSE
skipif440                 MOV R1, SP                   ; Create an activation record L239
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
                          LDB R1, S245                 ; PUSH  S245
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_msg2           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -74                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L238
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L239
                          ADI R1, -16                  ; Space for Function
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
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; Read in char: L237
                          ADI R1, -13                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; read byt for print.
                          TRP 4                        
                          MOV R5, FP                   
                          ADI R5, -13                  
                          STB R0, R5                   
                          MOV R1, FP                   ; Read in char: L235
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; read byt for print.
                          TRP 4                        
                          MOV R5, FP                   
                          ADI R5, -12                  
                          STB R0, R5                   
                          LDB R1, S57                  ; Write out char: S57
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
skipelse443               JMP begin436                 ; 
endWhile438               MOV SP, FP                   ; Test for Underflow
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
