# ECE 366 – Project 2
# Progress Report 2: IsOdd Program

## 1. Team Members
- **Member 1:** Lina — [glahi]
- **Member 2:** Gabriel — gbalb
- **Member 3:** Adam — amroz6
- **Member 4:** Julia — jpech4

## 2. Individual Contributions
- **Member 1 – Part A:** Lina completed the Fibonacci MIPS assembly program for Progress Report 1.
- **Member 2 – Part B:** Gabriel wrote the MIPS assembly code to determine whether a given number is odd or even. The program uses a loop to repeatedly subtract 2 until the remaining value is less than 2. It then checks the remainder and stores 1 if the number is odd or 0 if it is even. He tested the program in MARS using inputs of 7 and 8, and both produced the expected results.
- **Member 3 – Part C:** Adam created the initial file for Part C.
- **Member 4 – Report Coordinator:** Julia organized the documentation for Progress Report 1.

## 3. GitHub Repository
https://github.com/gbalb-boop/ECE366-Group10

## 4. How to Run the IsOdd Program

1. Download and open the MARS MIPS Simulator.

2. In MARS, select File > Open.

3. Navigate to the Project-2 folder and open `Part-B.asm`.

4. To change the input, locate this line in the .data section:

   `m: .word 7`

   Replace 7 with any nonnegative integer.

5. Select Run > Assemble (F3) to assemble the program.

6. Select Run > Go (F5) to execute the program.

7. After execution, view the Data Segment in MARS.

8. The memory location labeled `result` contains 1 if the input is odd and 0 if it is even.

### Example

Input: m = 7

Expected result: 1 (odd)

Input: m = 8

Expected result: 0 (even)

Both inputs were tested successfully in MARS.

The program stores the result in memory rather than printing it to the console.

Note: Reassemble the program after changing the input.
