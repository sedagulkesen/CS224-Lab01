################################################################
# Seda Gulkesen 29.09.2017
# Aim:This program implements the following expression
# without using div operation.
# x=$a0, y=$a1, $t0=4 
# a=(x-y)%4
###############################################################
.data
message: .asciiz "Please enter the numbers: "
byeBye: .asciiz "Program is closing.."
newline: .asciiz "\n"
#a=(x-y)%4
.text 
	li $v0, 4
	la $a0, message 
	syscall
	
	#first number
	li $v0,5
	syscall 
	move $a0,$v0  #put the first value into $a0
	
	#second number
	li $v0,5
	syscall 
	move $a1,$v0 #put the second value into $a1
	
	li $t0,4 #$t0=4 (mod4)

initial:
	subu $t1,$a0,$a1
	ble $t1,0,exit

while : blt  $t1,$t0,exit
	sub $t1,$t1,$t0
	j while

exit:
	move $a0,$t1
	#print the result
	li $v0,1
	syscall
	#newLine
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, byeBye
	syscall
	
	li $v0, 10	#end of the program
	syscall 
