# Project 2 Final Code by Carlos Perez & Cole Garrett Shoemaker
# Date Created: April 8th, 2025
# Last Edit: April 8th, 2025
# Assemble and run program: Enter number (n) into I/O space and program will return
# fibonacci(n), followed by 'True' if odd, and 'False' if even
# Note that the registers in the MIPS architecture processor (32 bits) will overflow at n = 47
# and will take much longer to compute the isOdd(n) at higher values of n 
# our computers took 30+ minutes to compute isOdd[fibonacci(n)]

# To run the code, paste into MARS MIPS processor, save and assemble code. Click run, and then enter an integer into the I/O space
# You should see the result of fibonacci(n), followed by True or False depending on if the result of fibonacci(n) is odd or not odd, respectively

	.data
# storing strings as global data to be used by modules later (for printing results)
isOdd_str: .asciiz "\nTrue\n"   
notOdd_str: .asciiz "\nFalse\n"
	.text
	.globl main
	
	
main:
    # set up registers to use in fibonacci(n)
    li $s0, 0			# variable a
    li $s1, 1			# variable b
    li $s2, 0			# temp variable
    li $t1, 0			# variable n
 
    li $v0, 5
    syscall			# read integer from I/O space using syscall code 5 in $v0		
    move $t1, $v0		# contents of v0 (syscall integer input) move to t1 (storing input 'n' in register $t1)
    jal fibonacci_helper	# jump to fibonacci_helper. jal instruction links program back to this line using program counter address
    				# this is done by storing the address for this instruction from the program counter in $ra
    				# and then loading it back to the PC using the 'jr' instruction at the end of the module
	
    # setup register for Odd calculation
    li $t3, 2 		# $t6 = 2 (the number we're going to subtract from input n)
    jal odd_loop	# jump to odd loop and link pc address for this line to $ra
	
    li $v0, 4           		# syscall code 4 for printing a string in print_true or print_false modules
    beq $a0, 1, print_true 		# given 'n' is odd
    beq $a0, 0, print_false 	        # given 'n' is not odd
    
    #end program
    li $v0, 10	# syscall code 10 for exit
    syscall	# exit

# main module for fibonacci(n)
fibonacci_helper:
    ble $t1, 1, n_base_case	  # branch if n <= 1
    li $t2, 1		          # creates counter variable and initializes
    j fibonacci_loop	

# base case if n <= 1    
n_base_case:
    move $a0, $t1		# set contents of t1 to a0 for printing
    li $v0, 1			# syscall code 1 to print integer from $a0
    syscall			# print
    jr $ra			# jr instruction loads pc address of 'jal fibonacci_helper' instruction from $ra into pc
                    	        # effectively functioning as a 'return' command to jump back to where it left off in main

# loops until i = n
fibonacci_loop:
    beq $t1, $t2, print_fibonacci	  # condition to check counter variable 
    move $s2, $s1			  # temp variable sets contents of b onto temp
    add $s1, $s1, $s0		          # addition of a and b registers and storing in b
    move $s0, $s2			  # set content of temp onto a
    addi $t2, $t2, 1			  # counter incremented
    j fibonacci_loop		          # jump back to loop start

print_fibonacci:
    move $a0, $s1	# set contents of t1 to a0 for printing integer
    li $v0, 1		# code to print integer
    syscall		# print
    jr $ra		# return to PC address of initial break (memory address of the 'jal fibonacci_helper' instruction loads from $ra into pc)

odd_loop:
    bge $s1, $t3, subtract  # if m>=2 go to subtract
    move $a0, $s1 	    # if m<2 the remainder is just the value of m (0 or 1), and hence our result
    jr $ra		    # jump back to main using PC

subtract:
    sub $s1, $s1, $t3 	# m = m - 2
    j odd_loop		# jump back to odd_loop
	
print_true:
    la $a0, isOdd_str   # load address of "true" string from global data
    syscall		# code 4 for printing strings in $v0
    jr $ra              # return from function
    
print_false:
    la $a0, notOdd_str  # load address of "false" string from global data
    syscall		# code 4 for printing strings in $v0
    jr $ra              # return from function
