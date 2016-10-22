;Zack Austin - Project 4 - 11/29/13

;static data

X_INPUT				.INT 1
Y_OUTPUT			.INT 2
ZERO				.INT 0
ONE					.INT 1
PFPRTN				.INT 8
wordSize			.INT 4
retAddr				.INT 60
threadCount			.INT 0
inputCount			.INT 0
a					.BYT 'a'
b					.BYT 'b'
c					.BYT 'c'
d					.BYT 'd'
e					.BYT 'e'
f					.BYT 'f'
g					.BYT 'g'
h					.BYT 'h'
i					.BYT 'i'
j					.BYT 'j'
k					.BYT 'k'
l					.BYT 'l'
m					.BYT 'm'
n					.BYT 'n'
o					.BYT 'o'
p					.BYT 'p'
q					.BYT 'q'
r					.BYT 'r'
s					.BYT 's'
t					.BYT 't'
u					.BYT 'u'
v					.BYT 'v'
w					.BYT 'w'
x					.BYT 'x'
y					.BYT 'y'
z					.BYT 'z'
A					.BYT 'A'
B					.BYT 'B'
C					.BYT 'C'
D					.BYT 'D'
E					.BYT 'E'
F					.BYT 'F'
G					.BYT 'G'
H					.BYT 'H'
I					.BYT 'I'
J					.BYT 'J'
K					.BYT 'K'
L					.BYT 'L'
M					.BYT 'M'
N					.BYT 'N'
O					.BYT 'O'
P					.BYT 'P'
Q					.BYT 'Q'
R					.BYT 'R'
S					.BYT 'S'
T					.BYT 'T'
U					.BYT 'U'
V					.BYT 'V'
W					.BYT 'W'
X					.BYT 'X'
Y					.BYT 'Y'
Z					.BYT 'Z'
space				.BYT 20
newline				.BYT A
atsign				.BYT '@'
plusSign			.BYT '+'
minusSign			.BYT '-'
#					.BYT '#'
char1				.BYT '1'
char2				.BYT '2'
char3				.BYT '3'
:					.BYT ':'
MUTEX				.INT -1
xCount				.INT 0
arrSize				.INT 0
capacity			.INT 29
cnt					.INT 0
printCntr			.INT 0
factArray			.INT 0			;30 elements
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
					.INT 0
;main

PART1 ;RECURSIVE FACTORIAL FUNCTION
	;Part 1 Message
					TRP 99
					LDB R0, P
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, char1
					TRP 3
					LDB R0, :
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, F
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, c
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, l
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, F
					TRP 3
					LDB R0, u
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, c
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, newline
					TRP 3
					TRP 3
whileUInput
;while capacity <= 30.
					LDR R0, arrSize
					LDR R1, capacity
					CMP R0, R1
					BGT R0, PART2			; if arrSize > 30, moveon to part2.
;ask for input, X_INPUT
					LDB R0, E
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, I
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, g
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, :
					TRP 3
					LDB R0, space
					TRP 3
					TRP 2
					STR R0, X_INPUT
				;while X_INPUT != 0
					LDR R0, X_INPUT
					LDR R1, ZERO
					CMP R0, R1
					BRZ R0, PART2			; if X_INPUT == 0, moveon to part2.
		;perform while, call recursive function on X_INPUT.
  ;call factorial function with input.
	; Test for overflow (SP <  SL) 			; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6				; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL				; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
	; Create Activation Record and invoke function fact(int X_INPUT)
					MOV	R3, FP				; Save FP in R3, this will be the PFP
					MOV	FP, SP				; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6				; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP				; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6				; Adjust Stack Pointer to New Top
	; Passed Parameters onto the Stack (Pass by Value)
					LDR	R5, X_INPUT
					STR	R5, SP
					LDR R6, wordSize
					SUB	SP, R6				; Place X_INPUT on the Stack
					MOV R1, PC				; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7				; Compute Return Address (always a fixed amount)
					STR	R1, FP				; Return Address to the Beginning of the Frame
					JMP	fact				; Call Function fact
					;instruction where we return.
	; Code to return value of function fact
					LDR	R5, SP				; Instruction where we return – Access return value
					STR	R5, Y_OUTPUT		; Store return value in Y_OUTPUT
	; Write X_INPUT and Y_OUTPUT into both sides of array.
					LDA R0, factArray		; R0 = baseAddress of factArray.
					LDR R1, cnt
					LDR R2, wordSize
					MUL R1, R2				; R1 = offset to front of factArray.
					ADD R0, R1				; R0 = factArray[cnt];
					LDR R1, X_INPUT
					STR R1, R0				; factArray[cnt] = X_INPUT;
					LDA R0, factArray		; R0 = baseAddress of factArray.
					LDR R1, capacity
					LDR R2, wordSize
					MUL R1, R2
					LDR R2, cnt
					LDR R3, wordSize
					MUL R2, R3
					SUB R1, R2				; R1 = offset to back of factArray.
					ADD R0, R1				; R0 = factArray[cnt];
					LDR R1, Y_OUTPUT
					STR R1, R0				; factArray[cnt] = Y_OUTPUT;
	; Update counter variable
					LDR R0, cnt
					ADI R0, 1
					STR R0, cnt				; cnt++;
					LDR R0, arrSize
					ADI R0, 2
					STR R0, arrSize			; arrSize += 2;
