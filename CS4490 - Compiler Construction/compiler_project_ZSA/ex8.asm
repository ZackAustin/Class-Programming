S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S8                       .BYT                     'I'                      
S9                       .BYT                     A                        
S15                      .BYT                     'x'                      
S16                      .BYT                     '1'                      
S17                      .BYT                     ':'                      
S18                      .BYT                     20                       
S21                      .BYT                     '2'                      
S29                      .BYT                     'C'                      
S30                      .BYT                     'D'                      
S37                      .BYT                     'w'                      
S42                      .INT                     2                        
S43                      .INT                     10                       
S49                      .INT                     5                        
S63                      .BYT                     'y'                      
S67                      .BYT                     'z'                      
S79                      .INT                     44                       
S85                      .BYT                     'O'                      
S87                      .BYT                     'B'                      
S88                      .BYT                     'a'                      
S89                      .BYT                     'c'                      
S90                      .BYT                     'k'                      
S92                      .BYT                     'S'                      
S93                      .BYT                     'u'                      
S96                      .BYT                     'e'                      
S97                      .BYT                     's'                      
S99                      .BYT                     '!'                      
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
FREE                     .INT                     7265                     


                              LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                              LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                              MOV R1, SP                   ; Create an activation record blank
                              ADI R1, -29                  ; Space for Function
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
g_dog_printMe                 ADI SP, -20                  
                              MOV R1, SP                   ; Test Overflow
                              CMP R1, SL                   
                              BLT R1, OVERFLOW             
                              LDB R1, S8                   ; Write out char: S8
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S9                   ; Write out char: S9
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, SP                   ; Create an activation record L7
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
                              JMP g_catdog_printMe         
                              LDR R1, SP                   ; PEEK
                              MOV R4, FP                   
                              ADI R4, -19                  
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
g_dog_addSelf                 ADI SP, -28                  
                              MOV R1, SP                   ; Test Overflow
                              CMP R1, SL                   
                              BLT R1, OVERFLOW             
                              LDB R1, S15                  ; Write out char: S15
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S16                  ; Write out char: S16
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: P13
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; x + x -> T104
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R2, FP                   
                              ADI R2, -15                  
                              LDR R2, R2                   
                              ADD R1, R2                   ; Add Data.
                              MOV R4, FP                   
                              ADI R4, -23                  
                              STR R1, R4                   
                              MOV R1, FP                   ; T104 -> x
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R2, FP                   
                              ADI R2, -23                  
                              LDR R2, R2                   
                              MOV R1, R2                   ; Move Data.
                              MOV R4, FP                   
                              ADI R4, -15                  
                              STR R1, R4                   
                              LDB R1, S15                  ; Write out char: S15
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S21                  ; Write out char: S21
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: P13
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S9                   ; Write out char: S9
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, SP                   ; Create an activation record L14
                              ADI R1, -32                  ; Space for Function
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
                              MOV R1, R9                   ; PUSH  P13
                              ADI R1, -15                  
                              LDR R1, R1                   
                              ADI SP, -3                   ; Store 4 bytes.
                              STR R1, SP                   
                              ADI SP, -1                   
                              MOV R1, PC                   
                              ADI R1, 48                   ; Compute rtn addr
                              STR R1, FP                   ; Set rtn addr
                              JMP g_catdog_doMath          
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
g_dog_StaticInit              ADI SP, -12                  
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
g_catdog_printMe              ADI SP, -12                  
                              MOV R1, SP                   ; Test Overflow
                              CMP R1, SL                   
                              BLT R1, OVERFLOW             
                              LDB R1, S29                  ; Write out char: S29
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S30                  ; Write out char: S30
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S9                   ; Write out char: S9
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
g_catdog_doMath               ADI SP, -32                  
                              MOV R1, SP                   ; Test Overflow
                              CMP R1, SL                   
                              BLT R1, OVERFLOW             
                              LDB R1, S37                  ; Write out char: S37
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S16                  ; Write out char: S16
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: P35
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; w / 2 -> T109
                              ADI R1, -15                  
                              LDR R1, R1                   
                              LDR R2, S42                  
                              DIV R1, R2                   ; Divide Data.
                              MOV R4, FP                   
                              ADI R4, -23                  
                              STR R1, R4                   
                              MOV R1, FP                   ; T109 + 10 -> T110
                              ADI R1, -23                  
                              LDR R1, R1                   
                              LDR R2, S43                  
                              ADD R1, R2                   ; Add Data.
                              MOV R4, FP                   
                              ADI R4, -27                  
                              STR R1, R4                   
                              MOV R1, FP                   ; T110 -> w
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R2, FP                   
                              ADI R2, -27                  
                              LDR R2, R2                   
                              MOV R1, R2                   ; Move Data.
                              MOV R4, FP                   
                              ADI R4, -15                  
                              STR R1, R4                   
                              LDB R1, S37                  ; Write out char: S37
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S21                  ; Write out char: S21
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: P35
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S9                   ; Write out char: S9
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, SP                   ; Create an activation record L36
                              ADI R1, -28                  ; Space for Function
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
                              MOV R1, R9                   ; PUSH  P35
                              ADI R1, -15                  
                              LDR R1, R1                   
                              ADI SP, -3                   ; Store 4 bytes.
                              STR R1, SP                   
                              ADI SP, -1                   
                              LDR R1, S49                  ; PUSH  S49
                              ADI SP, -3                   ; Store 4 bytes.
                              STR R1, SP                   
                              ADI SP, -1                   
                              MOV R1, PC                   
                              ADI R1, 48                   ; Compute rtn addr
                              STR R1, FP                   ; Set rtn addr
                              JMP g_catdog_doMathWithMoreParams
                              LDR R1, SP                   ; PEEK
                              MOV R4, FP                   
                              ADI R4, -31                  
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
g_catdog_doMathWithMoreParams ADI SP, -28                  
                              MOV R1, SP                   ; Test Overflow
                              CMP R1, SL                   
                              BLT R1, OVERFLOW             
                              MOV R1, FP                   ; 0 -> z
                              ADI R1, -23                  
                              LDR R1, R1                   
                              LDR R2, S2                   
                              MOV R1, R2                   ; Move Data.
                              MOV R4, FP                   
                              ADI R4, -23                  
                              STR R1, R4                   
                              LDB R1, S15                  ; Write out char: S15
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: P54
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S63                  ; Write out char: S63
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: P55
                              ADI R1, -19                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S67                  ; Write out char: S67
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S16                  ; Write out char: S16
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: L58
                              ADI R1, -23                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; x + y -> T116
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R2, FP                   
                              ADI R2, -19                  
                              LDR R2, R2                   
                              ADD R1, R2                   ; Add Data.
                              MOV R4, FP                   
                              ADI R4, -27                  
                              STR R1, R4                   
                              MOV R1, FP                   ; T116 -> z
                              ADI R1, -23                  
                              LDR R1, R1                   
                              MOV R2, FP                   
                              ADI R2, -27                  
                              LDR R2, R2                   
                              MOV R1, R2                   ; Move Data.
                              MOV R4, FP                   
                              ADI R4, -23                  
                              STR R1, R4                   
                              LDB R1, S67                  ; Write out char: S67
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S21                  ; Write out char: S21
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S17                  ; Write out char: S17
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, FP                   ; Write out int: L58
                              ADI R1, -23                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S9                   ; Write out char: S9
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
g_catdog_StaticInit           ADI SP, -12                  
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
g_main                        ADI SP, -29                  
                              MOV R1, SP                   ; Test Overflow
                              CMP R1, SL                   
                              BLT R1, OVERFLOW             
                              MOV R1, FP                   ; 44 -> x
                              ADI R1, -15                  
                              LDR R1, R1                   
                              LDR R2, S79                  
                              MOV R1, R2                   ; Move Data.
                              MOV R4, FP                   
                              ADI R4, -15                  
                              STR R1, R4                   
                              MOV R1, FP                   ; Write out int: L80
                              ADI R1, -15                  
                              LDR R1, R1                   
                              MOV R0, R1                   ; load int for print.
                              TRP 1                        
                              LDB R1, S9                   ; Write out char: S9
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, SP                   ; Create an activation record L83
                              ADI R1, -20                  ; Space for Function
                              CMP R1, SL                   ; Test Overflow
                              BLT R1, OVERFLOW             
                              MOV R9, FP                   ; Old Frame
                              MOV FP, SP                   ; New Frame
                              ADI SP, -4                   ; PFP
                              STR R9, SP                   ; Set PFP
                              ADI SP, -4                   
                              MOV R1, R9                   
                              ADI R1, -20                  
                              LDR R1, R1                   
                              STR R1, SP                   ; Set this on Stack
                              ADI SP, -4                   
                              MOV R1, PC                   
                              ADI R1, 48                   ; Compute rtn addr
                              STR R1, FP                   ; Set rtn addr
                              JMP g_dog_printMe            
                              LDR R1, SP                   ; PEEK
                              MOV R4, FP                   
                              ADI R4, -24                  
                              LDR R4, R4                   
                              STR R1, R4                   
                              LDB R1, S85                  ; Write out char: S85
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S9                   ; Write out char: S9
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              MOV R1, SP                   ; Create an activation record L83
                              ADI R1, -28                  ; Space for Function
                              CMP R1, SL                   ; Test Overflow
                              BLT R1, OVERFLOW             
                              MOV R9, FP                   ; Old Frame
                              MOV FP, SP                   ; New Frame
                              ADI SP, -4                   ; PFP
                              STR R9, SP                   ; Set PFP
                              ADI SP, -4                   
                              MOV R1, R9                   
                              ADI R1, -20                  
                              LDR R1, R1                   
                              STR R1, SP                   ; Set this on Stack
                              ADI SP, -4                   
                              MOV R1, R9                   ; PUSH  L80
                              ADI R1, -15                  
                              LDR R1, R1                   
                              ADI SP, -3                   ; Store 4 bytes.
                              STR R1, SP                   
                              ADI SP, -1                   
                              MOV R1, PC                   
                              ADI R1, 48                   ; Compute rtn addr
                              STR R1, FP                   ; Set rtn addr
                              JMP g_dog_addSelf            
                              LDR R1, SP                   ; PEEK
                              MOV R4, FP                   
                              ADI R4, -28                  
                              LDR R4, R4                   
                              STR R1, R4                   
                              LDB R1, S87                  ; Write out char: S87
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S88                  ; Write out char: S88
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S89                  ; Write out char: S89
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S90                  ; Write out char: S90
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S18                  ; Write out char: S18
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S92                  ; Write out char: S92
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S93                  ; Write out char: S93
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S89                  ; Write out char: S89
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S89                  ; Write out char: S89
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S96                  ; Write out char: S96
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S97                  ; Write out char: S97
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S97                  ; Write out char: S97
                              MOV R0, R1                   ; load byt for print.
                              TRP 3                        
                              LDB R1, S99                  ; Write out char: S99
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
OVERFLOW                      LDB R0, O                    ; output something if overflow occurs.
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
UNDERFLOW                     LDB R0, U                    ; output something if underflow occurs.
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
