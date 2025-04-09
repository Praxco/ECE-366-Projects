# Project 2 Final Code by Carlos Perez & Cole Garrett Shoemaker
# Assemble and run program: Enter number (n) into I/O space and program will return
# fibonacci(n), followed by 'True' if odd, and 'False' if even
# Note that the registers in the MIPS architecture processor (32 bits) will overflow at n = 47
# and will take much longer to compute the isOdd(n) at higher values of n (our computers took 30+ minutes to compute isOdd[fibonacci(n)] )

	.data
true_str: .asciiz "\nTrue\n"
false_str: .asciiz "\nFalse\n"
	.text
	.globl Odd_Main

fibonacci:			# main module for fibonacci(n)
    li $s0, 0			# variable a
    li $s1, 1			# variable b
    li $s2, 0			# temp variable
    li $t1, 0			# variable n
 
    li $v0, 5			# loading code 5 to read integer
    syscall			
    move $t1, $v0			# contents of v0 are in t1 (input storing onto n register)
 
    ble  $t1, 1, n_base		# branch if n <= 1
 
    j fib_loop
 
 
fib_loop: 				# loops until i = n
    li $t2, 1				# creates counter variable and initializes
loop:
    beq $t1, $t2, n_sum			# conditional to check counter variable
    move $s2, $s1			# temp variable sets contents of b onto temp
    add $s1, $s1, $s0			# addition of a and b registers and storing in b
    move $s0, $s2			# set content of temp onto a
    addi $t2, $t2, 1			# counter incremented
    j loop				# jump back to loop
 
 
n_base:			# base case if n <= 1
    move $a0, $t1			# set contents of t1 to a0 for printing
    li $v0, 1			# code to print integer
    syscall
    j Odd_Main
  
n_sum:
    move $a0, $s1			# set contents of t1 to a0 for printing
    li $v0, 1			# code to print integer
    syscall
    j Odd_Main

Odd_Main:
	move $t4, $s1
	
	j Odd
	
  
Odd:
    move $t5, $t4
    li $t6, 2 #$t6 = 2 (the number we're going to subtract
 
	
repeat_subtract:
    bge $t5, $t6, subtract #if m>=2 go to subtract
    move $a0, $t5 # if m<2 the remainder is just the value of m (0 or 1)
    j Print_conditions
	
subtract:
    sub $t5, $t5, $t6 # m = m - 2
    j repeat_subtract
	
print_true:
    li $v0, 4           # syscall code for printing string
    la $a0, true_str    # Load address of "true" string
    syscall
    j Exit              # Return from function
    
print_false:
    li $v0, 4           # syscall code for printing string
    la $a0, false_str   # Load address of "false" string
    syscall
    j Exit             # Return from function
    
Print_conditions:
    beq $a0, 1, print_true
    beq $a0, 0, print_false
Exit:  #end program
    li $v0, 10 #syscall code for exit
    syscall
