// Code your design here
module simple_fa #(w) (
  input wire rstn, clk, 
  input wire cin,
  input reg [w-1:0]a,b,
  output reg cout,
  output reg [w-1:0]q
);
  
  logic [w:0]result;
  
  always_ff @(posedge clk /*, negedge rstn */) begin
    if(!rstn) result = 0;
    else begin
      result = a + b + cin;
    end
  end
  
  assign q = result[w-1:0];
  assign cout = result[w];
  
  
  
endmodule