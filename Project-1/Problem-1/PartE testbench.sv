module tb_four_bit_RCA_RCS;
  reg  [3:0] A, B;
  reg        Cin;
  wire [3:0] S;
  wire       Cout;

  four_bit_RCA_RCS uut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

  task run(input [3:0] a, b, input cin, input [4:0] expected, input [127:0] name);
    begin
      A = a; B = b; Cin = cin; #10;
      $display("%0s | A=%b B=%b Cin=%b | S=%b Cout=%b | %s",
               name, A, B, Cin, S, Cout,
               ({Cout, S} === expected) ? "PASS" : "FAIL");
    end
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_four_bit_RCA_RCS);

    //   A       B     Cin  {Cout,S}   label
    run(4'b0011, 4'b0100, 0, 5'b0_0111, "U-add  3+4=7      ");
    run(4'b1001, 4'b0100, 1, 5'b1_0101, "U-sub  9-4=5      ");
    run(4'b0101, 4'b1110, 0, 5'b1_0011, "S-add  5+(-2)=3   ");
    run(4'b0011, 4'b1110, 1, 5'b0_0101, "S-sub  3-(-2)=5   ");
    run(4'b1101, 4'b0010, 1, 5'b1_1011, "S-sub  -3-2=-5    ");
    run(4'b1111, 4'b0001, 0, 5'b1_0000, "Carry  15+1       ");
    run(4'b0111, 4'b0001, 0, 5'b0_1000, "S-ovf  7+1 -> -8  ");
    run(4'b0100, 4'b0100, 1, 5'b1_0000, "U-sub  4-4=0      ");

    $finish;
  end
endmodule
