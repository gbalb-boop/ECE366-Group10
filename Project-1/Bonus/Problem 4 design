`timescale 1ns/1ps
module KS_Adder(A, B, Cin, S, Cout);

    input  [15:0] A, B;
    input          Cin;
    output [15:0] S;
    output         Cout;

    // P[0] and G[0]: bit-level propagate and generate
    // P[1] through P[4]: four prefix stages
    wire [15:0] P [0:4];
    wire [15:0] G [0:4];
    wire [15:0] C;

    // Stage 0: bit-level propagate and generate
    assign P[0] = A ^ B;
    assign G[0] = A & B;

    // Four Kogge-Stone prefix stages:
    // distances 1, 2, 4, and 8
    genvar s, i;
    generate
        for (s = 0; s < 4; s = s + 1) begin : PREFIX_STAGE
            for (i = 0; i < 16; i = i + 1) begin : PREFIX_BIT

                if (i >= (1 << s)) begin : COMBINE
                    assign P[s+1][i] =
                        P[s][i] & P[s][i-(1 << s)];

                    assign G[s+1][i] =
                        G[s][i] |
                        (P[s][i] & G[s][i-(1 << s)]);
                end
                else begin : PASS_THROUGH
                    assign P[s+1][i] = P[s][i];
                    assign G[s+1][i] = G[s][i];
                end

            end
        end
    endgenerate

    // Carry into bit 0
    assign C[0] = Cin;

    // Carries into bits 1 through 15
    generate
        for (i = 1; i < 16; i = i + 1) begin : CARRY_OUTS
            assign C[i] =
                G[4][i-1] | (P[4][i-1] & Cin);
        end
    endgenerate

    // Sum and final carry-out
    assign S = P[0] ^ C;
    assign Cout = G[4][15] | (P[4][15] & Cin);

endmodule
