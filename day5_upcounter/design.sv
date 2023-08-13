module asyn_up_counter #(parameter n_bits = 8)(
  input clk, areset,
  output reg [n_bits-1:0]out);
  
  initial begin
    out = 0;
  end
  
  always @(posedge clk, negedge areset) begin
    if (~areset) out <= 0;
    else out <= out + 1;
  end
  
endmodule
