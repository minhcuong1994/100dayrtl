// Code your design here
`include "half_adder.sv"

module full_adder(input a,b,cin, output cout, sum);
  
  reg c1, c2, sum1;
  half_adder ha1(a,b, c1, sum1);
  half_adder ha2(sum1, cin, c2, sum);
  assign cout = c1 | c2;
                 
endmodule
