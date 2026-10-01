module four_bit_RCA_RCS(A, B, Cin, S, Cout);

    input  [3:0] A, B;
    input        Cin;
    output [3:0] S;
    output       Cout;

    wire c1, c2, c3;   // intermediate carry wires

    // Instantiate four 1-bit full adders (structural)
    one_bit_full_adder FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(c1));
    one_bit_full_adder FA1(.A(A[1]), .B(B[1]), .Cin(c1),  .S(S[1]), .Cout(c2));
    one_bit_full_adder FA2(.A(A[2]), .B(B[2]), .Cin(c2),  .S(S[2]), .Cout(c3));
    one_bit_full_adder FA3(.A(A[3]), .B(B[3]), .Cin(c3),  .S(S[3]), .Cout(Cout));

endmodule
