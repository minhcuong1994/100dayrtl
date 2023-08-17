module sync_2ff #(parameter ps=4) (
  input nrst, clk,
  input reg [ps:0]ptr,
  output reg [ps:0]q2_ptr);
    
  reg [ps:0]q1_ptr;
  always_ff @(posedge clk, negedge nrst) begin
    if(~nrst) {q2_ptr, q1_ptr} <= 0;
    else {q2_ptr, q1_ptr} = {q1_ptr, ptr};
  end

endmodule