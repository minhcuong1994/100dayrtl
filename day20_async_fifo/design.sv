// Code your design here
`include "sync_2ff.sv"
`include "read_handler.sv"
`include "write_handler.sv"
`include "fifo_memory.sv"


module async_fifo #(parameter dw=8, ps=4) (
  input wclk, wrst_n, winc, 
  input [dw-1:0]wdata,
  input rclk, rrst_n, rinc,
  output logic wfull, rempty, 
  output reg [dw-1:0]rdata);
    
  reg [ps:0]wptr, rptr, wq2_rptr, rq2_wptr;
  reg [ps-1:0]waddr, raddr;
    
  logic wren;    
  assign wren = !wfull & winc;

  sync_2ff w2r(rrst_n, rclk, wptr, rq2_wptr);
  sync_2ff r2w(wrst_n, wclk, rptr, wq2_rptr);
  write_full_handler wr_hanler(.*);
  read_empty_handler rd_handler(.*);
  fifo_memory fifo_m(.*);

endmodule