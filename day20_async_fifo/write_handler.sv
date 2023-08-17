module write_full_handler #(parameter ps=4) (
  input wclk, wrst_n, winc,
  input [ps:0]wq2_rptr,
  output reg wfull,
  output reg [ps:0]wptr,
  output [ps-1:0]waddr);

  reg [ps:0]b_wptr;  
  wire [ps:0]b_wptr_next, g_wptr_next;
  logic wfull_t;

  always_ff @(posedge wclk, negedge wrst_n) begin
    if (!wrst_n) begin
      b_wptr <= '0;
      wptr <= '0;
      wfull <= 1'b0;
    end
    else begin
      b_wptr <= b_wptr_next;
      wptr <= g_wptr_next;
      wfull <= wfull_t;
    end
  end
  
  assign waddr = b_wptr[ps-1:0];
  assign b_wptr_next = b_wptr + (winc & ~wfull);
  
  //convert to gray
  assign g_wptr_next = (b_wptr_next>>1) ^ b_wptr_next;
  
  //full condition
  assign wfull_t = (g_wptr_next == {~wq2_rptr[ps:ps-1], wq2_rptr[ps-2:0]});
    
endmodule