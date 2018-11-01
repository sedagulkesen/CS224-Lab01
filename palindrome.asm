################################################################
# Seda Gulkesen 29.09.2017
# Aim: This simple program takes string as an input to check 
# whether the given string is palindrome or not.
# To be more clear, a palindrome is a word or phrase that reads same 
# backwards as forward.
###############################################################
.data
wordSpace: .space 200 	#allocate some space for string
welcomeMes: .asciiz "Welcome to Palindrome Checker, \nPlease enter a string : "
IsPalMes: .asciiz "The string is pal.\n "
NotPalMes: .asciiz "The string is not palindrome \n "
exitMes: .asciiz "The program is closing.. \n"
newline : .asciiz " "
.text

main :
	#prints welcome message 
	li $v0,4
	la $a0,welcomeMes
	syscall 
	
	#takes string 
	la $a0,wordSpace
	li $a1,200 
	li $v0,8		#e.g. racecar
	syscall
	
	la $t0,wordSpace #t0 points to first char of string 
	la $t1,wordSpace #t1 points to first char of string (needed to points end of the string)
	

goForLast :
	lb $t3, ($t1)
	beq $t3,$0,goBackOne
	addi $t1,$t1,1 #still t3 doesnt point to the end 
	j goForLast 
	

goBackOne:
	#if the last character is null substract 2 bytes (char is 2 byte ) to go last char.
	subu $t1,$t1,2
	lb $a0, ($t1)
	
test :
	lb $t2,($t0) 
	lb $t3,($t1)
	bne $t2,$t3,notPalLabel
	la $t2,wordSpace
	beq $t2,$t1,isPalLabel
	addu $t0,$t0,1 #increment the index from first to end 
	addu $t1,$t1,-1 #decrement the index from last to first 
	j test 

isPalLabel: 
	#prints welcome message 
	li $v0,4
	la $a0,IsPalMes
	syscall 
	j exit
	
notPalLabel: 
	#prints welcome message 
	li $v0,4
	la $a0,NotPalMes
	syscall
	j exit 
 
exit:
	li $v0, 10	#end of the program
	syscall