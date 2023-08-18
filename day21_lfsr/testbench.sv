// Code your testbench here
// or browse Examples
module lfsr_tb();
  logic clk, ena, nrst;
  reg [3:0]q;
  
  lfsr #(4'h1) mod(.*);
  
  always #1 clk <=~clk;
    
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 1;
    ena = 0;
    nrst = 0;
    #2;
    nrst = 1;
    #4;
    ena = 1;
    #50;
    
    $finish();
    
  end

endmodule   