;Print: Factorial of X is Y
					LDB R0, F
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, c
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, l
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, f
					TRP 3
					LDB R0, space
					TRP 3
					LDR R0, X_INPUT
					TRP 1
					LDB R0, space
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, s
					TRP 3
					LDB R0, space
					TRP 3
					LDR R0, Y_OUTPUT
					TRP 1
					LDB R0, newline
					TRP 3
					TRP 3
					JMP whileUInput
PART2 ;ADDRESSING MODE
			;lower cnt by 1..
					LDR R0, cnt
					LDR R1, ONE
					SUB R0, R1
					STR R0, cnt
	;Part 2 Message
					LDB R0, newline
					TRP 3
					LDB R0, P
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, char2
					TRP 3
					LDB R0, :
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, P
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, A
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, y
					TRP 3
					LDB R0, newline
					TRP 3
					TRP 3
	;Print Factorial Array
PRINTFACTARRAY
				;while(cnt >= 0)
					LDR R0, cnt
					LDR R1, ZERO
					CMP R0, R1
					BLT R0, PART3
				;print..
					LDB R0, F
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, c
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, l
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, f
					TRP 3
					LDB R0, space
					TRP 3
				;get X_INPUT from array.
					LDA R0, factArray		; R0 = baseAddress of factArray.
					LDR R1, printCntr
					LDR R2, wordSize
					MUL R1, R2				; R1 = offset to front of factArray.
					ADD R0, R1				; R0 = factArray[cnt] Addr;
					LDR R0, R0				; R0 = factArray[cnt] value..;
					TRP 1					; print X_INPUT;
					LDB R0, space
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, s
					TRP 3
					LDB R0, space
					TRP 3
				;get Y_OUTPUT from array.
					LDA R0, factArray		; R0 = baseAddress of factArray.
					LDR R1, capacity
					LDR R2, wordSize
					MUL R1, R2
					LDR R2, printCntr
					LDR R3, wordSize
					MUL R2, R3
					SUB R1, R2				; R1 = offset to back of factArray.
					ADD R0, R1				; R0 = factArray[cnt] Addr;
					LDR R0, R0				; R0 = factArray[cnt] value..;
					TRP 1					; print Y_OUTPUT;
					LDB R0, newline
					TRP 3
				;incr printCntr, decr cnt
					LDR R0, printCntr
					ADI R0, 1
					STR R0, printCntr
					LDR R0, cnt
					LDR R1, ONE
					SUB R0, R1
					STR R0, cnt
					JMP PRINTFACTARRAY

PART3 ;MULTITHREADING
	;Reset Array Counters
					LDR R0, ZERO
					STR R0, cnt
					STR R0, arrSize
					STR R0, printCntr
	;Part 3 Message
					LDB R0, newline
					TRP 3
					LDB R0, P
					TRP 3
					LDB R0, A
					TRP 3
					LDB R0, R
					TRP 3
					LDB R0, T
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, char3
					TRP 3
					LDB R0, :
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, M
					TRP 3
					LDB R0, u
					TRP 3
					LDB R0, l
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, minusSign
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, h
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, d
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, g
					TRP 3
					LDB R0, newline
					TRP 3
		;msg for # of threads
					LDB R0, newline
					TRP 3
					LDB R0, E
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, #
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, f
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, h
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, d
					TRP 3
					LDB R0, s
					TRP 3
					LDB R0, :
					TRP 3
					LDB R0, space
					TRP 3
					TRP 2
					STR R0, threadCount
					STR R0, inputCount
