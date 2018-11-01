#############################################################
# Seda Gulkesen	01.10.2017
# Aim: This program is created by using all MIPS operations 
# that have been covered in 2 weeks of class. This program meets
# the following conditions.
# it must never create a result of 0 at any step
# it must load a 32-bit constant “immediate” into register at some point, and use the value in the calculation
# it must use a 32-bit value from memory as part of the calculation (Pick a proper memory location.)
# it must prompt the user for an input with a message, and use that value as part of the calculation
#at the end, it must output “The final result is:” followed by the value of the result
#############################################################

.data
arrayOfInt:	.space 100
welcomeMessage: .asciiz "Welcome to the program\n"
getNumber: 	.asciiz "Please enter the number that you want to do calculations: "
newline:	.asciiz " "
gettingSize:	.asciiz "Enter the size of the array: "
menu:		.asciiz "1.Display the elements of array\n2.Display the sum of the elements in array.\n3.Display the elements with 1/2\n4.Exit"
choice1:	.asciiz "The elements in the array: "
byebye:	.asciiz "See you ! The program is closed."
final:		.asciiz "The final result is: "
.text
	# gettingSize from the user message
	li $v0, 4
	la $a0, gettingSize
	syscall
	#get the array size 
	li $v0, 5
	syscall

	move $t0, $v0
	addi $t2, $t0, 0
	la $t5, arrayOfInt
	addi $a2,$t5,0
	#line 
	li $v0, 4
	la $a0, newline
	syscall
	#assign t6 as an first index 
	addi $t6,$0,0
	#holds the sum
	addi $t8,$0,0

	
while:	li $v0, 4
	la $a0, getNumber
	syscall
	#get the current element: 
	li $v0, 5
	syscall
	add $t8,$t8,$v0	
	sw $v0, arrayOfInt($t6)
	addi $t6, $t6, 4
	addi $t0, $t0, -1 
	bnez $t0, while
	addi $t0,$t2,0
	
askChoice:
	#prints a new line
 	li $v0, 4
 	la $a0, newline 
 	syscall
	#display the menu 
	li $v0,4
	la $a0,menu
	syscall
	

	#read the integer for choice
	li $v0,5
	syscall
	
	#choice stores in a3
	move $a3,$v0
	
	li $v0,4
	la $a0,newline
	syscall
	
	
	li $v0,4
	la $a0,final
	syscall
	
	
	#the value of choices
	beq $a3,1,displayArray
	beq $a3,2,displayTheSum
	beq $a3,3,displayHalf
	beq $a3,4,exit

	
displayArray:
 
	lw $a0, ($t5)
	
	#print current number
	li $v0, 1
	syscall
	
	sw $a0,($t5)
	#line
	li $v0, 4
	la $a0, newline 
	syscall	
	
	addi $t5, $t5, 4
	addi $t0, $t0, -1
	bne $t0,$0,displayArray
	
 	addi $t0, $t2, 0
 	move $t5,$a2
	
 	j askChoice
 	
displayHalf:
	lw $a0,($t5)
	move $t9,$a0
	srl $t9,$t9,1 #half of the value
	move $a0,$t9
	#print current number
	li $v0, 1
	syscall
	#prints a new line
 	li $v0, 4
 	la $a0, newline 
 	syscall
	addi $t5, $t5, 4
	addi $t0, $t0, -1
	bne $t0,0,displayHalf 	
 	j askChoice

displayTheSum:
	move $a0,$t8
	li $v0,1
	syscall 
	
	#prints a new line
 	li $v0, 4
 	la $a0, newline 
 	syscall
 	j askChoice

exit:	
	li $v0,4
	la $a0,byebye
	syscall 
 		 	
	li $v0, 10	#end of the program
	syscall 










