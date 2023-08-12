// Code your design here
module bcd_7seg(
  input [3:0]number,
  output a,b,c,d,e,f,g);
  
  reg [7:0]total_seg;
  
  assign {a,b,c,d,e,f,g} = total_seg;
  
  always @(*) begin
    case (number)
      4'd0: total_seg <= 7'b0111111;
      4'd1: total_seg <= 7'b0000110;
      4'd2: total_seg <= 7'b1011011;
      default: total_seg <= 0;
    endcase
  end
  
endmodule