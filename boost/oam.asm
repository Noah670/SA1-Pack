@include

ORG $008494
	LDA.B #CompressOAM
	STA $3180
	LDA.B #CompressOAM>>8
	STA $3181
	LDA.B #CompressOAM>>16
	STA $3182
	JMP $1E80

	NOP #34 ; freespace
warnpc $0084C8

!c (read1($008494+1)<<0)|(read1($008494+2+3+1)<<8)|(read1($008494+2+3+2+3+1)<<16)
	
freecode cleaned

CompressOAM:
	PHB
	LDA #$00
	PHA
	PLB
	
	LDY #$1E
-	LDX $8475,Y
	LDA $6423,X
	ASL
	ASL
	ORA $6422,X
	ASL
	ASL
	ORA $6421,X
	ASL
	ASL
	ORA $6420,X
	STA $6400,Y
	LDA $6427,X
	ASL
	ASL
	ORA $6426,X
	ASL
	ASL
	ORA $6425,X
	ASL
	ASL
	ORA $6424,X
	STA $6401,Y
	DEY
	DEY
	BPL -
	
	PLB
	RTL