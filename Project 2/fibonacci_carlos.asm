# Carlos Perez
# Project 2, Problem 1
# Fibonacci(n)

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
   beq $t1, $t2, n_base			# conditional to check counter variable
   move $s2, $s1				# temp variable sets contents of b onto temp
   add $s1, $s1, $s0			# addition of a and b registers and storing in b
   move $s0, $s2				# set content of temp onto a
   addi $t2, $t2, 1			# counter incremented
   j loop				# jump back to loop
 
 
 n_base:			# base case if n <= 1
  move $a0, $s1			# set contents of t1 to a0 for printing
  li $v0, 1			# code to print integer
  syscall
 
  li $v0, 10			# code to exit file 
  syscall
 
