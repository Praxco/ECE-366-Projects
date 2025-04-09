# Odd(m) function
# Written by Cole Garrett Shoemaker
# 03/31/25
	.data
odd_str: .asciiz "odd\n"
even_str: .asciiz "even\n"
	.text
	.globl main
main:
	li $s0, 0			# variable a
 	li $s1, 1			# variable b
	li $s2, 0			# temp variable
 	li $t0, 0			# variable n
 	li $t1, 2 			# t1 = 2 (the number we're going to subtract
 
	li $v0, 5 			#syscall code to read integer
	syscall
	move $t0, $v0			# moves content into t0
	
 	blt $t0, $t1, base_case
 	
	j fib_loop
	
 
fib_loop: 				# loops until i = n
 li $t2, 1				# creates counter variable and initializes
 loop:
  beq $t0, $t2, repeat_subtract		# conditional to check counter variable
  move $s2, $s1				# temp variable sets contents of b onto temp
  add $s1, $s1, $s0			# addition of a and b registers and storing in b
  move $s0, $s2				# set content of temp onto a
  addi $t2, $t2, 1			# counter incremented
  j loop				# jump back to loop
 
repeat_subtract:
	bge $s1, $t1, subtract		#if sum >= 2 go to subtract
	move $a0, $s1 			# if sum < 2 the remainder is just the value of sum (0 or 1)
	j print_conditions
	
subtract:
	sub $s1, $s1, $t1 		# sum = sum - 2
	j repeat_subtract
	
base_case:
	move $a0, $t0
	j print_conditions
	
print_conditions:
	beqz $a0, print_even
	beq $a0, 1, print_odd
	
print_odd:
    li $v0, 4           # syscall code for printing string
    la $a0, odd_str    # Load address of "true" string
    syscall
    j Exit              # Return from function
    
print_even:
    li $v0, 4           # syscall code for printing string
    la $a0, even_str   # Load address of "false" string
    syscall
    j Exit             # Return from function
    
Exit:			# end program
    li $v0, 10 		#syscall code for exit
    syscall
    
