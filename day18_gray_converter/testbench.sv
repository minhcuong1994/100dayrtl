// Code your testbench here
// or browse Examples
module gray_cnv_tb();
  
  logic clk, ena, nrst;
  reg [4:0]gray_cnt;
  
  always @(*) begin
    #1;
    clk <= ~clk;
  end
  
  gray_counter g_cnt(clk, ena, nrst, gray_cnt);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    ena = 1; 
    nrst = 0;
    #4;
    nrst = 1;
    #10
    ena = 0;
    #10;
    ena = 1;
    #10;
    
    $finish();
  end
  
  
endmodule