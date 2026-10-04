module tb_CLA;
  reg [31:0] A;
  
  reg [31:0] B;
  reg Cin;
  
  wire [31:0] S;
  wire Cout;
  
  CLA uut(
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
  );
  
  task run_test;
    input [31:0] a;
    input [31:0] b;
    
    input cin;
    input [32:0] expected;
    input [127:0] name;
    
    begin
      A = a;
      B = b;
      Cin = cin;
      #10;
      
      $display("%0s | A=%h B=%h Cin=%b | S=%h Cout=%b | %s",
        name,A,B,Cin,S,Cout,
        ({Cout,S} === expected) ? "PASS" : "FAIL");
    end
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_CLA);
    
    //basic addition
    run_test(32'h00000003,32'h00000004,0,33'h000000007,"3 + 4");
    
    // carry into next 4 bit block
    run_test(32'h0000000F,32'h00000001,0,33'h000000010,"F + 1");
    
    //carry throuh multiple 4 bit blocks
    
    run_test(32'h0000FFFF,32'h00000001,0,33'h000010000,"FFFF + 1");
    
    // bigger addition
    run_test(32'h12345678,32'h11111111,0,33'h023456789,"larger addition");
    // the final carry out
    run_test(32'hFFFFFFFF,32'h00000001,0,33'h100000000,"carry out");
    
    // test Cin
    run_test(32'h00000005,32'h00000003,1,33'h000000009,"Cin test");
    
    $finish;
  end
endmodule
  
  
  
  
