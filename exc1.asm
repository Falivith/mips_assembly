#Exercício 1 - Por Gabriel Ramires & Rafael Mattia

.data        
	array:    			
	.space 32 		# 32 Bytes (4x8) 
.text 

	move $t0, $zero		# t0 = Índice/iterador para acesso ao vetor
	ori $t1, $zero, 32	# t1 = 32 (condição de parada do FOR)
	ori $t2, $zero, 2	# t2 = usado para divisão/multiplicação por 2 (sim, sabemos da existência dos shifts!)
	move $t3, $zero		# t3 = A posição atual do vetor.
				# Os registradores t4-t7 são usados como temporários
	
	loop:
		beq $t0, $t1, saida        # for(i = 0; i < 8; i++)
		div $t3, $t2               # i%2 
		mfhi $t4                   # Resto da divisão 
		beq $zero, $t4, if         # if(i%2 == 0) executa if:
		j else
		
	if:
		mul $t4, $t3, $t2          # i * 2
		sw $t4, array($t0)         # vetor[i] = i * 2 
		j continua
		
	else:			   
		sub $t4, $t0, 4            # [i-1]
		lw $t5, array($t0)         # t5 = vetor[i]
		lw $t6, array($t4)         # t6 = vetor[i-1]
		add $t7, $t5, $t6          # t7 = vetor[i] + vetor[i+1]
		sw $t7, array($t0)         # vetor[i] = vetor[i] + vetor[i-1];
		
	continua:
		addi $t3, $t3, 1           # i++
		addi $t0, $t0, 4           # Índice[+4]
		j loop

	saida:
