// Code your design here
module gray_converter #(parameter n=4) (
  input [n-1:0]bin,
  output reg [n-1:0]gray);
    
  assign gray = {bin[n-1], bin[n-2:0] ^ bin[n-1:1]};

  
endmodule