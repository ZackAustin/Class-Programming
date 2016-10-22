S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S13                      .INT                     100                      
S15                      .BYT                     'A'                      
S17                      .BYT                     'd'                      
S18                      .INT                     2                        
S20                      .INT                     3                        
S21                      .BYT                     'e'                      
S24                      .INT                     5                        
S25                      .BYT                     20                       
S26                      .INT                     6                        
S27                      .BYT                     'E'                      
S28                      .INT                     7                        
S29                      .BYT                     'l'                      
S30                      .INT                     8                        
S32                      .INT                     9                        
S33                      .BYT                     'm'                      
S34                      .INT                     10                       
S36                      .INT                     11                       
S37                      .BYT                     'n'                      
S38                      .INT                     12                       
S39                      .BYT                     't'                      
S40                      .INT                     13                       
S41                      .BYT                     ':'                      
S42                      .INT                     14                       
S43                      .BYT                     'D'                      
S45                      .BYT                     'u'                      
S47                      .BYT                     'p'                      
S51                      .BYT                     'i'                      
S53                      .BYT                     'c'                      
S55                      .BYT                     'a'                      
S62                      .INT                     24                       
S64                      .INT                     25                       
S66                      .INT                     26                       
S68                      .INT                     27                       
S70                      .INT                     28                       
S71                      .BYT                     'r'                      
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
FREE                     .INT                     14572                    


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -28                  ; Space for Function
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
                          LDR R1, S0                   ; sizeof(char) * S13 -> T91
                          LDR R2, S13                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T91) -> T92
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE
                          MOV R2, FP                   
                          ADI R2, -19                  
                          STR R4, R2                   ; Store T92
                          MOV R6, FP                   ; T92 -> msg
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
                          MOV R1, FP                   ; 'A' -> T93
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S15                  
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
                          MOV R1, FP                   ; 'd' -> T94
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S17                  
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
                          LDR R2, S18                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -31                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'd' -> T95
                          ADI R1, -31                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S17                  
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
                          LDR R2, S20                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T96
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S21                  
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
                          MOV R1, FP                   ; 'd' -> T97
                          ADI R1, -39                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S17                  
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
                          LDR R2, S24                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; ' ' -> T98
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S25                  
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
                          LDR R2, S26                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'E' -> T99
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S27                  
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
                          LDR R2, S28                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'l' -> T100
                          ADI R1, -51                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S29                  
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
                          LDR R2, S30                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T101
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S21                  
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
                          LDR R2, S32                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'm' -> T102
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S33                  
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
                          LDR R2, S34                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T103
                          ADI R1, -63                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S21                  
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
                          LDR R2, S36                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 'n' -> T104
                          ADI R1, -67                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S37                  
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
                          LDR R2, S38                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T105
                          ADI R1, -71                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S39                  
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
                          LDR R2, S40                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          MOV R1, FP                   ; ':' -> T106
                          ADI R1, -75                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S41                  
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
                          LDR R2, S42                  
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
                          MOV R1, FP                   ; 'D' -> T107
                          ADI R1, -79                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S43                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -79                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 1 -> T108
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
                          MOV R1, FP                   ; 'u' -> T109
                          ADI R1, -87                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S45                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -87                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 2 -> T110
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S18                  
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
                          MOV R1, FP                   ; 'p' -> T111
                          ADI R1, -95                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S47                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -95                  
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 3 -> T112
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S20                  
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
                          MOV R1, FP                   ; 'l' -> T113
                          ADI R1, -103                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S29                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -103                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 4 -> T114
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
                          MOV R1, FP                   ; 'i' -> T115
                          ADI R1, -111                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S51                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -111                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 5 -> T116
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S24                  
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
                          MOV R1, FP                   ; 'c' -> T117
                          ADI R1, -119                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S53                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -119                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 6 -> T118
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S26                  
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
                          MOV R1, FP                   ; 'a' -> T119
                          ADI R1, -127                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S55                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -127                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 7 -> T120
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S28                  
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
                          MOV R1, FP                   ; 't' -> T121
                          ADI R1, -135                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S39                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -135                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 8 -> T122
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S30                  
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
                          MOV R1, FP                   ; 'e' -> T123
                          ADI R1, -143                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S21                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -143                 
                          LDR R4, R4                   
                          STB R1, R4                   
                          MOV R6, FP                   ; i + 9 -> T124
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 4                    
                          LDR R1, R1                   
                          LDR R2, S32                  
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
                          MOV R1, FP                   ; ' ' -> T125
                          ADI R1, -151                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S25                  
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
                          LDR R2, S62                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -155                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'E' -> T126
                          ADI R1, -155                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S27                  
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
                          LDR R2, S64                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -159                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'n' -> T127
                          ADI R1, -159                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S37                  
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
                          LDR R2, S66                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -163                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 't' -> T128
                          ADI R1, -163                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S39                  
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
                          LDR R2, S68                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -167                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'e' -> T129
                          ADI R1, -167                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S21                  
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
                          LDR R2, S70                  
                          SUB R3, R3                   
                          ADI R3, 1                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -171                 
                          STR R1, R4                   
                          MOV R1, FP                   ; 'r' -> T130
                          ADI R1, -171                 
                          LDR R1, R1                   
                          LDB R1, R1                   
                          LDB R2, S71                  
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
begin134                  MOV R1, FP                   ; i <= end -> T135
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L145                 ; P76 < P77 GOTO L145
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L145                 ; P76 < P77 GOTO L145
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
                          JMP L146                     
L145                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -20                  
                          STB R3, R5                   
L146                      MOV R1, FP                   ; BranchFalse T135, endWhile136
                          ADI R1, -20                  
                          LDB R1, R1                   
                          BNZ R1, endWhile136          ; Branch False
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
                          MOV R1, FP                   ; Write out char: T137
                          ADI R1, -24                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; i + 1 -> T138
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -28                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T138 -> i
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -28                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin134                 ; 
endWhile136               MOV SP, FP                   ; Test for Underflow
                          MOV R1, SP                   
                          CMP R1, SB                   
                          BGT R1, UNDERFLOW            
                          LDR R1, FP                   ; rtn addr
                          MOV R2, FP                   
                          ADI R2, -4                   
                          LDR FP, R2                   ; PFP -> FP
                          JMR R1                       ; goto rtn addr
g_Message_msg3            ADI SP, -12                  
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
                          LDR R1, S62                  ; PUSH S62
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S70                  ; PUSH S70
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
						  TRP 99
						  MOV R2, FP                   ; Old Frame to R2
                          ADI R2, -8                   ; address of this
                          LDR R2, R2                   ; value of this		
                          MOV R4, FP                   
                          ADI R4, -11                  
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
                          LDR R1, S26                  ; PUSH S26
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          LDR R1, S40                  ; PUSH S40
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_print          
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -11                  
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
g_main                    ADI SP, -28                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 12                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -19                  
                          STR R4, R2                   ; Store T142
                          MOV R1, SP                   ; Create an activation record T142
                          ADI R1, -172                 ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -19                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_Message        
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -23                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T143 -> msg
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -23                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L86
                          ADI R1, -12                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -15                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Message_msg3           
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -27                  
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