THREAD_INPUTS
		;ask for input, X_INPUT for each thread
			;while inputCount != 0
					LDR R0, inputCount
					LDR R1, ZERO
					CMP R0, R1
					BRZ R0, THREADCALLING
					BLT R0, THREADCALLING
			;Enter Integer Msg:
					LDB R0, E
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, I
					TRP 3
					LDB R0, n
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, g
					TRP 3
					LDB R0, e
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, :
					TRP 3
					LDB R0, space
					TRP 3
					TRP 2
			;find array position
					LDA R1, factArray
					LDR R2, cnt
					LDR R3, wordSize
					MUL R2, R3
					ADD R1, R2
					STR R0, R1
			;increment vars
					LDR R0, cnt
					ADI R0, 1
					STR R0, cnt
					LDR R0, arrSize
					ADI R0, 2
					STR R0, arrSize
					LDR R0, inputCount
					LDR R1, ONE
					SUB R0, R1
					STR R0, inputCount
					JMP THREAD_INPUTS
			;instantiate threads
THREADCALLING
				;while threadCount > 0
					LDR R0, threadCount
					LDR R1, ZERO
					CMP R0, R1
					BRZ R0, THREADBLOCKING
					BLT R0, THREADBLOCKING
				;call threads
					RUN R0, callfact
					LDR R0, xCount
					ADI R0, 1
					STR R0, xCount
					LDR R0, threadCount
					LDR R1, ONE
					SUB R0, R1
					STR R0, threadCount
					JMP THREADCALLING
LOCKING
		;Message
					LDB R0, F
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, c
					TRP 3
					LDB R0, t
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, r
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, a
					TRP 3
					LDB R0, l
					TRP 3
					LDB R0, space
					TRP 3
					LDB R0, o
					TRP 3
					LDB R0, f
					TRP 3
					LDB R0, space
					TRP 3
		;set lock, grab return value, put into array, unlock, End thread
					LCK MUTEX
				;grab cnt and array position for X
					LDA R1, factArray
					LDR R2, printCntr
					LDR R3, wordSize
					MUL R2, R3
					ADD R1, R2
					LDR R0, R1
					TRP 1
					ULK MUTEX
					LDB R0, space
					TRP 3
					LDB R0, i
					TRP 3
					LDB R0, s
					TRP 3
					LDB R0, space
					TRP 3
					LCK MUTEX
				; Code to return value of function fact
					LDR	R5, SP				; Instruction where we return – Access return value
					STR	R5, Y_OUTPUT		; Store return value in Y_OUTPUT
				;grab cnt and array position for Y
					LDA R0, factArray		; R0 = baseAddress of factArray.
					LDR R1, capacity
					LDR R2, wordSize
					MUL R1, R2
					LDR R2, printCntr
					LDR R3, wordSize
					MUL R2, R3
					SUB R1, R2				; R1 = offset to back of factArray.
					ADD R0, R1				; R0 = factArray[cnt];
					LDR R1, Y_OUTPUT
					STR R1, R0				; factArray[cnt] = Y_OUTPUT;
					LDR R0, R0
					TRP 1
					LDR R0, printCntr
					ADI R0, 1
					STR R0, printCntr
				;unlock and end thread
					ULK MUTEX
					LDB R0, newline
					TRP 3
					END		
THREADBLOCKING		BLK

FINISH				
					LDB R0, newline
					TRP 3
					LDB R0, F
					TRP 3
					LDB R0, I
					TRP 3
					LDB R0, N
					TRP 3
					LDB R0, I
					TRP 3
					LDB R0, S
					TRP 3
					LDB R0, H
					TRP 3
					LDB R0, E
					TRP 3
					LDB R0, D
					TRP 3
					TRP 0
	;end so far

