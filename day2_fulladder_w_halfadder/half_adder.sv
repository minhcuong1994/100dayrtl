module half_adder (input a,b, output c, out);
  assign out = a ^ b;
  assign c = a & b;
endmodule