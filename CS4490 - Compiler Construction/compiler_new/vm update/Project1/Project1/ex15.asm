S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S6                       .BYT                     'y'                      
S16                      .INT                     3                        
S20                      .BYT                     'Z'                      
S22                      .BYT                     'a'                      
S23                      .INT                     2                        
S24                      .BYT                     'c'                      
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
FREE                     .INT                     5762                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -89                  ; Space for Function
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
g_Dog_Dog                 ADI SP, -13                  
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
                          JMP g_Dog_StaticInit         
                          MOV R6, FP                   ; c -> letter
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
g_Dog_StaticInit          ADI SP, -12                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R6, FP                   ; 'y' -> letter
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDB R1, R1                   
                          LDB R2, S6                   
                          MOV R1, R2                   ; Move Data.
                          MOV R6, FP                   
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R4, R6                   
                          ADI R4, 0                    
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
g_main                    ADI SP, -89                  
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
                          MOV R1, FP                   ; 3 -> arraySize
                          ADI R1, -19                  
                          LDR R1, R1                   
                          LDR R2, S16                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          LDR R1, S1                   ; sizeof(pointer) * L17 -> T34
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; malloc(T34) -> T35
                          ADI R1, -27                  
                          LDR R1, R1                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADD R3, R1                   
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -31                  
                          STR R4, R2                   ; Store T35
                          MOV R1, FP                   ; T35 -> someDogs
                          ADI R1, -23                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -31                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -23                  
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
                          ADI R4, -35                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 1                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -39                  
                          STR R4, R2                   ; Store T37
                          MOV R1, SP                   ; Create an activation record T37
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -39                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDB R1, S20                  ; PUSH S20
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Dog_Dog                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T38 -> T36
                          ADI R1, -35                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -43                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -35                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 1                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -51                  
                          STR R4, R2                   ; Store T40
                          MOV R1, SP                   ; Create an activation record T40
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -51                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDB R1, S22                  ; PUSH S22
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Dog_Dog                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T41 -> T39
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -55                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -47                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S23                  
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 1                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -63                  
                          STR R4, R2                   ; Store T43
                          MOV R1, SP                   ; Create an activation record T43
                          ADI R1, -13                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -63                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDB R1, S24                  ; PUSH S24
                          STB R1, SP                   ; Store 1 byte.
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Dog_Dog                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T44 -> T42
                          ADI R1, -59                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -67                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -59                  
                          LDR R4, R4                   
                          STR R1, R4                   
begin45                   MOV R1, FP                   ; x < arraySize -> T46
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -19                  
                          LDR R2, R2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L53                  ; L14 < L17 GOTO L53
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -68                  
                          STB R3, R5                   
                          JMP L54                      
L53                       MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -68                  
                          STB R3, R5                   
L54                       MOV R1, FP                   ; BranchFalse T46, endWhile47
                          ADI R1, -68                  
                          LDB R1, R1                   
                          BNZ R1, endWhile47           ; Branch False
                          MOV R1, FP                   ; Write out int: L14
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
                          ADI R2, -15                  
                          LDR R2, R2                   
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -72                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T48 + offset(letter) -> T49
                          ADI R1, -72                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -76                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T49
                          ADI R1, -76                  
                          LDR R1, R1                   
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S27                  ; Write out char: S27
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x + 1 -> T50
                          ADI R1, -15                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -80                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T50 -> x
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -80                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          JMP begin45
endWhile47                MOV R1, FP                   ; compute address
                          ADI R1, -23                  
                          LDR R1, R1                   
                          LDR R2, S16                  
                          SUB R3, R3                   
                          ADI R3, 4                    
                          MUL R3, R2                   
                          ADD R1, R3                   
                          MOV R4, FP                   
                          ADI R4, -84                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T51 + offset(letter) -> T52
                          ADI R1, -84                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -88                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: T52
                          ADI R1, -88
						  TRP 99
                          LDR R1, R1                   
                          LDB R1, R1                   
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
