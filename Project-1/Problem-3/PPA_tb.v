timescale 1ns/1ps

module PPA_tb;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg Cin;

    // Outputs
    wire [15:0] S;
    wire Cout;

    // Connect testbench to the PPA
    PPA dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    initial begin

        // simple addition
        // 5 + 3 = 8
        A = 16'd5;
        B = 16'd3;
        Cin = 0;
        #10;

        $display("Test 1: 5 + 3");
        $display("A = %d, B = %d, Cin = %b, S = %d, Cout = %b",
                  A, B, Cin, S, Cout);

        // bigger numbers
        // 25 + 17 = 42
        A = 16'd25;
        B = 16'd17;
        Cin = 0;
        #10;

        $display("Test 2: 25 + 17");
        $display("A = %d, B = %d, Cin = %b, S = %d, Cout = %b",
                  A, B, Cin, S, Cout);

        // test Cin
        // 10 + 20 + 1 = 31
        A = 16'd10;
        B = 16'd20;
        Cin = 1;
        #10;

        $display("Test 3: 10 + 20 + Cin");
        $display("A = %d, B = %d, Cin = %b, S = %d, Cout = %b",
                  A, B, Cin, S, Cout);

        // carry through several bits
        // 255 + 1 = 256
        A = 16'd255;
        B = 16'd1;
        Cin = 0;
        #10;

        $display("Test 4: 255 + 1");
        $display("A = %d, B = %d, Cin = %b, S = %d, Cout = %b",
                  A, B, Cin, S, Cout);

        // final carry-out
        // FFFF + 1 = 10000
        A = 16'hFFFF;
        B = 16'h0001;
        Cin = 0;
        #10;

        $display("Test 5: FFFF + 1");
        $display("A = %h, B = %h, Cin = %b, S = %h, Cout = %b",
                  A, B, Cin, S, Cout);

        // signed number
        // -5 + 3 = -2
        A = 16'hFFFB;
        B = 16'd3;
        Cin = 0;
        #10;

        $display("Test 6: -5 + 3");
        $display("A = %h, B = %h, Cin = %b, S = %h, Cout = %b",
                  A, B, Cin, S, Cout);

        $finish;

    end

endmodule