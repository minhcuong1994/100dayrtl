// Code your testbench here
// or browse Examples
module clk_divider_tb();
  reg clk, rst, q;
  
  always @(*) begin
    #1;
    clk <= ~clk;
  end
  
  clock_divider_n clk_div(clk,rst,  q);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    rst = 1;
    
    for (int i=0; i<9; i++) begin
      #10;
      rst <= 1;
      if(i==4) rst <= 0;
      $display("q=%d", q);
 
    end
    
    #100;
    
    $finish();
    
  end
  
endmodule  