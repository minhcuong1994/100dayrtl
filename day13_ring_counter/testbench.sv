// Code your testbench here
// or browse Examples
module ring_counter_tb();
  
  logic clk, ori;
  reg [3:0]cnt;
  
  always @(*) begin
    #5;
    clk <= ~clk;
  end
  
  ring_counter r_cnt(clk, ori, cnt);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    
    ori = 0;
    #10;
    ori = 1;
    
    #100
    ori = 0;
    #10;
    ori = 1;
    
    #100;
    
    $finish();
  end
  
endmodule