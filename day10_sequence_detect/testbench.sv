// Code your testbench here
// or browse Examples
module seq_test();
  
  logic clk, reset, data, out;
  reg [15:0]test_byte;
  
  seq_detect sq(clk, reset, data, out);
  
  always @(*) begin
    #2;
    clk <= ~clk;
  end
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    reset = 0;
    
    //test_byte = 16'b0010111110110011;
    test_byte = 16'b0101110111011011;
    
    for (int i=0; i<16; i++) begin
      data <= test_byte[i];
      
      if(i==13) reset = 1;
      #4;
    end
    
    #5
    
    $finish();
  end
  
  
endmodule