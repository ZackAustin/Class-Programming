S0                       .INT                     1                        
S1                       .INT                     4                        
S2                       .INT                     0                        
S7                       .BYT                     'x'                      
S10                      .INT                     10                       
S13                      .INT                     44                       
S18                      .BYT                     20                       
S19                      .BYT                     A                        
S21                      .INT                     20                       
S23                      .BYT                     'y'                      
S24                      .BYT                     'n'                      
S25                      .BYT                     0                        
S26                      .INT                     100                      
S27                      .INT                     55                       
S28                      .BYT                     1                        
S31                      .INT                     0                        
S46                      .INT                     -100                     
S47                      .INT                     101                      
S50                      .BYT                     ':'                      
S54                      .BYT                     'a'                      
S56                      .BYT                     'b'                      
S57                      .BYT                     'c'                      
S59                      .INT                     2                        
S60                      .INT                     3                        
S62                      .INT                     5                        
S64                      .BYT                     'w'                      
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
FREE                     .INT                     6251                     


                          LDR R7, S2                   ; Set R7 to hold 0 - TRUE
                          LDR R8, S0                   ; Set R8 to hold 1 - FALSE
                          MOV R1, SP                   ; Create an activation record blank
                          ADI R1, -50                  ; Space for Function
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
g_dog_StaticInit          ADI SP, -12                  
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
g_main                    ADI SP, -50                  
                          MOV R1, SP                   ; Test Overflow
                          CMP R1, SL                   
                          BLT R1, OVERFLOW             
                          MOV R1, FP                   ; 'x' -> test1
                          ADI R1, -12                  
                          LDB R1, R1                   
                          LDB R2, S7                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -12                  
                          STB R1, R4                   
                          MOV R1, FP                   ; 10 -> test2
                          ADI R1, -16                  
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -16                  
                          STR R1, R4                   
                          MOV R1, FP                   ; 44 -> x
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S13                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out char: L8
                          ADI R1, -12                  
                          LDB R1, R1                   
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S18                  ; Write out char: S18
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out int: L11
                          ADI R1, -16                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x < 10 -> T71
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S10                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L104                 ; L14 < S10 GOTO L104
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -26                  
                          STB R3, R5                   
                          JMP L105                     
L104                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -26                  
                          STB R3, R5                   
L105                      MOV R1, FP                   ; x < 20 -> T72
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S21                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L106                 ; L14 < S21 GOTO L106
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -27                  
                          STB R3, R5                   
                          JMP L107                     
L106                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -27                  
                          STB R3, R5                   
L107                      MOV R1, FP                   ; T71 || T72 -> T73
                          ADI R1, -26                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -27                  
                          LDB R2, R2                   
                          MOV R3, R1                   
                          OR R3, R2                   
                          MOV R5, FP                   
                          ADI R5, -28                  
                          STB R3, R5                   
                          MOV R1, FP                   ; x > 0 -> T74
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S2                   
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L108                 ; L14 < S2 GOTO L108
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -29                  
                          STB R3, R5                   
                          JMP L109                     
L108                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -29                  
                          STB R3, R5                   
L109                      MOV R1, FP                   ; T73 && T74 -> T75
                          ADI R1, -28                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -29                  
                          LDB R2, R2                   
                          MOV R3, R1                   
                          AND R3, R2                   
                          MOV R5, FP                   
                          ADI R5, -30                  
                          STB R3, R5                   
                          MOV R1, FP                   ; BranchFalse T75, skipif76
                          ADI R1, -30                  
                          LDB R1, R1                   
                          BNZ R1, skipif76             ; Branch False
                          LDB R1, S23                  ; Write out char: S23
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP skipelse77               ; Generate as Part of ELSE
skipif76                  LDB R1, S24                  ; Write out char: S24
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
skipelse77                LDB R1, S25                  ; BranchFalse S25, skipif78
                          BNZ R1, skipif78             ; Branch False
                          LDR R1, S26                  ; Write out int: S26
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          JMP skipelse79               ; Generate as Part of ELSE
skipif78                  LDR R1, S27                  ; Write out int: S27
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
skipelse79                LDB R1, S28                  ; BranchFalse S28, skipif80
                          BNZ R1, skipif80             ; Branch False
                          LDR R1, S26                  ; Write out int: S26
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          JMP skipelse81               ; Generate as Part of ELSE
skipif80                  LDR R1, S27                  ; Write out int: S27
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
skipelse81                MOV R1, FP                   ; d == null -> T82
                          ADI R1, -25                  
                          LDR R1, R1                   
                          LDR R2, S31                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L110                 ; L17 < S31 GOTO L110
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -31                  
                          STB R3, R5                   
                          JMP L111                     
L110                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -31                  
                          STB R3, R5                   
L111                      MOV R1, FP                   ; BranchFalse T82, skipif83
                          ADI R1, -31                  
                          LDB R1, R1                   
                          BNZ R1, skipif83             ; Branch False
                          LDR R1, S26                  ; Write out int: S26
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          JMP skipelse84               ; Generate as Part of ELSE
skipif83                  LDR R1, S27                  ; Write out int: S27
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
skipelse84                LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
begin85                   MOV R1, FP                   ; x < 100 -> T86
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S26                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BLT R3, L112                 ; L14 < S26 GOTO L112
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -32                  
                          STB R3, R5                   
                          JMP L113                     
L112                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -32                  
                          STB R3, R5                   
