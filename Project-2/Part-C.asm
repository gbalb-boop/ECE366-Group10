      .data
n:    .word 10
result:  .word 0

    .text
    .globl main
#--
# Main
# Loads n from memory and calls IsFibonacciOdd, and stores in result
#--
main:
    la $t0, n
    lw $a0, 0($t0)
    jal IsFibonacciOdd
    la $t1, result
    sw $v0, 0($t1)
    li $v0, 10
    syscall
#--
#Input is n and output is one if odd, else 0.
#--
IsFibonacciOdd:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal Fibonacci
    move $a0, $v0
    jal IsOdd
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
#--
# Input=$a0, Output=F(n)
# If n<= 0 returns n
#--
Fibonacci:
    slti $t4, $a0, 2
    beq $t4, $zero, fib_init
    move $v0, $a0
    jr $ra
fib_init:
    li $t0, 0
    li $t1, 1
    addi $t3, $a0, -1
fib_loop:
    beq  $t3, $zero, fib_done
    move $t2, $t1
    add  $t1, $t0, $t1
    move $t0, $t2
    addi $t3, $t3, -1
    j    fib_loop
fib_done:
    move $v0, $t1
    jr $ra
#--
#Returns 1 if true, 0 otherwise
#--
IsOdd:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    li $a1, 2
    jal Division
    beq $v0, $zero, isodd_false
    li $v0, 1
    j isodd_return
isodd_false:
  li $v0, 0
isodd_return:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
#--
#Division by repeated subtraction
#--
Division:
    li $v1, 0
div_loop:
    slt $t5, $a0, $a1
    bne $t5, $zero, div_done
    sub $a0, $a0, $a1
    addi $v1, $v1, 1
    j div_loop
div_done:
    move $v0, $a0
    jr $ra
