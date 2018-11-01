################################################################
# Seda Gulkesen 29.09.2017
# Aim:This program creates an array of maximum
# size of 20 elements. First,the program asks the size of 
# array then, expects to enter the elements of array.
# The contents of the array is displayed. And, the average
# of the array contents is calculated. Calculated average 
# is substracted from each element of array. These difference
# is also displayed in order.
###############################################################
.data
array: .space 80  #Allocate enough space for 20 integers
gettingSize: .asciiz "Enter the size of array:  "
blank: .asciiz "  "
gettingValues: .asciiz "Enter the integers will be stored: "
averText :.asciiz "Average of the given array:  " 
diffArray: .asciiz "Displaying the difference from the average: "
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
	la $t5, array
	#line 
	li $v0, 4
	la $a0, blank
	syscall
	#assign t6 as an first index 
	addi $t6,$0,0
	#assign t7 for holding sum 
	addi $t7,$0,0
	
while:	li $v0, 4
	la $a0, gettingValues
	syscall
	#get the current element: 
	li $v0, 5
	syscall
	add $t7,$t7,$v0
	sw $v0, array($t6)	
	addi $t6, $t6, 4
	addi $t0, $t0, -1 
	bnez $t0, while
	addi $t0,$t2,0

 average:
	addi $t8,$0,0 #sets avearage 0 
	div $t8,$t7,$t2

display:lw $a0, ($t5)
	#print current number
	li $v0, 1
	syscall
	#line
	li $v0, 4
	la $a0, blank 
	syscall	
	
	addi $t5, $t5, 4
	addi $t0, $t0, -1
	bne $t0,$0,display
	
	#prints a new line
 	li $v0, 4
 	la $a0, blank 
 	syscall
while2:
	#rearrange the memory address as first and reset index to 0
	add $t0, $t0, 1
	addi $t5, $t5, -4
	bne $t0,$t2,while2  #if t0 not equal t2 keep incrementing
	
	li $v0, 4
 	la $a0, averText 
 	syscall
 	
 	move $a0,$t8
 	li $v0,1
 	syscall
 	
 	#prints a new line
 	li $v0, 4
 	la $a0, blank 
 	syscall
 
 	li $v0, 4
 	la $a0, diffArray 
 	syscall
 	
 displayDiff:
 	lw $a0,($t5)
 	subu $a0,$a0,$t8
 	li $v0,1
 	syscall
 	#line 
	li $v0, 4
	la $a0, blank
	syscall 
	
 	addi $t5,$t5,4 
 	add $t0,$t0,-1
 	bne $t0,0,displayDiff

 		 	
done:	li $v0, 10	#end of the program
	syscall 
