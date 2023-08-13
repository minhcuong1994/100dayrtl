// Code your design here
// Code your design here
module up_down_counter #(parameter n=4) (
  input clk, up_ndown_mode, rst,
  output reg [n-1:0]counter);
  
  initial begin
    counter = 0;
  end
  
  always @(posedge clk, negedge rst) begin
    if(~rst) counter <= 0;
    else if(up_ndown_mode) counter <= counter+1;
    else counter <= counter - 1;
  end
  
endmodule