// Problem 2(a)

module CLA(A, B, Cin, S, Cout);
  input [31:0] A, B;
  input Cin;
  
  output [31:0] S;
  output Cout;
  // Carry signals between 4-bit blocks
  wire c4;
  wire c8;
  wire c12;
  wire c16;
  wire c20;
  wire c24;
  wire c28;
  
  // Bits 3:0
  cla4_carry block0 (
    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(Cin),
    .Cout(c4)
  );
  
  // bits 7:4
  cla4_carry block1 (
    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(c4),
    .Cout(c8)
  );
  
  // Bits 11:8
  cla4_carry block2 (
    .A(A[11:8]),
    .B(B[11:8]),
    .Cin(c8),
    .Cout(c12)
  );

  // Bits 15:12
  cla4_carry block3 (
     .A(A[15:12]),
     .B(B[15:12]),
     .Cin(c12),
     .Cout(c16)
  );

  // Bits 19:16
  cla4_carry block4 (
     .A(A[19:16]),
     .B(B[19:16]),
     .Cin(c16),
     .Cout(c20)
  );

  // Bits 23:20
  cla4_carry block5 (
      .A(A[23:20]),
      .B(B[23:20]),
      .Cin(c20),
      .Cout(c24)
    );

  // Bits 27:24
  cla4_carry block6 (
      .A(A[27:24]),
      .B(B[27:24]),
      .Cin(c24),
      .Cout(c28)
    );

  // bits 31:28
  cla4_carry block7 (
      .A(A[31:28]),
      .B(B[31:28]),
      .Cin(c28),
      .Cout(Cout)
  );

    // Waiting for problem 1(c):
 

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
  wire block_G;
  wire block_G_temp;
  
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
  or p3(P[3], A[3], B[3])
  
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
  
  // carry out
  and c0(propagated_carry, block_P, Cin);
  or  c1(Cout, block_G, propagated_carry);

endmodule

  
  
  
  
