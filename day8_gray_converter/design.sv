// Code your design here
module gray_converter #(parameter n=4) (
  input [n-1:0]bin,
  output reg [n-1:0]gray);
  
  
  always @(*) begin
    for (int i=0; i<n; i++) begin
    if (i==n-1) gray[i] = bin[i];
      else gray[i] = bin[i] ^ bin[i+1];
  end
  end
  
endmodule