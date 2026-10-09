// Problem 3
// Julia Pechi
// 16-bit parallel prefix adder

// combines 2 propagate/gen groups so the PPA can find carries faster
module black_cell(P1, G1, P2, G2, Pout, Gout);
    input P1, G1;
    input P2, G2;

    output Pout, Gout;

    // temop wire for G calculation
    wire temp;

    // combine propagate values
    and (Pout, P1, P2);

    // combine generate values
    and (temp, P1, G2);
    or (Gout, G1, temp);
endmodule

// main module
module PPA(A, B, Cin, S, Cout);

    // a and b are the two 16-bit numbers being added
    input [15:0] A, B;

    // cin is the 1 bit carry
    input Cin;

    // S is the 16 bit sum output
    output [15:0] S;

    // cout is the final carry out bit
    output Cout;

    // PPA logic

    // wires to store P and G
    wire [15:0] P;
    wire [15:0] G;  

    // counter for gen loop
    genvar i;

    // go thru all 16 bits and find P and G
    generate
        for (i=0; i < 16; i=i+1) begin : PG
            // propagate = 1 if either A or B = 1
            or (P[i], A[i], B[i]);

            // generate = 1 if both A and B = 1
            and (G[i], A[i], B[i]);
        end
    endgenerate

    // Cin = -1, treated as the -1 pos in prefix tree
    wire Pm1;
    wire Gm1;

    assign Pm1 = 1'b0;
    assign Gm1 = Cin;

    // prefix tree

    // combine nearby bits into groups of 2
    wire P14_13, G14_13;
    wire P12_11, G12_11;
    wire P10_9, G10_9;
    wire P8_7, G8_7;
    wire P6_5, G6_5;
    wire P4_3, G4_3;
    wire P2_1, G2_1;
    wire P0_m1, G0_m1;

    black_cell B1 (P[14], G[14], P[13], G[13], P14_13, G14_13);
    black_cell B2 (P[12], G[12], P[11], G[11], P12_11, G12_11);
    black_cell B3 (P[10], G[10], P[9], G[9], P10_9, G10_9);
    black_cell B4 (P[8], G[8], P[7], G[7], P8_7, G8_7);
    black_cell B5 (P[6], G[6], P[5], G[5], P6_5, G6_5);
    black_cell B6 (P[4], G[4], P[3], G[3], P4_3, G4_3);
    black_cell B7 (P[2], G[2], P[1], G[1], P2_1, G2_1);

    // bit 0 gets combined with carry in pos -1
    black_cell B8 (P[0], G[0], Pm1, Gm1, P0_m1, G0_m1);

    // combine groups again to make bigger sections of the adder

    wire P14_11, G14_11;
    wire P13_11, G13_11;

    wire P10_7, G10_7;
    wire P9_7, G9_7;

    wire P6_3, G6_3;
    wire P5_3, G5_3;

    wire P2_m1, G2_m1;
    wire P1_m1, G1_m1;

    black_cell B9 (
        P14_13, G14_13, P12_11, G12_11, P14_11, G14_11
    );

     black_cell B10 (
        P[13], G[13], P12_11, G12_11, P13_11, G13_11
     );

    black_cell B11 (
        P10_9, G10_9, P8_7, G8_7, P10_7, G10_7
    );

     black_cell B12 (
        P[9], G[9], P8_7, G8_7, P9_7, G9_7
    );

    black_cell B13 (
        P6_5, G6_5, P4_3, G4_3, P6_3, G6_3
    );

    black_cell B14 (
        P[5], G[5], P4_3, G4_3, P5_3, G5_3
    );


    black_cell B15 (
        P2_1, G2_1, P0_m1, G0_m1, P2_m1, G2_m1
    );

    black_cell B16 (
        P[1], G[1], P0_m1, G0_m1, P1_m1, G1_m1
    );

    // keep combining groups for more carry info

    wire P14_7, G14_7;
    wire P13_7, G13_7;
    wire P12_7, G12_7;
    wire P11_7, G11_7;
    wire P6_m1, G6_m1;
    wire P5_m1, G5_m1;
    wire P4_m1, G4_m1;
    wire P3_m1, G3_m1;

    black_cell B17 (
        P14_11, G14_11, P10_7, G10_7, P14_7, G14_7
    );

    black_cell B18 (
        P13_11, G13_11, P10_7, G10_7, P13_7, G13_7
    );

    black_cell B19 (
        P12_11, G12_11, P10_7, G10_7, P12_7, G12_7
    );

    black_cell B20 (
        P[11], G[11], P10_7, G10_7, P11_7, G11_7
    );

    black_cell B21 (
        P6_3, G6_3, P2_m1, G2_m1, P6_m1, G6_m1
    );

    black_cell B22 (
        P5_3, G5_3, P2_m1, G2_m1, P5_m1, G5_m1
    );

    black_cell B23 (
        P4_3, G4_3, P2_m1, G2_m1, P4_m1, G4_m1
    );

    black_cell B24 (
        P[3], G[3], P2_m1, G2_m1, P3_m1, G3_m1
    );

    // groups now reach back to Cin

    wire P14_m1, G14_m1;
    wire P13_m1, G13_m1;
    wire P12_m1, G12_m1;
    wire P11_m1, G11_m1;
    wire P10_m1, G10_m1;
    wire P9_m1,  G9_m1;
    wire P8_m1,  G8_m1;
    wire P7_m1,  G7_m1;

    black_cell B25 (
        P14_7, G14_7, P6_m1, G6_m1, P14_m1, G14_m1
    );

    black_cell B26 (
        P13_7, G13_7, P6_m1, G6_m1, P13_m1, G13_m1
    );

    black_cell B27 (
        P12_7, G12_7, P6_m1, G6_m1, P12_m1, G12_m1
    );

    black_cell B28 (
        P11_7, G11_7, P6_m1, G6_m1, P11_m1, G11_m1
    );

    black_cell B29 (
        P10_7, G10_7, P6_m1, G6_m1, P10_m1, G10_m1
    );

    black_cell B30 (
        P9_7, G9_7, P6_m1, G6_m1, P9_m1, G9_m1
    );

    black_cell B31 (
        P8_7, G8_7, P6_m1, G6_m1, P8_m1, G8_m1
    );

    black_cell B32 (
        P[7], G[7], P6_m1, G6_m1, P7_m1, G7_m1
    );

    // Carry values

    // stores the carry going into each bit
    wire [15:0] C;

    assign C[0] = Cin; // carry going into bit 0 is Cin
    assign C[1] = G0_m1;
    assign C[2] = G1_m1;
    assign C[3] = G2_m1;
    assign C[4] = G3_m1;
    assign C[5] = G4_m1;
    assign C[6] = G5_m1;
    assign C[7] = G6_m1;
    assign C[8] = G7_m1;
    assign C[9] = G8_m1;
    assign C[10] = G9_m1;
    assign C[11] = G10_m1;
    assign C[12] = G11_m1;
    assign C[13] = G12_m1;
    assign C[14] = G13_m1;
    assign C[15] = G14_m1;

    // calculate sum

    // stores A XOR B 
    wire [15:0] ABxor;

    genvar j; 
    // find sum for all 16 bits
    generate
        for (j=0; j<16; j=j+1) begin : sum
            // first XOR a and B
            xor (ABxor[j], A[j], B[j]);

            // xor that result with the carry
            xor (S[j], ABxor[j], C[j]);
        end
    endgenerate

    // final carry out

    wire P15_m1;
    wire G15_m1;

    // combine bit 15 w/ the rest of the adder
    black_cell B33 (
        P[15], G[15], P14_m1, G14_m1, P15_m1, G15_m1
    );

    // G15_m1 = final carry out
    assign Cout = G15_m1;

endmodule