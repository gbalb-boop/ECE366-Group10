# ECE 366 – Project 2
# FINAL PROGRESS REPORT

# 1. Team Members
- **Member 1:** [Lina] — [glahi]
- **Member 2:** [Gabriel] — [gbalb]
- **Member 3:** [Adam] — [amroz6]
- **Member 4:** [Julia] — [jpech4]

## 2. Individual Contributions
- **Member 1 – Part A:** Lina worked on Part A by writing the MIPS assembly code to calculate the nth Fibonacci number. She translated the given pseudocode into assembly using registers and a loop. For testing, she provided test cases using different input values (0, 1, 2, 5, 10, and 20) to check the program's accuracy. Her testing procedure involved running the code in the MARS simulator and checking the result stored in the Data Segment against the expected Fibonacci number.
- **Member 2 – Part B:** Gabriel wrote the MIPS assembly code to determine whether a given number is odd or even. The program uses a loop to repeatedly subtract 2 until the remaining value is less than 2. It then checks the remainder and stores 1 if the number is odd or 0 if it is even. He tested the program in MARS using inputs of 7 and 8, and both produced the expected results.
- **Member 3 – Part C:** Adam combined the Fibonacci and IsOdd functions into the final IsFibonacciOdd program. He implemented the main function to load the input from memory, check whether the nth Fibonacci number is odd or even, and store the result in memory.
- **Member 4 – Report Coordinator:** Julia was responsible for organizing and writing Progress Reports. She worked on the README files, explained how the MIPS code works, wrote the instructions for running the programs, documented the test cases, and helped prepare the files for submission

# 3. GitHub Repository
https://github.com/gbalb-boop/ECE366-Group10 

# 4. How to Run the Program

1. Open the MARS MIPS simulator
2. Click File > Open and select the Part C assembly file
3. Locate the `.data` section at the beginning of the code
4. Change `n: .word 10` to the desired nonnegative integer
5. Click Run > Assemble to assemble the program
6. Click Run > Go to execute the program
7. Open the Data Segment window and locate the memory location labeled `result`
8. The stored value indicates whether the nth Fibonacci number is odd or even:
   - 1 = Odd (True)
   - 0 = Even (False)

The program automatically loads n from memory, calculates the nth Fibonacci number, checks whether it is odd, and stores the final answer in `result`

# 5. Testing and Results

The program uses three functions:
- Fibonacci: Calculates the nth Fibonacci number
- IsOdd: Checks whether the Fibonacci number is odd using division by repeated subtraction
- IsFibonacciOdd: Combines both functions and returns the final result

# Test Cases

| Input (n) | Fibonacci(n) | Expected Output |
|-----------|--------------|-----------------|
| 0         | 0            | 0 (Even)        |
| 1         | 1            | 1 (Odd)         |
| 2         | 1            | 1 (Odd)         |
| 3         | 2            | 0 (Even)        |
| 4         | 3            | 1 (Odd)         |
| 5         | 5            | 1 (Odd)         |
| 6         | 8            | 0 (Even)        |
| 7         | 13           | 1 (Odd)         |
| 10        | 55           | 1 (Odd)         |

# Expected Behavior

The program reads n from memory and passes it to the Fibonacci function. The calculated Fibonacci number is then passed to IsOdd, which uses repeated subtraction to determine the remainder after division by 2

If the remainder is 1, the function returns 1 (Odd). Otherwise, it returns 0 (Even)

The final output is stored in the memory variable `result`

For the default input n = 10, Fibonacci(10) = 55. Since 55 is odd, the expected output stored in `result` is 1

