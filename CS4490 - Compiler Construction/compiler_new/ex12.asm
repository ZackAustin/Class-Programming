S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S10                      .BYT                     'I'                      
S11                      .BYT                     'n'                      
S12                      .BYT                     A                        
S13                      .BYT                     'x'                      
S14                      .BYT                     '1'                      
S15                      .BYT                     ':'                      
S16                      .BYT                     20                       
S19                      .BYT                     '2'                      
S32                      .INT                     7                        
S34                      .INT                     15                       
S37                      .BYT                     '3'                      
S41                      .INT                     24                       
S43                      .BYT                     '4'                      
S47                      .INT                     5                        
S48                      .INT                     6                        
S51                      .BYT                     '8'                      
S55                      .INT                     30                       
S56                      .INT                     9                        
S57                      .INT                     10                       
S58                      .BYT                     'j'                      
S59                      .BYT                     'u'                      
S61                      .BYT                     'k'                      
S62                      .BYT                     '!'                      
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
FREE                     .INT                     7634                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -84                  ; Space for Function
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
g_Cat_Cat                 ADI SP, -16                  
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
                          JMP g_Cat_StaticInit         
                          LDB R1, S10                  ; Write out char: S10
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S11                  ; Write out char: S11
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S12                  ; Write out char: S12
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S14                  ; Write out char: S14
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out int: V6
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; y -> x
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
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out int: V6
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
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
g_Cat_printX              ADI SP, -16                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out int: P26
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R6, FP                   ; Write out int: V6
                          ADI R6, -8                   
                          LDR R6, R6                   
                          MOV R1, R6                   
                          ADI R1, 0                    
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
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
g_main                    ADI SP, -84                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 4                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -23                  
                          STR R4, R2                   ; Store T69
                          MOV R1, SP                   ; Create an activation record T69
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -23                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S32                  ; PUSH S32
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_Cat                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -27                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T70 -> c
                          ADI R1, -15                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -27                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -15                  
                          STR R1, R4                   
                          LDR R3, FREE                 ; Get this pointer to heap
                          MOV R4, R3                   ; this -> R4
                          ADI R3, 4                    
                          STR R3, FREE                 
                          MOV R2, FP                   
                          ADI R2, -31                  
                          STR R4, R2                   ; Store T71
                          MOV R1, SP                   ; Create an activation record T71
                          ADI R1, -16                  ; Space for Function
                          CMP R1, SL                   ; Test Overflow
                          BLT R1, OVERFLOW             
                          MOV R9, FP                   ; Old Frame
                          MOV FP, SP                   ; New Frame
                          ADI SP, -4                   ; PFP
                          STR R9, SP                   ; Set PFP
                          ADI SP, -4                   
                          MOV R1, R9                   
                          ADI R1, -31                  
                          LDR R1, R1                   
                          STR R1, SP                   ; Set this on Stack
                          ADI SP, -4                   
                          LDR R1, S34                  ; PUSH S34
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_Cat                
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -35                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T72 -> c2
                          ADI R1, -19                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -35                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -19                  
                          STR R1, R4                   
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S37                  ; Write out char: S37
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(x) -> T73
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -39                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T73
                          ADI R1, -39                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(x) -> T74
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -43                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 24 -> T74
                          ADI R1, -43                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          LDR R2, S41                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -43                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S43                  ; Write out char: S43
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(x) -> T75
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -47                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T75
                          ADI R1, -47                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, SP                   ; Create an activation record L33
                          ADI R1, -16                  ; Space for Function
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
                          LDR R1, S47                  ; PUSH  S47
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_printX             
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -51                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c + offset(x) -> T77
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -55                  
                          STR R1, R4                   
                          MOV R1, FP                   ; c2 + offset(x) -> T78
                          ADI R1, -19                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -59                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T78 -> T77
                          ADI R1, -55                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -59                  
                          LDR R2, R2                   
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -55                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L33
                          ADI R1, -16                  ; Space for Function
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
                          LDR R1, S48                  ; PUSH  S48
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_printX             
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -63                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L35
                          ADI R1, -16                  ; Space for Function
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
                          LDR R1, S32                  ; PUSH  S32
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_printX             
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -67                  
                          STR R1, R4                   
                          LDB R1, S13                  ; Write out char: S13
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S51                  ; Write out char: S51
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S15                  ; Write out char: S15
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S16                  ; Write out char: S16
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c + offset(x) -> T81
                          ADI R1, -15                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -71                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T81
                          ADI R1, -71                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S12                  ; Write out char: S12
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; c2 + offset(x) -> T82
                          ADI R1, -19                  
                          LDR R1, R1                   
                          SUB R2, R2                   
                          ADI R2, 0                    
                          ADD R1, R2                   
                          MOV R4, FP                   
                          ADI R4, -75                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 30 -> T82
                          ADI R1, -75                  
                          LDR R1, R1                   
                          LDR R1, R1                   
                          LDR R2, S55                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -75                  
                          LDR R4, R4                   
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L35
                          ADI R1, -16                  ; Space for Function
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
                          LDR R1, S56                  ; PUSH  S56
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_printX             
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -79                  
                          STR R1, R4                   
                          MOV R1, SP                   ; Create an activation record L33
                          ADI R1, -16                  ; Space for Function
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
                          LDR R1, S57                  ; PUSH  S57
                          ADI SP, -3                   ; Store 4 bytes.
                          STR R1, SP                   
                          ADI SP, -1                   
                          MOV R1, PC                   
                          ADI R1, 48                   ; Compute rtn addr
                          STR R1, FP                   ; Set rtn addr
                          JMP g_Cat_printX             
                          LDR R1, SP                   ; PEEK
                          MOV R4, FP                   
                          ADI R4, -83                  
                          STR R1, R4                   
                          LDB R1, S58                  ; Write out char: S58
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S59                  ; Write out char: S59
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S11                  ; Write out char: S11
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S61                  ; Write out char: S61
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S62                  ; Write out char: S62
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S62                  ; Write out char: S62
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S12                  ; Write out char: S12
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
