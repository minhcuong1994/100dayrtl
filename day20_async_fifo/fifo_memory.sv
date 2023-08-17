module fifo_memory #(parameter dw=8, ps=4) (
  input wclk, wren,  
  input [dw-1:0]wdata, 
  input [ps-1:0]waddr, raddr,
  output reg [dw-1:0]rdata);

  parameter ms = 1<<ps;  
  logic [dw-1:0]fifo[ms-1:0];
  
  always_ff @(posedge wclk) begin
    if (wren) fifo[waddr] <= wdata;  
  end
  
  assign  rdata = fifo[raddr];

endmodule