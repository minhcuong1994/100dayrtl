//ctl   000 	+
//		001 	-
//		010 	*
//		011 	/
//		1xx 	rev

module alu(clk, rst_n, ctl, a, b, q, cout);
  
  input clk, rst_n, ctl, a, b;
  output q, cout;
  
  wire clk, rst_n, cout;
  wire [2:0] ctl;
  wire [7:0]a, b, q;
  
  reg [8:0]tmp, q_temp;
  
  always @ (ctl, a, b) begin
    case (ctl)
      3'b000: tmp = a + b;
      3'b001: tmp = a - b;
      3'b010: tmp = a * b;
      3'b011: tmp = a / b;
      default: tmp = a + b;
      
    endcase
  end
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) q_temp <= 9'd0; else
      q_temp <= tmp; 
  end
  
  assign {cout, q} = q_temp;
  
endmodule