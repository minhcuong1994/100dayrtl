module read_empty_handler #(parameter ps=4) (
  input rclk, rrst_n, rinc,
  input [ps:0]rq2_wptr,
  output reg rempty,
  output reg [ps:0]rptr,
  output [ps-1:0]raddr);
  
  reg [ps:0]b_rptr;
  wire [ps:0]b_rptr_next, g_rptr_next;
  logic rempty_t;
  
  always_ff @(posedge rclk, negedge rrst_n) begin
    if (!rrst_n) begin 
      rempty <= 1'b1; 
      b_rptr <= '0;  
      rptr <= '0;  
    end
    else begin   
      rempty <= rempty_t;  
      b_rptr <= b_rptr_next;  
      rptr <= g_rptr_next;  
    end   
  end 

   
  assign raddr = b_rptr[ps-1:0];
  assign b_rptr_next = b_rptr + (!rempty & rinc);
  assign g_rptr_next = (b_rptr_next>>1) ^ b_rptr_next;
  assign rempty_t = (g_rptr_next == rq2_wptr);
    
endmodule