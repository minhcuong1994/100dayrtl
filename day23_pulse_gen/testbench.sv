// Code your testbench here
// or browse Examples
module pulse_tb();
  logic clk, nrst, pulse_o;
  reg [3:0]ena_val;
  
  pulse_generator  mod(.*);
  
  always #1 clk <=~clk;
    
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 1;
    
    ena_val = 4'd3;
    
    nrst = 0;
    #2;
    nrst = 1;
    #30;
    
    ena_val = 4'd15;
    #50;
    
    $finish();
    
  end

endmodule   