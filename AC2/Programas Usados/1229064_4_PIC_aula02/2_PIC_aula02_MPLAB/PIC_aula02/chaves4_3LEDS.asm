#INCLUDE <P16F628A.INC>		;ARQUIVO PADR�O MICROCHIP PARA 16F628A
__CONFIG H'3F10'

#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA

#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAM�RIA

	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE USU�RIO
	ENDC			;FIM DO BLOCO DE MEM�RIA		

#DEFINE	BOTAO	PORTA,2	;PORTA DO BOT�O
					; 0 -> PRESSIONADO
					; 1 -> LIBERADO

#DEFINE	LED1	PORTB,0	;PORTA DO LED
				; 0 -> APAGADO
				; 1 -> ACESO

#DEFINE	LED2	PORTB,1	;PORTA DO LED
				; 0 -> APAGADO
				; 1 -> ACESO
#DEFINE	LED3	PORTB,2	;PORTA DO LED
				; 0 -> APAGADO
				; 1 -> ACESO


	ORG	0x00		;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
INICIO
	CLRF	PORTA		;LIMPA O PORTA
	CLRF	PORTB		;LIMPA O PORTB
	BANK1			;ALTERA PARA O BANCO 1
	MOVLW	B'00000100'
	MOVWF	TRISA		;DEFINE RA2 COMO ENTRADA E DEMAIS COMO SA�DAS
	MOVLW	B'00000000'
	MOVWF	TRISB		;DEFINE TODO O PORTB COMO SA�DA
	MOVLW	B'00000000'
	MOVWF	INTCON		;TODAS AS INTERRUP��ES DESLIGADAS
	BANK0			;RETORNA PARA O BANCO 0
	MOVLW	B'00000111'
	MOVWF	CMCON		;DEFINE O MODO DO COMPARADOR ANAL�GICO

MAIN

	BTFSC	BOTAO		;O BOT�O EST� PRESSIONADO?
	GOTO	MAIN            ; NAO, ESPERA SER PRESSIONADO
	GOTO	BOTAO_PRES1	;SIM, ENT�O TRATA BOT�O PRESSIONADO

BOTAO_PRES1
	BTFSS	BOTAO		;O BOT�O AINDA EST� PRESSIONADO?
	GOTO	BOTAO_PRES1	;SIM, ENT�O ESPERA DESLIGAR
	BSF	LED1		;NAO, ACENDE O LED1
	BCF	LED3		;APAGA O LED3
    GOTO    TESTA2

TESTA2
	BTFSC	BOTAO		;O BOT�O EST� PRESSIONADO?
	GOTO	TESTA2          ; N�O, ESPERA SER PRESSIONADO
	GOTO	BOTAO_PRES2	;SIM, ENT�O TRATA BOT�O PRESSIONADO

BOTAO_PRES2
	BTFSS	BOTAO		;O BOT�O AINDA EST� PRESSIONADO?
	GOTO	BOTAO_PRES2	;SIM, ENT�O ESPERA DESLIGAR
	BSF	LED2		;NAO, ACENDE O LED2
	BCF	LED1		;APAGA O LED1
	GOTO 	TESTA3		

TESTA3
	BTFSC	BOTAO		;O BOT�O EST� PRESSIONADO?
	GOTO	TESTA3          ; N�O, ESPERA SER PRESSIONADO
	GOTO	BOTAO_PRES3	;SIM, ENT�O TRATA BOT�O PRESSIONADO

BOTAO_PRES3
	BTFSS	BOTAO		;O BOT�O AINDA EST� PRESSIONADO?
	GOTO	BOTAO_PRES3	;SIM, ENT�O ESPERA DESLIGAR
	BSF	LED3		;NAO, ACENDE O LED3
	BCF	LED2		;APAGA O LED2
	GOTO 	MAIN		;RETORNA AO LOOP PRINCIPAL





	END			;OBRIGAT�RIO


