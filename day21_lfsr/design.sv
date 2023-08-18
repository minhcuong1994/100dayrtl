// Code your design here

module lfsr #(S = 4'hf) (
  input clk, ena, nrst,
  output [3:0]q);
  
  reg [3:0]qt;
  
  assign q = qt;
  
  always_ff @(posedge clk, negedge nrst) begin
    if(!nrst) qt <= S;
    else if (ena) begin
      qt[0] <= qt[2] ^ qt[3];
      qt[3:1] <= qt[2:0];
    end
  end
  
endmodule