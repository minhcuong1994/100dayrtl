module test_counter();
  
  reg clk, areset;
  reg [7:0]out;
    
  asyn_up_counter counter(clk, areset, out);
  
  always @(*) begin
    #5;
    clk <= ~clk;
  end
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    
    clk = 0;
    areset = 1;
    
    #30;
    $display("out=%d", out);
    
    #40
    areset = 0;
    
    #5
    areset = 1;
    
    #5;
    $display("out=%d", out);
    
    #30
    
    
    $finish();
  end
  
  
endmodule