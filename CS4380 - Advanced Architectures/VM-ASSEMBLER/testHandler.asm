DAGS			.BYT 'D'
				.BYT 'A'
				.BYT 'G'
				.BYT 'S'
DAGSNUM			.INT 0
NEWLINE			.BYT A		
INTDAGS			LDR R0, DAGS
				TRP 1 				; print integer DAGS
				STR R0, DAGSNUM		; store integer in DAGSNUM for later use.
				LDB R0, NEWLINE
				TRP 3
				LDR R0, DAGSNUM
				TRP 1
				TRP 0