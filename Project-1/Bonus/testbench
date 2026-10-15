`timescale 1ns/1ps

module testbench;

    reg [15:0] A, B;
    reg Cin;

    wire [15:0] S;
    wire Cout;

    reg [16:0] expected;

    KS_Adder dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    task check;
        input [15:0] a, b;
        input cin;
        begin
            A = a;
            B = b;
            Cin = cin;

            expected = {1'b0, a} + {1'b0, b} + cin;

            #10;

            if ({Cout, S} !== expected)
                $display("FAIL: A=%h B=%h Cin=%b Expected=%h Got=%h",
                         A, B, Cin, expected, {Cout, S});
            else
                $display("PASS: A=%h B=%h Cin=%b Result=%h",
                         A, B, Cin, {Cout, S});
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench);

        // Unsigned addition
        check(16'h0005, 16'h0003, 1'b0);

        // Unsigned subtraction represented as two's-complement addition:
        // 10 + (-3) = 7
        check(16'h000A, 16'hFFFD, 1'b0);

        // Negative operand: (-5) + 3 = -2
        check(16'hFFFB, 16'h0003, 1'b0);

        // Two's-complement negative result: 3 + (-5) = -2
        check(16'h0003, 16'hFFFB, 1'b0);

        // Carry propagation across multiple bit groups
        check(16'h0FFF, 16'h0001, 1'b0);

        // Carry-out
        check(16'hFFFF, 16'h0001, 1'b0);

        // Test carry-in
        check(16'h0010, 16'h0020, 1'b1);

        $display("All test cases completed.");
        $finish;
    end

endmodule

