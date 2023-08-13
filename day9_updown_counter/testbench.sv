// Code your testbench here
// or browse Examples
module
  test_updown_counter();
  
  logic clk, up_down, rst;
  reg [3:0]counter;
  
  up_down_counter up_down_mod(clk, up_down, rst, counter);
  
  always @(*) begin
    #1;
    clk <= ~clk;
  end
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk=0;
    
    up_down = 1;
    #90
    up_down = 0;
    
    #80
    rst = 0;
    #20
    rst = 1;
    
    #10;
    
    $finish();
  end


endmodule