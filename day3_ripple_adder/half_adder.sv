module half_adder(input a,b, output c, sum);
  
  assign sum = a^b;
  assign c = a & b;
  
endmodule