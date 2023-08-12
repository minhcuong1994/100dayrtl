
module asyn_up_counter #(parameter n_bits = 8)(
  input clk, areset,
  output reg [n_bits-1:0]out);
  
  int out_t = 0;
  assign out = out_t;
  
  always @(posedge clk, negedge areset) begin
    if (~areset) out_t <= 0;
    else out_t <= out_t + 1;
  end
  
endmodule
