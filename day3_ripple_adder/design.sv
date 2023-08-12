// Code your design here
`include "full_adder.sv"

module ripple_adder #(parameter N_BITS=4)(
  input [N_BITS-1:0]a,
  input [N_BITS-1:0]b,
  input cin,
  output cout,
  output [N_BITS-1:0]sum);
  
  
  
  reg [N_BITS-2:0]c;
  
  
  full_adder fa_0(a[0], b[0], cin, c[0], sum[0]);
  
  genvar i;
  generate
    for (i=1; i<N_BITS-1; i++) begin
      full_adder fa_i(a[i], b[i], c[i-1], c[i], sum[i]);
    end
    
  endgenerate
  
  full_adder fa_n(a[N_BITS-1], b[N_BITS-1], c[N_BITS-2], cout, sum[N_BITS-1]);
   
endmodule