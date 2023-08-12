// Code your design here
module mux4to1 (
  input [7:0]a,b,c,d,
  input [1:0]sel,
  output reg [7:0]q);
  
  always @(*) begin
    case (sel) 
      2'b00: q <= a;
      2'b01: q <= b;
      2'b10: q <= c;
      2'b11: q <= d;
      
    endcase
  end
      
      endmodule