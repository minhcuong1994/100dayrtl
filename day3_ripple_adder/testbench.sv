// Code your testbench here
// or browse Examples
module test_rip_fa ();
  
  logic [7:0]a;
  logic [7:0]b;
  logic [7:0]sum;
  logic cin;
  logic cout;
  
  ripple_adder ra_t(a,b,cin,cout,sum);
  
  initial begin
    
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    // generate 
    for(int i=0; i<8; i++) begin
      a=$urandom_range(4'd0, 4'd15);
      b=$urandom_range(4'd0, 4'd15);
      cin = $urandom_range(1'b0, 1'b1);
       
      #10;
      
      $display("i=%d, a=%d, b=%d, cin=%d, cout =%d, sum =%d", i, a,b,cin,cout,sum);
        
        
      end
      
    //endgenerate


    $finish();
    
  end
  
endmodule