# Odd(m) function
# Written by Cole Garrett Shoemaker
# 03/31/25
	.data
true_str: .asciiz "true\n"
false_str: .asciiz "false\n"
	.text
	.globl main
main:
	li $v0, 5 #syscall code to read integer
	syscall
	move $t4, $v0
	
	jal Odd
	
	beq $a0, 1, print_true
	beq $a0, 0, print_false
	
	#end program
	li $v0, 10 #syscall code for exit
	syscall
	

Odd:
	move $t5, $t4
	li $t6, 2 #$t6 = 2 (the number we're going to subtract
	
	
repeat_subtract:
	bge $t5, $t6, subtract #if m>=2 go to subtract
	move $a0, $t5 # if m<2 the remainder is just the value of m (0 or 1)
	jr $ra
	
subtract:
	sub $t5, $t5, $t6 # m = m - 2
	j repeat_subtract
	
print_true:
	li $v0, 4           # syscall code for printing string
    la $a0, true_str    # Load address of "true" string
    syscall
    jr $ra              # Return from function
    
print_false:
    li $v0, 4           # syscall code for printing string
    la $a0, false_str   # Load address of "false" string
    syscall
    jr $ra              # Return from function
