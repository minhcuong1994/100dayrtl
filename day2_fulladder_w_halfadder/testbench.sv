// Code your testbench here
// or browse Examples


module test_fa();
  reg a,b,cin, cout ,sum ;
  
  full_adder fa(a,b,cin,cout,sum);
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    a=0; b= 0; cin = 0; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    a=0; b=1; cin = 0; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    a=1; b=0; cin = 0; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    a=1; b=1; cin = 0; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    

    
    a=0; b= 0; cin = 1; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    a=0; b=1; cin = 1; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    a=1; b=0; cin = 1; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    a=1; b=1; cin = 1; 
    #5
    $display("a=%d, b=%d, cin=%d, cout =%d, sum =%d", a,b,cin,cout,sum);
    
    #5
    
    $finish();
    
  end
  
endmodule
