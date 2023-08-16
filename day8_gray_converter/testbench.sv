// Code your testbench here
// or browse Examples

module test_gray_conv();
  reg [3:0] bin;
  reg [3:0] gray;
  
  gray_converter g_conv(bin, gray);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    for (int i=0; i<15; i++) begin
      bin = i;
      #5;
      $display("bin=%b, gray=%b",bin,gray);
    end
    
    $finish();
  end
  
  
endmodule