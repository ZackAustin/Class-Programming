Z 		.BYT 'Z'				;directives holding characters for name, spaces, newlines, etc
A 		.BYT 'A'
C 		.BYT 'C'
K 		.BYT 'K'
U		.BYT 'U'
S 		.BYT 'S'
T		.BYT 'T'
I 		.BYT 'I'
N 		.BYT 'N'
COMMA 	.BYT ','
SPACE 	.BYT 20
NEWLINE .BYT A		
A0 		.INT 1					;elements of lists A,B,C as integers.
A1 		.INT 2
A2 		.INT 3
A3 		.INT 4
A4 		.INT 5
A5		.INT 6
B0 		.INT 300
B1 		.INT 150
B2 		.INT 50
B3 		.INT 20
B4 		.INT 10
B5		.INT 5
C0 		.INT 500
C1 		.INT 2
C2 		.INT 5
C3 		.INT 10
ZERO 	.INT 0
ONE		.INT 1
MYNAME	LDB R0, A				;write name, one byte at a time.
		TRP 3
		LDB R0, U
		TRP 3
		LDB R0, S
		TRP 3
		LDB R0, T
		TRP 3
		LDB R0, I
		TRP 3
		LDB R0, N
		TRP 3
		LDB R0, COMMA
		TRP 3
		LDB R0, SPACE
		TRP 3
		LDB R0, Z
		TRP 3
		LDB R0, A
		TRP 3
		LDB R0, C
		TRP 3
		LDB R0, K
		TRP 3
BLANK1	LDB R0, NEWLINE			;Print out a newline character.
		TRP 3
ADDB01	LDR R0, B0				;add 1st 2 elements of B together.
		LDR R1, B1
		ADD R0, R1
		ADD R2, R0				;R2 stores cumulative result(final) of B.
		TRP 1
		LDB R0, SPACE
		TRP 3					;write out 2 spaces between each result.
		TRP 3
ADDB12	LDR R0, B1				;next 2 elements of B, etc
		LDR R1, B2
		ADD R0, R1
		ADD R2, R0
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
ADDB23	LDR R0, B2
		LDR R1, B3
		ADD R0, R1
		ADD R2, R0
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
ADDB34	LDR R0, B3
		LDR R1, B4
		ADD R0, R1
		ADD R2, R0
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
ADDB45	LDR R0, B4
		LDR R1, B5
		ADD R0, R1
		ADD R2, R0
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
BFINAL	LDR R0, ZERO			;zero out first register then add it with R2 which holds final of B.
		ADD R0, R2				
		LDR R3, ZERO
		ADD R3, R2
		TRP 1					;print B Final.
BLANK2	LDB R0, NEWLINE
		TRP 3
MULA01	LDR R0, A0				;multiply elements of A together.
		LDR R1, A1
		MUL R0, R1
		LDR R3, ONE
		MUL R3, R0				;R3 will hold cumulative(final) result of A.
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
MULA12	LDR R0, A1
		LDR R1, A2
		MUL R0, R1
		MUL R3, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
MULA23	LDR R0, A2
		LDR R1, A3
		MUL R0, R1
		MUL R3, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
MULA34	LDR R0, A3
		LDR R1, A4
		MUL R0, R1
		MUL R3, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
MULA45	LDR R0, A4
		LDR R1, A5
		MUL R0, R1
		MUL R3, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
AFINAL	LDR R0, ZERO			;Load Final of A from R3 into R0 to print result.
		ADD R0, R3
		LDR R4, ZERO
		ADD R4, R3
		TRP 1
BLANK3	LDB R0, NEWLINE
		TRP 3
DIVB0	LDR R0, ZERO			;Divide final results of B by each element of C.
		ADD R0, R3
		LDR R1, B0
		DIV R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
DIVB1	LDR R0, ZERO
		ADD R0, R2
		LDR R1, B1
		DIV R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
DIVB2	LDR R0, ZERO
		ADD R0, R2
		LDR R1, B2
		DIV R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
DIVB3	LDR R0, ZERO
		ADD R0, R2
		LDR R1, B3
		DIV R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
DIVB4	LDR R0, ZERO
		ADD R0, R2
		LDR R1, B4
		DIV R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
DIVB5	LDR R0, ZERO
		ADD R0, R2
		LDR R1, B5
		DIV R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
BLANK4	LDB R0, NEWLINE
		TRP 3
SUBC0	LDR R0, ZERO			;Subtract final result of A from each element of list C.
		ADD R0, R4
		LDR R1, C0
		SUB R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
SUBC1	LDR R0, ZERO
		ADD R0, R4
		LDR R1, C1
		SUB R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
SUBC2	LDR R0, ZERO
		ADD R0, R4
		LDR R1, C2
		SUB R0, R1
		TRP 1
		LDB R0, SPACE
		TRP 3
		TRP 3
SUBC3	LDR R0, ZERO
		ADD R0, R4
		LDR R1, C3
		SUB R0, R1
		TRP 1
		LDB R0, A				;write name, one byte at a time.
		TRP 3
		LDB R0, U
		TRP 3
		LDB R0, S
		TRP 3
		LDB R0, T
		TRP 3
		LDB R0, I
		TRP 3
		LDB R0, N
		TRP 3
		LDB R0, COMMA
		TRP 3
		LDB R0, SPACE
		TRP 3
		LDB R0, Z
		TRP 3
		LDB R0, A
		TRP 3
		LDB R0, C
		TRP 3
		LDB R0, K
		TRP 3
ENDP	TRP 0					;End of Assembly Program.


