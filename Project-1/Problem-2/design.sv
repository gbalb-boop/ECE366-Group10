module CLA(A, B, Cin, S, Cout);
  input [31:0] A, B;
  input Cin;

  output [31:0] S;
  output Cout;
  

  // CLA logic will go here
  wire [8:0] C;
  wire [7:0] rca_Cout;
  assign C[0] = Cin;
  assign Cout = C[8];

  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin : blocks
      four_bit_RCA rca(
        .A(A[4*i +: 4]),
        .B(B[4*i +: 4]),
        
        .Cin(C[i]),
        .S(S[4*i +: 4]),
        .Cout(rca_Cout[i])
      );

      cla4_carry carry_logic(
        .A(A[4*i +: 4]),
        .B(B[4*i +: 4]),
        .Cin(C[i]),
        .Cout(C[i+1])
      );
    end
  endgenerate

endmodule

module cla4_carry(A, B, Cin, Cout);
  input [3:0] A, B;
  input Cin;
  output Cout;
  
  // Generate & Propagate Signals
  wire [3:0] G;
  wire [3:0] P;
  
  // place holder for block generate logic
  wire t0;
  wire t1;
  wire t2;
  wire t3;
  wire block_G_temp;
  wire block_G;
  
  //place holder for block propgate logic
  wire pp01;
  wire pp23;
  wire block_P;
  wire propagated_carry;
  
  // Gi = Ai & Bi
  and g0(G[0], A[0], B[0]);
  and g1(G[1], A[1], B[1]);
  and g2(G[2], A[2], B[2]);
  and g3(G[3], A[3], B[3]);
  // Pi = Ai | Bi
  or p0(P[0], A[0], B[0]);
  or p1(P[1], A[1], B[1]);
  or p2(P[2], A[2], B[2]);
  or p3(P[3], A[3], B[3]);
  
  // Block Generator G3:0 =
  // G3 + P3(G2 + P2(G1 + P1G0))
  and bg0(t0, P[1], G[0]);
  or  bg1(t1, G[1], t0);

  and bg2(t2, P[2], t1);
  or  bg3(block_G_temp, G[2], t2);

  
  and bg4(t3, P[3], block_G_temp);
  or  bg5(block_G, G[3], t3);
  
  
  // P3:0 = P3 P2 P1 P0
  and bp0(pp01, P[0], P[1]);
  and bp1(pp23, P[2], P[3]);
  and bp2(block_P, pp01, pp23);
  
  // Carry out
  and c0(propagated_carry, block_P, Cin);
  or  c1(Cout, block_G, propagated_carry);

endmodule

module four_bit_RCA(A, B, Cin, S, Cout);
  input [3:0] A, B;
  input Cin;
  
  output [3:0] S;
  output Cout;

  wire c1, c2, c3;

  one_bit_full_adder fa0(A[0], B[0], Cin, S[0], c1);
  one_bit_full_adder fa1(A[1], B[1], c1, S[1], c2);
  one_bit_full_adder fa2(A[2], B[2], c2, S[2], c3);
  one_bit_full_adder fa3(A[3], B[3], c3, S[3], Cout);

endmodule

module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;
  wire w1, w2, w3;

  xor g1(w1, A, B);
  xor g2(S, w1, Cin);
  
  and g3(w2, A, B);
  and g4(w3, Cin, w1);
  or g5(Cout, w2, w3);

endmodule

  
  
  
