		;		; this code uses a branch instruction to count the number of 1's in a number(here it is 63), and store in R2
		
		;ANS		GIVEN, code written as subroutine
		MOV		R0, #32 ;r0 set as counter
		MOV		R1, #63
		MOV		R2, #0
loop		RRXS		R1, R1
		ADC		R2, R2, #0
		SUBS		R0, R0, #1
		BNE		loop ;if have not looped 32 times, continue looping
		MOV		PC, LR ;return the program back to main flow
		
		
		
		
		
		
		
		
