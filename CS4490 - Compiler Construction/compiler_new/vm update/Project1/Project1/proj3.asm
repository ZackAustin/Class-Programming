;Zack Austin - Project 3 - 11/9/13

;data segment
flag				.INT 0
SIZE				.INT 7
cnt					.INT 0
tenth				.INT 0
c					.BYT 0
					.BYT 0
					.BYT 0
					.BYT 0
					.BYT 0
					.BYT 0
					.BYT 0
data				.INT 0
opdv				.INT 0
PFPRTN				.INT 8
neg1				.INT -1
neg2				.INT -2
wordSize			.INT 4
charSize			.INT 1
retAddr				.INT 60
ZERO				.INT 0
ONE					.INT 1
N					.BYT 'N'
u					.BYT 'u'
m					.BYT 'm'
b					.BYT 'b'
e					.BYT 'e'
r					.BYT 'r'
space				.BYT 20
t					.BYT 't'
o					.BYT 'o'
B					.BYT 'B'
i					.BYT 'i'
g					.BYT 'g'
newline				.BYT A
D					.BYT 'D'
n					.BYT 'n'
e					.BYT 'e'
atsign				.BYT '@'
s					.BYT 's'
a					.BYT 'a'
plusSign			.BYT '+'
minusSign			.BYT '-'
O					.BYT 'O'
p					.BYT 'p'
d					.BYT 'd'
v					.BYT 'v'
f					.BYT 'f'
l					.BYT 'l'
w					.BYT 'w'
U					.BYT 'U'
;code segment
; void main {
; call the function reset(1, 0, 0, 0); // Reset globals
	; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
					
	; Create Activation Record and invoke function reset(w, x, y, z)
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
	; Passed Parameters onto the Stack (Pass by Value)
					LDR	R5, ZERO
					STR	R5, SP
					LDR R6, wordSize
					SUB	SP, R6	; Place 0 on the Stack
					STR	R5, SP
					SUB	SP, R6	; Place 0 on the Stack
					STR	R5, SP
					SUB	SP, R6	; Place 0 on the Stack
					LDR	R5, ONE
					STR	R5, SP
					SUB	SP, R6	; Place 1 on the Stack
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					
					JMP	reset	; Call Function reset
					
					;instruction where we return.

; call the function getdata(); //gets data.
	; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					
					BLT	R5, OVERFLOW
	; Create Activation Record and invoke function getdata()
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
	; Passed Parameters onto the Stack -> no params for getdata()
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					
					JMP	getdata	; Call Function getdata
					
					;instruction where we return.
					
			;while loop(c[0] != '@') { // Check for stop symbol '@'
stopWhile			LDA R0, c
					LDB R1, R0
					LDB R2, atsign
					CMP R1, R2
					
					BRZ R1, endOfMain
				; if (c[0] == '+' || c[0] == '-') { // Determine sign
				  ;if (c[0] == '+')
					LDA R0, c
					LDB R1, R0			; R1 = c[0].
					LDB R2, plusSign
					CMP R1, R2			; if c[0] == '+' then R1 = 0.
				  ;if (c[0] == '-')
					LDB R3, R0
					LDB R2, minusSign
					CMP R3, R2			; if c[0] == '-' then R3 = 0.
					OR R1, R3
					BNZ R1, defaultSign	; c[0] !=  '+' or '-'
			; call the function getdata(); //gets data.
				; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
				; Create Activation Record and invoke function getdata()
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
				; Passed Parameters onto the Stack -> no params for getdata()
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					JMP	getdata	; Call Function getdata
					;instruction where we return.
					JMP whileData
defaultSign	  ; else {
				;c[1] = c[0]
					LDA R0, c			; R0 = addr c[0]
					LDB R1, R0			; R1 = c[0].
					ADI R0, 1			; R0 = addr c[1].
					STB R1, R0			; c[1] = c[0].;
				;c[0] = '+'
					LDA R0, c			; addr c[0]
					LDB R1, plusSign	; R1 = '+'
					STB R1, R0			; c[0] = '+'
				;cnt++;
					LDR R0, cnt
					ADI R0, 1			;R0++;
					STR R0, cnt			;cnt++;
					JMP whileData

whileData		;while (data) {  // Loop while there is data to process. true when data = 1. If data 0, branch.
					LDR R0, data
					LDR R1, ZERO
					CMP R0, R1
					BRZ R0, noData			; if data = 0 jump.
ifProcess		;if (c[cnt - 1] == '\n') { // Process data now
					LDA R0, c
					LDR R1, cnt
					LDR R2, ONE
					SUB R1, R2				; cnt - 1 offset
					ADD R0, R1				; c[cnt - 1] addr
					LDB R1, R0				; R1 = c[cnt - 1] value
					LDB R2, newline			; R2 = '\n'
					CMP R1, R2				; if R1 == R2, aka not BNZ.
					BNZ R1, elseProcess		; if R1 != R2, go to else.
				;data = 0;
					LDR R0, ZERO
					STR R0, data			; data = 0.
				;tenth = 1;
					LDR R0, ONE
					STR R0, tenth			; tenth = 1;
				;cnt = cnt - 2;
					LDR R0, cnt				; R0 = cnt
					LDR R1, ZERO
					ADI R1, 2				; R1 = 2
					SUB R0, R1				; R0 = cnt - 2.
					STR R0, cnt				; cnt = cnt - 2.
ComputeWhile	;while (!flag && cnt != 0) { // Compute a number
				  ;if (!flag {
					LDR R0, flag		
					LDR R1, ZERO
					CMP R0, R1
					BNZ R0, ifNotFlag		; if flag not 0 then branch
				  ;&& cnt != 0
					LDR R0, cnt
					CMP R0, R1				
					BRZ R0, ifNotFlag		; if cnt == 0 then branch.
			;opd(c[0], tenth, c[cnt]);
			  ; call the function opd(c[0], tenth, c[cnt]); // set opdv or print NAN.
			    ; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
				; Create Activation Record and invoke function opd(char s, int k, char j)
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
				; Passed Parameters onto the Stack (Pass by Value)
					LDA	R2, c
					LDR R1, cnt
					ADD R2, R1
					LDB R5, R2
					LDR R6, charSize
					SUB	SP, R6	
					STB	R5, SP			; Place c[cnt] on the Stack
					LDR R5, tenth
					LDR R6, wordSize
					SUB	SP, R6
					STR	R5, SP			; Place tenth on the Stack
					LDR R6, charSize
					SUB	SP, R6
					LDA R2, c
					LDB R5, R2
					STB	R5, SP			; Place c[0] on the Stack
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					JMP	opd		; Call Function opd
					;instruction where we return.
				;cnt--;
					LDR R0, cnt
					LDR R1, ONE
					SUB R0, R1
					STR R0, cnt
				;tenth *= 10;
					LDR R0, tenth
					LDR R1, ZERO
					ADI R1, 10
					MUL R0, R1
					STR R0, tenth
					JMP ComputeWhile
ifNotFlag		;if (!flag)  //  Good number entered
					LDR R0, flag
					LDR R1, ZERO
					CMP R0, R1
					BNZ R0, ifProcess		; if flag not 0 then branch
				;printf("Operand is %d\n", opdv);
					LDB R0, O
					TRP 3
					LDB R0, p
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, d
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, s
					TRP 3
					LDB R0, space
					TRP 3
					LDR R0, opdv
					TRP 1
					LDB R0, newline
					TRP 3
					JMP whileData
elseProcess	;getdata(); // Get next byte of data
			  ; call the function getdata(); //gets data.
				; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
				; Create Activation Record and invoke function getdata()
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
				; Passed Parameters onto the Stack -> no params for getdata()
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					JMP	getdata	; Call Function getdata
					;instruction where we return.
					JMP whileData
noData	;reset(1, 0, 0, 0);  // Reset globals
			; call the function reset(1, 0, 0, 0); // Reset globals
				; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
				; Create Activation Record and invoke function reset(w, x, y, z)
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
				; Passed Parameters onto the Stack (Pass by Value)
					LDR	R5, ZERO
					STR	R5, SP
					LDR R6, wordSize
					SUB	SP, R6	; Place 0 on the Stack
					STR	R5, SP
					SUB	SP, R6	; Place 0 on the Stack
					STR	R5, SP
					SUB	SP, R6	; Place 0 on the Stack
					LDR	R5, ONE
					STR	R5, SP
					SUB	SP, R6	; Place 1 on the Stack
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					JMP	reset	; Call Function reset
					;instruction where we return.

		; call the function getdata(); //gets data.
				; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
				; Create Activation Record and invoke function getdata()
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
				; Passed Parameters onto the Stack -> no params for getdata()
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					JMP	getdata	; Call Function getdata
					;instruction where we return.
					JMP stopWhile
endOfMain	; output done for ref.
					LDB R0, D
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, e
					TRP 3

;} end of main

FINISH				TRP 0

;end of main

;function / error handle for Overflow
OVERFLOW			LDB R0, O		;output something if overflow occurs.
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
					LDB R0, newline
					TRP 3
					JMP FINISH
;function / error handle for Underflow
UNDERFLOW			LDB R0, U		;output something if overflow occurs.
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
					LDB R0, newline
					TRP 3
					JMP FINISH

;void opd() function. Convert char j to an integer if possible.
	; If the flag is not set use the sign indicator s and the tenths indicator to compute the actual
	; value of j.  Add the value to the accumulator opdv.

opd
	; Allocate Space for Local (int t(18)) and three Temporary Variables (char s(14),int k(13),char j(9))
					LDR R6, ZERO
					ADI R6, 10 ; Fp - s(1) + k(4) + j(1) + t(4) = 10 bytes.
					SUB	SP, R6	; Space for Local t and 3 temp variables. 24 diff bet sp and fp?
	; Access Data on the Stack & Process.
				;int t = 0;  // Local var it will be FP - 14
					LDR R2, ZERO	; R2 holds t, initialized to zero.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				;store t (it's FP - 18')
					STR R2, R7				; local var t stored.

				;example for j initialized. FP - 9
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					MOV R7, FP				;grab local var t
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8				; R7 is t addr
					LDR R4, R7
				;use j here.
ifJ0			;if (j == '0')				// Convert
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					CMP R0, R1
					BNZ R0, ifJ1
				;t = 0;
					LDR R2, ZERO			; R2 val of 0
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
					STR R2, R7				; store 0 in R7. t = 0.
					JMP flagtest			; did if, go to instr after if block.
ifJ1			;else if (j == '1')
				  ;R6 still holds J.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
				  	LDR R1, ZERO
					ADI R1, 1
					CMP R0, R1
					BNZ R0, ifJ2
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 1				; R2 val of 1
				  ;R7 still addr of local var t.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 1 in R7. t = 1.
					JMP flagtest
ifJ2			;else if (j == '2')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 2
					CMP R0, R1
					BNZ R0, ifJ3
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 2				; R2 val of 2
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 2 in R7. t = 2.
					JMP flagtest
ifJ3			;else if (j == '3')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 3
					CMP R0, R1
					BNZ R0, ifJ4
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 3				; R2 val of 3
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 3 in R7. t = 3.
					JMP flagtest
ifJ4			;else if (j == '4')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 4
					CMP R0, R1
					BNZ R0, ifJ5
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 4				; R2 val of 4
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 4 in R7. t = 4.
					JMP flagtest
ifJ5			;else if (j == '5')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 5
					CMP R0, R1
					BNZ R0, ifJ6
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 5				; R2 val of 5
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 5 in R7. t = 5.
					JMP flagtest
ifJ6			;else if (j == '6')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 6
					CMP R0, R1
					BNZ R0, ifJ7
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 6				; R2 val of 6
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 6 in R7. t = 6.
					JMP flagtest
ifJ7			;else if (j == '7')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 7
					CMP R0, R1
					BNZ R0, ifJ8
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 7				; R7 val of 7
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 7 in R7. t = 7.
					JMP flagtest
ifJ8			;else if (j == '8')
				  ;R6 still holds J.
				  MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 8
					CMP R0, R1
					BNZ R0, ifJ9
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 8				; R2 val of 8
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 8 in R7. t = 8.
					JMP flagtest
ifJ9			;else if (j == '9')
				  ;R6 still holds J.
				  	MOV R7, FP
					LDR R8, ZERO
					ADI R8, 9
					SUB R7, R8
					LDB	R6, R7		 		; Access j ( c[cnt], g)
					MOV R0, R6
					TRP 10					; convert char j to int.
					LDR R1, ZERO
					ADI R1, 9
					CMP R0, R1
					BNZ R0, ifJELSE
				;t = 1;
					LDR R2, ZERO			
					ADI R2, 9				; R2 val of 9
				  ;R7 still addr of local var t.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8
				    STR R2, R7				; store 9 in R7. t = 9.
					JMP flagtest
ifJELSE			;printf("%c is not a number\n", j);
				  ;R6 holds char j.
				    MOV R0, R6
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, s
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, u
					TRP 3
					LDB R0, m
					TRP 3
					LDB R0, b
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, newline
					TRP 3
				;flag = 1;
					LDR R0, ZERO
					ADI R0, 1
					STR R0, flag
					JMP flagtest
flagtest		;if (!flag) {
					LDR R0, flag
					LDR R1, ZERO
					CMP R0, R1
					BNZ R0, opdEnd			; if flag not 0 then branch
				;if (s == '+')
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 14
					SUB R7, R8
					LDB	R6, R7		 		; Access s (c[0]), 5, g ,etc
					LDB R0, plusSign
					CMP R6, R0
					BNZ R6, flagELSE		; if s != '+' branch
				;t *= k;					; s == '+'
					MOV R7, FP				;grab local var t
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8				; R7 is t addr
					LDR R2, R7				; R2 = t.
					MOV R6, FP
					LDR R8, ZERO
					ADI R8, 13
					SUB R6, R8				; R6 addr of k.
					LDR	R5, R6		 		; R5 = Access val k.
					MUL R2, R5				; t *= k
					STR R2, R7				; store val R2 in addr t.
					JMP flagEnd
flagELSE		;else
				  ;t *= -k;
				  	MOV R7, FP				;grab local var t
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8				; R7 is t addr
					LDR R2, R7				; R2 = t.
					MOV R6, FP
					LDR R8, ZERO
					ADI R8, 13
					SUB R6, R8				; R6 addr of k.
					LDR	R5, R6		 		; R5 = Access val k.
					LDR R4, neg1
					MUL R5, R4				; R5 = -k.				
					MUL R2, R5				; t *= -k
					STR R2, R7				; store val R2 in addr t.
flagEnd			;opdv += t;
					LDR R0, opdv
					MOV R7, FP				;grab local var t
					LDR R8, ZERO
					ADI R8, 18
					SUB R7, R8				; R7 is t addr
					LDR R1, R7				; R1 = t.
					ADD R0, R1				; opdv += t;
					STR R0, opdv
opdEnd
	; There is no code for return as it's void.
	; Test for Underflow(SP > SB)
					MOV SP, FP	  ; De-allocate Current Activation Record 	(SP = FP)
					MOV R5, SP
					CMP R5, SB	  ; 0 (SP=SB), Pos (SP > SB), Neg (SP < SB)
					BGT	R5, UNDERFLOW
	; Set Previous Frame to Current Frame and Return
					LDR R5, FP		; Return Address Pointed to by FP
					LDR R6, PFPRTN
					ADD FP, R6		; Point at Previous Activation Record 	(FP = PFP)
					JMR R5
	; No code for return value, it's void.


;void flush() function. Discard keyboard input until a newline '\n' is encountered.

flush
	; Access Data on the Stack & Process.
				;data = 0;
					LDR R0, ZERO
					STR R0, data
				;c[0] = getchar();
					LDA R0, c
					TRP 4
					STB R0, c
flushWHILE		;while (c[0] != '\n')
					LDA R1, c
					LDB R0, R1
					LDB R1, newline
					CMP R0, R1			; c[0] != '\n'
					BRZ R0, flushAfterWHILE
				;c[0] = getchar();
					LDA R0, c
					TRP 4
					STB R0, c
					JMP flushWHILE
flushAfterWHILE		
	; There is no code for return as it's void.
	; Test for Underflow(SP > SB)
					MOV SP, FP	  ; De-allocate Current Activation Record 	(SP = FP)
					MOV R5, SP
					CMP R5, SB	  ; 0 (SP=SB), Pos (SP > SB), Neg (SP < SB)
					BGT	R5, UNDERFLOW
	; Set Previous Frame to Current Frame and Return
					LDR R5, FP		; Return Address Pointed to by FP
					LDR R6, PFPRTN
					ADD FP, R6		; Point at Previous Activation Record 	(FP = PFP)
					JMR R5
	; No code for return value, it's void.

;void getdata() function. Read one char at a time from keybaord after newline '\n' entered.
; place in c if room otherwise output num too big and flush.

getdata
	; Access Data on the Stack & Process.
				;see return value
					LDR R0, FP
					
				;if (cnt < SIZE) { // Get data if there is room
					LDR R2, cnt
					LDR R3, SIZE
					CMP R2, R3
					
					BRZ R2, getdataELSE		; branch of cnt >= SIZE
					BGT R2, getdataELSE
				;c[cnt] = getchar();
					LDR R2, cnt
					LDA R3, c				; R3 = base address c.
					ADD R3, R2				; R3 = base + offset. c[cnt].
					MOV R0, R3				; R0 = R3, c[cnt], so we can getchar.
					TRP 4					; R0 = getchar();
					STB R0, R3				; store getchar in c[cnt].
				;cnt++;
					LDR R2, cnt
					ADI R2, 1				; R2++;
					STR R2, cnt				; cnt++;
					JMP getdataDone
getdataELSE		;printf("Number too Big\n");
					LDB R0, N
					TRP 3
					LDB R0, u
					TRP 3
					LDB R0, m
					TRP 3
					LDB R0, b
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, o
					TRP 3
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, B
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, g
					TRP 3
					LDB R0, newline
					TRP 3
				;function call : flush();
	; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6	; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL	; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
	; Create Activation Record and invoke function flush()
					MOV	R3, FP	; Save FP in R3, this will be the PFP
					MOV	FP, SP	; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6	; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP	; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6	; Adjust Stack Pointer to New Top
	; Passed Parameters onto the Stack -> no params for flush().
					MOV R1, PC	; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7	; Compute Return Address (always a fixed amount)
					STR	R1, FP	; Return Address to the Beginning of the Frame
					JMP	flush	; Call Function flush()
					;instruction where we return.
getdataDone			;end of function getdata();
	; There is no code for return as it's void.
	; Test for Underflow(SP > SB)
					MOV SP, FP	  ; De-allocate Current Activation Record 	(SP = FP)
					MOV R5, SP
					CMP R5, SB	  ; 0 (SP=SB), Pos (SP > SB), Neg (SP < SB)
					BGT	R5, UNDERFLOW
	; Set Previous Frame to Current Frame and Return
					LDR R5, FP		; Return Address Pointed to by FP
					LDR R6, PFPRTN
					ADD FP, R6		; Point at Previous Activation Record 	(FP = PFP)
					JMR R5
	; No code for return value, it's void.

;reset(int w, int x, int y, int z) function. Reset c to all 0's and assign values to data, opdv, cnt, and flag.
reset
	; Allocate Space for Local (int k(24)) and four Temporary Variables (w(20), x(16), y(12), z(8))
					LDR R6, ZERO
					ADI R6, 20 ; Fp - ((word size * (n + 1))), where n is 4, 20 bytes. 
					SUB	SP, R6	; Space for Local k and four temp variables
	;  Access Data on the Stack & Process.
		;	for (k = 0; k < SIZE; k++)
		;	c[k] = 0;
					LDR R2, ZERO	; R2 holds k, initialized to zero.
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 24
					SUB R7, R8
				;store k (it's FP -24')
resetFOR			STR R2, R7				; local var k stored.
					; do the for loop
					LDR R2, R7				; R2 = k.
					LDR R3, SIZE			; R3 = const int size.
					CMP R2, R3				; k < SIZE
					BGT R2, assignData		; if negative then k < SIZE & true and we skip jumps.
					BRZ R2, assignData		; if k >= size then we're done with loops and take a branch.
				; assign c[k] = 0;
					LDA R2, c				; R2 = base addr of c.
					LDR R3, R7				; R3 = offset local var k.
					ADD R2, R3				; R2 = address of c[k] now.
					LDB R3, ZERO			; R3 = 0.
					STB R3, R2				; c[k] = 0.
				; increment k.
					LDR R2, R7				; R2 = value of k.
					ADI R2, 1				; R2 = k++;
					
					JMP resetFOR			; loop again
assignData			; then do data = w, store
					MOV R7, FP
					
					LDR R8, ZERO
					ADI R8, 20
					SUB R7, R8
					LDR	R6, R7		 		; Access w ( 1 )
					STR R6, data			; store value of 1 in data. data = w.
					; then do opdv = x, store
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 16
					SUB R7, R8
					LDR	R6, R7		 		; Access x ( 0 )
					STR R6, opdv			; store value of 0 in opdv. opdv = x.
					; then do cnt = y, store
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 12
					SUB R7, R8
					LDR	R6, R7		 		; Access y ( 0 )
					STR R6, cnt			; store value of 0 in cnt. cnt = y.
					; then do flag = z, store
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 8
					SUB R7, R8
					LDR	R6, R7		 		; Access z ( 0 )
					STR R6, flag			; store value of 0 in flag. flag = z.
	; There is no code for return as it's void.
	; Test for Underflow(SP > SB)
					MOV SP, FP	  ; De-allocate Current Activation Record 	(SP = FP)
					MOV R5, SP
					CMP R5, SB	  ; 0 (SP=SB), Pos (SP > SB), Neg (SP < SB)
					
					BGT	R5, UNDERFLOW
	; Set Previous Frame to Current Frame and Return
					LDR R5, FP		; Return Address Pointed to by FP
					LDR R6, PFPRTN
					ADD FP, R6		; Point at Previous Activation Record 	(FP = PFP)
					
					JMR R5
	; No code for return value, it's void.







	TRP 0