L113                      MOV R1, FP                   ; BranchFalse T86, endWhile87
                          ADI R1, -32                  
                          LDB R1, R1                   
                          BNZ R1, endWhile87           ; Branch False
                          MOV R1, FP                   ; Write out int: L14
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S18                  ; Write out char: S18
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x + 1 -> T88
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S0                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -36                  
                          STR R1, R4                   
                          MOV R1, FP                   ; T88 -> x
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -36                  
                          LDR R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          JMP begin85                  ; 
endWhile87                LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; null -> d
                          ADI R1, -25                  
                          LDR R1, R1                   
                          LDR R2, S31                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -25                  
                          STR R1, R4                   
                          MOV R1, FP                   ; d == null -> T89
                          ADI R1, -25                  
                          LDR R1, R1                   
                          LDR R2, S31                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L114                 ; L17 < S31 GOTO L114
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -37                  
                          STB R3, R5                   
                          JMP L115                     
L114                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -37                  
                          STB R3, R5                   
L115                      MOV R1, FP                   ; BranchFalse T89, skipif90
                          ADI R1, -37                  
                          LDB R1, R1                   
                          BNZ R1, skipif90             ; Branch False
                          LDR R1, S26                  ; Write out int: S26
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          JMP skipelse91               ; Generate as Part of ELSE
skipif90                  LDR R1, S27                  ; Write out int: S27
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
skipelse91                LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; d != null -> T92
                          ADI R1, -25                  
                          LDR R1, R1                   
                          LDR R2, S31                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BNZ R3, L116                 ; L17 < S31 GOTO L116
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -38                  
                          STB R3, R5                   
                          JMP L117                     
L116                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -38                  
                          STB R3, R5                   
L117                      MOV R1, FP                   ; BranchFalse T92, skipif93
                          ADI R1, -38                  
                          LDB R1, R1                   
                          BNZ R1, skipif93             ; Branch False
                          LDR R1, S26                  ; Write out int: S26
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          JMP skipelse94               ; Generate as Part of ELSE
skipif93                  LDR R1, S46                  ; Write out int: S46
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
skipelse94                MOV R1, FP                   ; 101 -> x
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S47                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S7                   ; Write out char: S7
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S50                  ; Write out char: S50
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S18                  ; Write out char: S18
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out int: L14
                          ADI R1, -20                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; x >= 101 -> T95
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S47                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L118                 ; L14 < S47 GOTO L118
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L118                 ; L14 < S47 GOTO L118
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -39                  
                          STB R3, R5                   
                          JMP L119                     
L118                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -39                  
                          STB R3, R5                   
L119                      MOV R1, FP                   ; BranchFalse T95, skipif96
                          ADI R1, -39                  
                          LDB R1, R1                   
                          BNZ R1, skipif96             ; Branch False
                          LDB R1, S54                  ; Write out char: S54
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP skipelse97               ; Generate as Part of ELSE
skipif96                  MOV R1, FP                   ; x >= 100 -> T98
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S26                  
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BGT R3, L120                 ; L14 < S26 GOTO L120
                          MOV R3, R1                   ; Move data into 3rd register for compare.
                          CMP R3, R2                   ; Compare Data.
                          BRZ R3, L120                 ; L14 < S26 GOTO L120
                          MOV R3, R8                   ; Set FALSE
                          MOV R5, FP                   
                          ADI R5, -40                  
                          STB R3, R5                   
                          JMP L121                     
L120                      MOV R3, R7                   ; Set TRUE
                          MOV R5, FP                   
                          ADI R5, -40                  
                          STB R3, R5                   
L121                      MOV R1, FP                   ; BranchFalse T98, skipif99
                          ADI R1, -40                  
                          LDB R1, R1                   
                          BNZ R1, skipif99             ; Branch False
                          LDB R1, S56                  ; Write out char: S56
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          JMP skipelse97               ; Generate as Part of ELSE
skipif99                  LDB R1, S57                  ; Write out char: S57
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
skipelse97                LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDR R1, S60                  ; 3 * 10 -> T101
                          LDR R2, S10                  
                          MUL R1, R2                   ; Multiply Data.
                          MOV R4, FP                   
                          ADI R4, -44                  
                          STR R1, R4                   
                          LDR R1, S59                  ; 2 + T101 -> T102
                          MOV R2, FP                   
                          ADI R2, -44                  
                          LDR R2, R2                   
                          ADD R1, R2                   ; Add Data.
                          MOV R4, FP                   
                          ADI R4, -48                  
                          STR R1, R4                   
                          MOV R1, FP                   ; Write out int: T102
                          ADI R1, -48                  
                          LDR R1, R1                   
                          MOV R0, R1                   ; load int for print.
                          TRP 1                        
                          MOV R1, FP                   ; 5 -> x
                          ADI R1, -20                  
                          LDR R1, R1                   
                          LDR R2, S62                  
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -20                  
                          STR R1, R4                   
                          MOV R0, FP                   ; L14 -> T103
                          ADI R0, -20                  
                          LDR R0, R0                   
                          TRP 11                       ; int to char Register 0.
                          MOV R3, FP                   
                          ADI R3, -49                  
                          STB R0, R3                   
                          MOV R1, FP                   ; T103 -> w
                          ADI R1, -21                  
                          LDB R1, R1                   
                          MOV R2, FP                   
                          ADI R2, -49                  
                          LDB R2, R2                   
                          MOV R1, R2                   ; Move Data.
                          MOV R4, FP                   
                          ADI R4, -21                  
                          STB R1, R4                   
                          LDB R1, S19                  ; Write out char: S19
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S64                  ; Write out char: S64
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S50                  ; Write out char: S50
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          LDB R1, S18                  ; Write out char: S18
                          MOV R0, R1                   ; load byt for print.
                          TRP 3                        
                          MOV R1, FP                   ; Write out char: L16
                          ADI R1, -21                  
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
