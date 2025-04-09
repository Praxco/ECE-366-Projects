# Fibonacci Function
# input n in $t5
# output in $t4
# currently does not print and returns some weird program counter error.
# Not sure how to get around this, but the computation works. Load hex value into $t5 and the program will spit out the correct F(n) in $t4

Fibonacci:
    # Expect n in $a0
	beq  $t5, $zero, fib_base_case
	li   $v0, 1
	beq  $t5, $v0, fib_base_case  # If n == 1, return 1

    # Initialize registers
	li   $t0, 0      # a = 0
	li   $t1, 1      # b = 1
	li   $t2, 1      # i = 0

fib_loop:
	beq  $t2, $t5, fib_done  # If i == n, exit loop
	move $t3, $t1      # temp = b
	add $t1, $t0, $t1  # b = a + b
	move $t0, $t3      # a = temp
	addi $t2, $t2, 1         # i++
	j fib_loop

fib_done:
	move $t4, $t1  # Return Fibonacci number
	jr $ra

fib_base_case:
	move $t4, $t5
	jr $ra