callfact			;call factorial function with input.
	; Test for overflow (SP <  SL) 			; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6				; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL				; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
	; Create Activation Record and invoke function fact(int X_INPUT)
					MOV	R3, FP				; Save FP in R3, this will be the PFP
					MOV	FP, SP				; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6				; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP				; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6				; Adjust Stack Pointer to New Top
	; Passed Parameters onto the Stack (Pass by Value)
					LDA R0, factArray
					LDR R1, xCount
					LDR R2, ONE
					SUB R1, R2
					LDR R2, wordSize
					MUL R1, R2
					ADD R0, R1
					LDR	R5, R0
					STR	R5, SP
					LDR R6, wordSize
					SUB	SP, R6				; Place X_INPUT on the Stack
					MOV R1, PC				; PC incremented by 1 instruction
					LDR R7, retAddr
					ADD	R1, R7				; Compute Return Address (always a fixed amount)
					STR	R1, FP				; Return Address to the Beginning of the Frame
					JMP	fact				; Call Function fact
					;instruction where we return.
					JMP LOCKING

fact				
; Allocate Space for Local Variable n and no Temporary Variables
					LDR R6, ZERO
					ADI R6, 4				; Fp - ((word size * (n + 1))), where n is 1, 4 bytes. 
					SUB	SP, R6				; Space for Local n.
					
	;  Access Data on the Stack & Process.
		;if (n == 0)
			;  Access Data on the Stack
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 8
					SUB R7, R8
					LDR	R2, R7		 		; Access n ( X_INPUT )
					
			; Compare n with 0. Branch depending.
					LDR R0, ZERO
					CMP R2, R0
					BNZ R2, RECURSIVECASE
			; return 1
					LDR R2, ZERO
					ADI R2, 1
					JMP factEND
RECURSIVECASE
			; return n * fact(n - 1)
			  ;function call : fact(n - 1);
				;  Access Data on the Stack
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 8
					SUB R7, R8
					LDR	R2, R7		 		; Access n ( X_INPUT )
					LDR R7, ONE
					SUB R2, R7				; R2 = n - 1.
			  ;call factorial function with input.
				; Test for overflow (SP <  SL) 	; Must compute space needed for Frame
					MOV R5, SP
					LDR R6, PFPRTN
					SUB	R5, R6				; Adjust for space needed (Rtn Address & PFP)
					CMP R5, SL				; 0 (SP=SL), Pos (SP > SL), Neg (SP < SL)
					BLT	R5, OVERFLOW
				; Create Activation Record and invoke function fact(int X_INPUT)
					MOV	R3, FP				; Save FP in R3, this will be the PFP
					MOV	FP, SP				; Point at Current Activation Record (FP = SP)
					LDR R6, wordSize
					SUB	SP, R6				; Adjust Stack Pointer to New Top (Rtn Address)
					STR	R3, SP				; PFP to Top of Stack 			(PFP = FP)
					SUB	SP, R6				; Adjust Stack Pointer to New Top
				; Passed Parameters onto the Stack (Pass by Value)
					MOV R5, R2
					STR	R5, SP
					LDR R6, wordSize
					SUB	SP, R6				; Place X_INPUT on the Stack
					MOV R1, PC				; PC incremented by 1 instruction, breaks
					LDR R7, retAddr
					ADD	R1, R7				; Compute Return Address (always a fixed amount)
					STR	R1, FP				; Return Address to the Beginning of the Frame
					JMP	fact				; Call Function fact
				;instruction where we return. Get return value and times it.
				; New Code to return value of function fact
					LDR	R5, SP				; Instruction where we return – Access return value
				  ;Access n again.	
					MOV R7, FP
					LDR R8, ZERO
					ADI R8, 8
					SUB R7, R8
					LDR	R2, R7		 		; Access n ( X_INPUT )
					MUL R2, R5				; n = n * fact(n-1)
factEND
; New Code for return of n
					MOV	R9, R2				; Save the value of n in R9
; Test for Underflow
					MOV SP, FP				; De-allocate Current Activation Record (SP = FP)
					MOV R5, SP
					CMP R5, SB				; 0 (SP=SB), Pos (SP > SB), Neg (SP < SB)
					BGT	R5, UNDERFLOW
; Previous Frame is Current Frame and Return
					LDR R5, FP				; Return Address Pointed to by FP
					LDR R6, PFPRTN
					ADD FP, R6				; PFPRTN + space for n.
					ADI FP, 8				; Point at Previous Activation Record 	(FP = PFP)
; New Code for return of n
					STR	R9, SP				; Store the value of K on the top of the Stack
					JMR	R5					; Jump to Address in Register R5

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