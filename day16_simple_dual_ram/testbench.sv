// Code your testbench here
// or browse Examples
module ram_tb();
  logic clk, nrst, ce, we, re; 
  reg [7:0]din, adr_a, adr_b;
  reg [7:0]dout;

  simple_dual_port_ram sdram(clk, ce, nrst, we, re, adr_a, adr_b, din, dout);
 
  always @(*) begin
    #1;
    clk <= ~clk;
  end
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0; 
    nrst = 1;
    ce = 1;
    we = 0; 
    re = 0;
    adr_a = 0;
    adr_b = 1;
    
    //write
    we = 1;
    din = 2;
	adr_a = 1;
    #4;
    
    din = 3;
    adr_a = 2;
    #4;
    
    //w/r
    din = 4;
    adr_a = 3;
    adr_b = 1;
    re = 1;
    #4;
    
    din = 5;
    adr_a = 4;
    adr_b = 2;
    #4;
    
    din = 6;
    adr_a = 5;
    adr_b = 3;
    #4;
    
    //we =0, w/r
    we = 0;
    din = 7;
    adr_a = 6;
    #2;
    adr_b = 6;
    #4;
    
    //ce = 0;
    ce = 0;
    adr_b = 3;
    #4;
 
    nrst = 0;
    #4;
    

    $finish();
  end
  
endmodule
