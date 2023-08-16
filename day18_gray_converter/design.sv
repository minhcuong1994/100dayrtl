// Code your design here
module gray_counter #(parameter n_bits=4) (
  input clk, ena, nrst,
  output reg[n_bits-1:0]gray_cnt);
  
  reg [n_bits-1:0]bin_cnt;
  
  always_ff @(posedge clk) begin
    if(~nrst) begin
      bin_cnt <= {n_bits{1'b0}};
      gray_cnt <= {n_bits{1'b0}}; 
    end
    else begin
      bin_cnt <= bin_cnt + ena;
      
      //gray converter
      gray_cnt <= {bin_cnt[n_bits-1], bin_cnt[n_bits-2:0] ^ bin_cnt[n_bits-1:1]};
      
    end
  end
  
endmodule