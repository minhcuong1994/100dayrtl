// Code your design here
module pulse_generator #(parameter W=4) (
  input clk, nrst,
  input [W-1:0]ena_val,
  output pulse_o);
  
  reg [W-1:0]count;
  logic full;
  
  always_ff @(posedge clk, negedge nrst) begin
    if (!nrst) begin
      count <= '0;
      full <= '0; 
    end
    else begin
      count <= count + 1;
      if (count >= (ena_val-1)) begin
        count <= '0;
        full = 1;
      end
      else full = 0;
    end
  end
  
  assign pulse_o = full;
  
endmodule