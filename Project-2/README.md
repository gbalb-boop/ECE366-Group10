# ECE 366 – Project 2
# Progress Report 1: Fibonacci Program

# 1. Team Members
- **Member 1:** [Lina] — [NetID]
- **Member 2:** [Gabriel] — [NetID]
- **Member 3:** [Adam] — [amroz6]
- **Member 4:** [Julia] — [jpech4]

# 2. Individual Contributions
- **Member 1:** - **Part A**: Lina worked on Part A by writing the MIPS assembly code to calculate the nth Fibonacci number. She translated the given pseudocode into assembly using registers and a loop. For testing, she provided test cases using different input values (0, 1, 2, 5, 10, and 20) to check the program's accuracy. Her testing procedure involved running the code in the MARS simulator and checking the result stored in the Data Segment against the expected Fibonacci number.
- **Member 2:** - **Part B**: [Describe what you completed, if anything]
- **Member 3:** - **Part C**: Created file to start Part C
- **Member 4:** - **Report Coordinator**: I organized and prepared Progress Report 1 by creating a shared document for my teammates to record their work and contributions. I collected the necessary information for the README, including team member details, individual contributions, GitHub repository link, and instructions for running the Fibonacci MIPS program. I also helped coordinate the required files and made sure the submission was organized according to the project guidelines.

# 3. GitHub Repository
https://github.com/gbalb-boop/ECE366-Group10 

# 4. How to Run the Fibonacci Program

1. Download and open the MARS MIPS Simulator.

2. In MARS, select File > Open.

3. Navigate to the Project-2 folder and open
   `Part-A fibonacci.asm`.

4. To change the input, locate this line in the .data section:

   n: .word 10

   Replace 10 with the desired nonnegative integer.

5. Select Run > Assemble (F3) to assemble the program.

6. Select Run > Go (F5) to execute the program.

7. After execution, view the Data Segment in MARS.

8. Find the memory location labeled `result`. This
   location contains the calculated Fibonacci number.

### Example

Input: n = 10

Expected result: Fibonacci(10) = 55

The program stores the value 55 in the result memory
location rather than printing it to the console.

Note: Reassemble the program after changing the input.
