# ECE 366 Project 2 - Part A: Fibonacci(n)
# Reads n from memory, computes the nth Fibonacci number, stores the result.

        .data
n:      .word 10          # input n (nonnegative integer) - change to test
result: .word 0           # output: Fibonacci(n)

        .text
        .globl main
main:
        la   $t0, n
        lw   $a0, 0($t0)          # $a0 = n

        jal  Fibonacci            # result returned in $v0

        la   $t1, result
        sw   $v0, 0($t1)          # store result in a different location

        li   $v0, 10              # exit
        syscall

# ---------------------------------------------------------
# Fibonacci(n)
# Input:  $a0 = n
# Output: $v0 = F(n)
# Uses:   $t0 = a, $t1 = b, $t2 = temp, $t3 = loop counter
# ---------------------------------------------------------
Fibonacci:
        # if n <= 1: return n
        slti $t4, $a0, 2          # $t4 = 1 if n < 2 (i.e., n <= 1)
        beq  $t4, $zero, fib_init
        move $v0, $a0
        jr   $ra

fib_init:
        li   $t0, 0               # a = 0
        li   $t1, 1               # b = 1
        addi $t3, $a0, -1         # loop count = n - 1

fib_loop:
        beq  $t3, $zero, fib_done # for i in range(n-1)
        move $t2, $t1             # temp = b
        add  $t1, $t0, $t1        # b = a + b
        move $t0, $t2             # a = temp
        addi $t3, $t3, -1         # i--
        j    fib_loop

fib_done:
        move $v0, $t1             # return b
        jr   $ra
