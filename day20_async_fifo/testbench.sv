// Code your testbench here
// or browse Examples
module fifo_tb #(parameter dw=8, ps=4) ();
  
  logic wclk, wrst_n, winc;
  reg [dw-1:0]wdata;
  logic rclk, rrst_n, rinc;
  logic wfull, rempty;
  reg [dw-1:0]rdata;
  
  async_fifo a_fifo(.*);
  
  always #3 wclk <= ~wclk;
  always #1 rclk <= ~rclk;
  
  
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    wclk = 0;
    rclk = 0;
    
    wrst_n = 0;
    rrst_n = 0;
    #4;
    
    wrst_n = 1;
    rrst_n = 1;
    #4;
    
    winc = 1;
    rinc = 0;
   
    
    for (int i=0; i<20; i++) begin
      wdata = i;
      #4;
      if (i==17) rinc = 1;
    end
    
    #30;
    
    
    
    $finish();
  end
  
endmodule