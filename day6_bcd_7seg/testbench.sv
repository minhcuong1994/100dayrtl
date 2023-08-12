// Code your testbench here
// or browse Examples
module bcd_tb;
  
  reg [3:0]number; 
  logic a,b,c,d,e,f,g;
  
  bcd_7seg bcd(number, a,b,c,d,e,f,g);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    for (int i=0; i<3; i++) begin
      number = i;
      #5;
      $display("number=%d,a=%d,b=%d,c=%d", number,a,b,c);
      
    end
    
    $finish();
  end
  
endmodule