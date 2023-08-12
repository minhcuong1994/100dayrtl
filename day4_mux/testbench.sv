// Code your testbench here
// or browse Examples

module test_mux();
  
  reg [7:0]a,b,c,d,q;
  reg [1:0]sel;
  
  mux4to1 mux(a,b,c,d,sel,q);
  
  initial begin
    $dumpfile ("file.vcd");
    $dumpvars(1);
    
    a = 1;
    b = 2;
    c = 3;
    d = 4;
    
    sel = 0;
    
    for (int i = 0; i<4; i++) begin
      #10;
      $display("sel=%d, q=%d",sel, q);
      sel++;
    end
    
    $finish();
  end
  
  
  
endmodule