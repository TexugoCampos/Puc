;************** PROVA - PROGRAMA PARA PISCAR LED COM TEMPO ESPEC�FICO*****************GABRIEL CAMPOS
LIST   P=PIC16F628A
RADIX DEC	
#INCLUDE <P16F628A.INC>
	__CONFIG _INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _BODEN_OFF & _LVP_OFF & _CP_OFF & _MCLRE_OFF & _DATA_CP_OFF 
	;ou __CONFIG H'3F10'

	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE
					;USU�RIO
	CONTADOR1
	CONTADOR2
	ENDC			;FIM DO BLOCO DE MEM�RIA		
	
	ORG	0x00		;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
		
INICIO
	CLRF	PORTA		;LIMPA O PORTA
	CLRF	PORTB		;LIMPA O PORTB
	BSF STATUS, RP0
	CLRF TRISB
	BCF STATUS, RP0

REPETE
	BSF PORTB, 1		;ACENDE O LED
	CALL ATRASO			;CHAMA O PRIMEIRO ATRASO QUE � UM LOOP PARA GASTAR TEMPO,LOOP DE 3 CHAMADAS
	CALL ATRASO			;CHAMA O SEGUNDO ATRASO QUE � UM LOOP PARA GASTAR TEMPO,LOOP DE 3 CHAMADAS.
	CALL ATRASO			
	CALL ATRASO					
	CALL ATRASO
	CALL FIM			;CHAMA UM ATRASO MENOR,QUE � UM LOOP QUE GASTA TEMPO,LOOP DE 2 CHAMADAS
	CALL FIM
	CALL FIM
	CALL FIM
	CALL FIM
	NOP					;INSTRU��O PARA GASTAR UM MICRO SEGUNDO
	NOP	
	NOP
	NOP
	NOP
	BCF PORTB, 1		;APAGA O LED
	CALL ATRASO
	CALL ATRASO
	CALL ATRASO
	CALL ATRASO
	CALL ATRASO
	CALL FIM
	CALL FIM
	CALL FIM
	CALL FIM
	CALL FIM
	NOP	
	NOP
	NOP
	NOP
	NOP
	GOTO REPETE
FIM
	MOVLW	206				;MOVE O VALOR 206 PARA O W
	MOVWF	CONTADOR1		;MOVE O W PARA CONTADOR1
	GOTO FIN				;VA PARA O FIN
	GOTO FINAL				;VA PARA O FINAL
FIN
	DECFSZ CONTADOR1		;DIMINUI 1 DO CONTADOR 1,PULA PROX LINHA SE CHEGAR A 0
	GOTO FIN				;VA PARA O FIN
	RETURN					;RETORNE PARA QUEM CHAMOU O METODO
FINAL
	DECFSZ CONTADOR1		;DIMINUI 1 DO CONTADOR 1,PULA PROX LINHA SE CHEGAR A 0
	GOTO FINAL				;VA PARA O FINAL
	RETURN					;RETORNE PARA QUEM CHAMOU O METODO
ATRASO					
	MOVLW	163				;W RECEBE 163
	MOVWF	CONTADOR1		;CONTADOR1 RECEBE W
	MOVWF	CONTADOR2		;CONTADOR2 RECEBE W
	GOTO ATRASO1			;VA PARA ATRASO1
ATRASO1				
	DECFSZ  CONTADOR1		;DIMINUI 1 DO CONTADOR 1,PULA PROX LINHA SE CHEGAR A 0
	GOTO	ATRASO3			;VA PARA ATRASO3
	RETURN					;RETORNE PARA QUEM CHAMOU O METODO
ATRASO2
	DECFSZ	CONTADOR2		;DIMINUI 1 DO CONTADOR 2,PULA PROX LINHA SE CHEGAR A 0
	GOTO ATRASO2			;VA PARA ATRASO2
	GOTO ATRASO1			;VA PARA ATRASO1
	RETURN					;RETORNO PARA QUEM CHAMOU O METODO
ATRASO3
	DECFSZ	CONTADOR2		;DIMINUI 1 DO CONTADOR 2,PULA PROX LINHA SE CHEGAR A 0
	GOTO ATRASO3			;VA PARA ATRASO3
	GOTO ATRASO2			;VA PARA ATRASO2
	GOTO ATRASO1			;VA PARA ATRASO1
	RETURN					;RETORNO PARA QUEM CHAMOU ESSE METODO

	

END