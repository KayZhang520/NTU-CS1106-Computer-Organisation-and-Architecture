;things covered in this program: BLBX subroutine, switch statement with jump table, if-else?

Grades		DCD		0x41414342,0x44444342,0x00414242 ;DCD instruction allocates 4 bytes memory for each of the 3 values at beginning of runtime
Band1		FILL		4	;FILL instruction reserves a block of memory to fill with a given value, here it reserves 4 bytes of memory!
Band2		Fill		4
Band3		Fill		4
Base			DCD		0x70,0x78,0x80,0x88
			
			ADR		R3,Grades
			ADR		R2,Band1 ;band 1 = grade A
			ADR		R1,Band2 ;band 2 = grade B
			ADR		R0,Band3 ;band 3 = grade C or D
			STMFD	SP!,{R0-R3}
			BL		Cal_grades
			LDMFD	SP!,{R0-R3}
			END
			
Cal_grades	STMFD	SP!,{R4-R9}
			ADR		R9 ,Base
			MOV		R4 ,#0
			MOV		R5 ,#0
			MOV		R6 ,#0
			LDR		R8,[SP,#36]
Loop			LDRB		R7,[R8],#1
			CMP		R7,#0
			BEQ		Done
			SUB		R7, R7, #65
			LDR		PC,[R9,R7,LSL #2] ;the locations of the jumps to cond1, cond2.. are pre-calculated:
			;		Cond1 is at 27*4+8 +4 = 124, where 27 is the number of instructions before itself
Return		B		Loop
Done			LDR		R8,[SP,#32]
			STR		R4,[R8] ;store the band 1 count in r4 to memory ref saved in stack
			LDR		R8,[SP,#28] 
			STR		R5,[R8] ;store the band 2 count in r5 to memory ref saved in stack
			LDR		R8,[SP,#24]
			STR		R6,[R8] ;store the band 3 count in r6 to memory ref saved in stack
			LDMFD	SP!,{R4-R9} ;restores the original values of R9 to R4
			MOV		PC, LR
			
Cond1		ADD		R4,R4,#1 ;R7 or x = 0 correspond to grade A, so we increment band 1 count
			B		Return
Cond2		ADD		R5,R5,#1 ;R7 or x = 1 correspond to grade B, so we increment band 2 count
			B		Return
Cond3		ADD		R6,R6,#1 ;R7 or x = 2 correspond to grade C, so we increment band 3 count
			B		Return
Cond4		ADD		R6,R6,#1 ;R7 or x = 2 correspond to grade D, so we increment band 3 count
			B		Return
