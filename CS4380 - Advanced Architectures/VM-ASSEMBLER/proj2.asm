;Zack Austin - CS 4380 Project 2 - 10/27/13

SIZE			.INT 10
arr				.INT 10
				.INT 2
				.INT 3
				.INT 4
				.INT 15
				.INT -6
				.INT 7
				.INT 8
				.INT 9
				.INT 10
inti 			.INT 0
sum				.INT 0
temp			.INT 0
DAGSNUM			.INT 0
GADSNUM			.INT 0
DAGS			.BYT 'D'
				.BYT 'A'
				.BYT 'G'
				.BYT 'S'
D				.BYT 'D'
G				.BYT 'G'
ZERO			.BYT 0
ONE				.BYT 1
TWO				.BYT 2
THREE			.BYT 3
FOUR			.BYT 4
i 				.BYT 'i'
s 				.BYT 's'
SPACE			.BYT 20
e 				.BYT 'e'
v				.BYT 'v'
n 				.BYT 'n'
NEWLINE			.BYT A
o 				.BYT 'o'
d 				.BYT 'd'
S 				.BYT 'S'
u				.BYT 'u'
m 				.BYT 'm'
subtractSign	.BYT '-'
EQUAL			.BYT '='
incrTWO			.INT 2
WHILEARR		LDR R0, inti
				LDR R1, SIZE
				CMP R0, R1
				BRZ R0, PRINTSUM	; Branch out of while if (i == Size) otherwise go to next instruction which adds to sum.
SUMINCREMENT	LDR R0, sum 		; R0 = sum;
				LDA R1, arr			; R1 = Base Address of arr
				LDR R2, inti		; R2 = offset i
				LDB R3, FOUR		; R3 = size of offset i
				MUL R2, R3			; R2 = i * 4 (aka offset)
				ADD R1, R2			; R1 = holds address of arr[i] now
				LDR R4, R1			; R4 = contents of arr[i]
				ADD R0, R4			; R0 => sum += arr[i]
				STR R0, sum			; store result back into memory.
RESULTMODULUS	LDB R0, ZERO		; R0 = 0, this section does:	result = arr[i] % 2
				LDB R2, TWO			; R2 = 2
				LDB R3, ZERO		; R3 = 0
				ADD R3, R1			; R3 = address of arr[i] for printf.
				LDR R3, R3			; R3 = value of arr[i].
				LDR R1, R1			; R1 = value of arr[i].
				DIV R1, R2			; R1 = arr[i] / 2
				MUL R1, R2			; R1 = arr[i] * 2 (except possibly remainder from int div)
				SUB R3, R1			; R3 = result (remainder). holds remainder in R3.
IFRESULTZERO	LDB R0, ZERO
				CMP R3, R0
				BNZ	R3, ELSERESULT	; if not zero skip to else
PRINTEVEN		LDA R1, arr			; R1 = Base Address of arr. if BNZ doesnt branch then do if block, printf.
				LDR R2, inti		; R2 = offset i
				LDB R3, FOUR		; R3 = size of offset i
				MUL R2, R3			; R2 = i * 4 (aka offset)
				ADD R1, R2			; R1 = holds address of arr[i] now
				LDR R0, R1			; R0 = value of arr[i]
				TRP 1 				; print arr[i]
				LDB R0, SPACE
				TRP 3
				LDB R0, i			
				TRP 3
				LDB R0, s
				TRP 3
				LDB R0, SPACE
				TRP 3
				LDB R0, e
				TRP 3
				LDB R0, v
				TRP 3
				LDB R0, e
				TRP 3
				LDB R0, n
				TRP 3
				LDB R0, NEWLINE
				TRP 3
				JMP INCREMENTI				
ELSERESULT		LDA R0, arr			; R0 = Base Address of arr. if BNZ branched do else and printf odd.
				LDR R2, inti		; R2 = offset i
				LDB R3, FOUR		; R3 = size of offset i
				MUL R2, R3			; R2 = i * 4 (aka offset)
				ADD R0, R2			; R0 = holds address of arr[i] now	
				LDR R0, R0			; R0 = value of arr[i]
				TRP 1 				; print arr[i]
				LDB R0, SPACE
				TRP 3			
				LDB R0, i			
				TRP 3
				LDB R0, s
				TRP 3
				LDB R0, SPACE
				TRP 3
				LDB R0, o
				TRP 3
				LDB R0, d
				TRP 3
				LDB R0, d
				TRP 3
				LDB R0, NEWLINE
				TRP 3
INCREMENTI		LDR R0, inti
				LDB R1, ONE
				ADD R0, R1
				STR R0, inti
				JMP WHILEARR
PRINTSUM		LDB R0, S			
				TRP 3
				LDB R0, u
				TRP 3
				LDB R0, m
				TRP 3
				LDB R0, SPACE
				TRP 3
				LDB R0, i
				TRP 3
				LDB R0, s
				TRP 3
				LDB R0, SPACE
				TRP 3
				LDR R0, sum
				TRP 1
				LDB R0, NEWLINE
				TRP 3
				LDB R0, NEWLINE
				TRP 3				; print newline
PART2			LDB R0, DAGS
CHARDAGS		TRP 3				; print char D
				LDA R0, DAGS
				LDB R1, ONE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char A
				LDA R0, DAGS
				LDB R1, TWO
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char G
				LDA R0, DAGS
				LDB R1, THREE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char S
				LDB R0, SPACE
				TRP 3				; print a space
INTDAGS			LDR R0, DAGS
				TRP 1 				; print integer DAGS
				STR R0, DAGSNUM		; store integer in DAGSNUM for later use.
				LDB R0, NEWLINE
				TRP 3				; print newline
SWAPDG			LDB R0, G
				STB R0, DAGS		; G stored for D.
				LDA R1, DAGS
				ADI R1, 2			; R1 is memory location for G.
				LDB R0, D
				STB R0, R1
CHARGADS		LDB R0, DAGS
				TRP 3				; print char G
				LDA R0, DAGS
				LDB R1, ONE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char A
				LDA R0, DAGS
				LDB R1, TWO
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char D
				LDA R0, DAGS
				LDB R1, THREE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char S
				LDB R0, SPACE
				TRP 3				; print a space
INTGADS			LDR R0, DAGS
				TRP 1 				; print integer GADS
				STR R0, GADSNUM		; store integer in GADSNUM for later use.
				LDB R0, NEWLINE
				TRP 3				; print newline
GADSAGAIN		LDB R0, DAGS
				TRP 3				; print char G
				LDA R0, DAGS
				LDB R1, ONE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char A
				LDA R0, DAGS
				LDB R1, TWO
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char D
				LDA R0, DAGS
				LDB R1, THREE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char S
				LDB R0, subtractSign
				TRP 3				; print char -
DAGSAGAIN		LDB R0, D
				TRP 3				; print char D
				LDA R0, DAGS
				LDB R1, ONE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char A
				LDB R0, G
				TRP 3				; print char G
				LDA R0, DAGS
				LDB R1, THREE
				ADD R1, R0
				LDB R0, R1
				TRP 3				; print char S
				LDB R0, SPACE
				TRP 3				; print a space
				LDB R0, EQUAL
				TRP 3				; print an equal sign
				LDB R0, SPACE
				TRP 3				; print a space
SUBTHEM			LDR R1, DAGSNUM		; DAGS
				LDR R0, GADSNUM		; GADS
				SUB R0, R1			; (GADS - DAGS)
				TRP 1
END				TRP 0