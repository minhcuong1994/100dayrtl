// Code your testbench here
// or browse Examples
module sync_fifo_tb();
  
  logic clk, nrst, we, re, d_full, d_empty;
  reg [7:0]din, dout;
  
  always @(*) begin
    #1;
    clk <= ~clk;
  end
  
  sync_fifo s_fifo(clk,nrst,we,re,din,d_full,d_empty,dout);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    nrst = 0;
    #4;
    nrst = 1;
    
    re = 0;
    we = 1;
    for(int i=0; i<20; i++) begin
      din = i+1;
      #4;
      
      if(i<13) begin
        re = 1;
        #2;
      end
      else re = 0;
      
    end
    #4;
    
    nrst = 0;
    #4;
    
    $finish();
  end
  
endmodule