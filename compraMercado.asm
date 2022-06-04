#BY: Rilton Max, Victor Ramalho

.data
	pedircompra: .asciiz "Informe o valor da compra: "
    
	erro: .asciiz "Não tem dinheiro para realizar essa compra"
	mensagem: .asciiz "Valor da compra: "
	espaco: .asciiz " "
	quebraLinha: .ascii "\n"
.text
	li $t1, 0 #nota de 20
	li $t2, 0 #nota de 10
	li $t3, 0 #nota de 5
	li $t4, 0 #nota de 2
	li $t5, 0 #moeda de 1
	
	#imprime string
	li $v0, 4
	#carregando a string
	la $a0, pedircompra
	#realiza a "interação", Mensagem de entrada da compra
	syscall #pedindo o valor da compra

	#Entrada de dados
	li $v0, 5
	la $a0, compra
	syscall
	#copiando valor de v0 para t0
	move $t0, $v0
	#copiando o valor da compra para exibir no final
	move $t6, $t0
	
	maior100:
		bgt $t0, 100, printErro #direciona para o caso de erro
		ble $t0, 100, while #direciona diretamente ao while
		
	printErro: #Caso não possua dinheiro suficiente
		li $v0, 4
		la $a0, erro
		syscall
		
		j saida #f=programa finaliza
		
	while:
		beq $t0, 0, printResultadoFinal #se o valor passado chegar a zero, o programa vai para imprimir a quantia gasta
		
		bge $t0, 20, verificaQuant20 #verifica se ainda possui nota de 20
		
		bge $t0, 10, verificaQuant10 #verifica se ainda possui nota de 10
		
		bge $t0, 5, verificaQuant5 #verifica se ainda possui nota de 5
		
		bge $t0, 2, verificaQuant2 #verifica se ainda possui nota de 2
		
		bge $t0, 1, verificaQuant1 #verifica se ainda possui moeda de 1
		
		
	verificaQuant20: #abate 20 na compra e conta a quantidade de notas utilizadas
		beq $t1, 2, verificaQuant10 #quando as notas acabam, direciona para a nota de 10
		
		addi $t1, $t1, 1 
		subi $t0, $t0, 20
		
		ble $t1, 2, while
	
	verificaQuant10: #abate 10 na compra e conta a quantidade de notas utilizadas
		beq $t2, 3, verificaQuant5 #quando as notas acabam, direciona para a nota de 5
		
		addi $t2, $t2, 1
		subi $t0, $t0, 10
		
		ble $t2, 3, while
		
	verificaQuant5: #abate 5 na compra e conta a quantidade de notas utilizadas
		beq $t3, 2, verificaQuant2 #quando as notas acabam, direciona para a nota de 2
		
		addi $t3, $t3, 1
		subi $t0, $t0, 5
		
		ble $t3, 2, while
	
	verificaQuant2: #abate 2 na compra e conta a quantidade de notas utilizadas
		beq $t4, 5, verificaQuant1 #quando as notas acabam, direciona para a moeda de 1
		
		addi $t4, $t4, 1
		subi $t0, $t0, 2
		
		ble $t4, 5, while
	
	verificaQuant1: #abate 1 na compra e conta a quantidade de moedas utilizadas
		beq $t5, 10, while #quando as moedas acabam, retorna para o while
		
		addi $t5, $t5, 1
		subi $t0, $t0, 1
		
		ble $t5, 10, while
	
	printResultadoFinal: #imprimindo o valor da compra e quantas notas/moedas foram gastas
		li $v0, 4 #imprimindo a mensagem
		la $a0, mensagem
		syscall
		
		li $v0, 1 #imprimindo o valor da compra
		move $a0, $t6
		syscall
		
		li $v0, 4 #fazendo a quebra de linha
		la $a0, quebraLinha
		syscall
		
		li $v0, 1 #printando notas de 20
		move $a0, $t1
		syscall
		
		li $v0, 4 #realizando o espaçamento entre as notas
		la $a0, espaco
		syscall
		
		li $v0, 1 #printando notas de 10
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0, espaco
		syscall
		
		li $v0, 1 #printando notas de 5
		move $a0, $t3
		syscall
		
		li $v0, 4
		la $a0, espaco
		syscall
		
		li $v0, 1 #printanndo notas de 2
		move $a0, $t4
		syscall
		
		li $v0, 4
		la $a0, espaco
		syscall
		
		li $v0, 1 #printando moedas de 1
		move $a0, $t5
		syscall
		
		j saida
		
	saida: #Saindo...
