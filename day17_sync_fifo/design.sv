// Code your design here

module sync_fifo #(parameter dsize = 8, dwith = 8)(
    input clk, nrst, we, re,
    input [dwith-1:0]din,
    output d_full, d_empty,
    output reg [dwith-1:0]dout);


  reg [$clog2(dsize)-1:0]w_ptr, r_ptr;
  reg [dwith-1]d_fifo[dsize];
  
  
  always @(posedge clk) begin
    //reset
    if(~nrst) begin
      dout <= {dwith{1'b0}};
      w_ptr <= {$clog2(dsize){1'b0}};                        
      r_ptr <= {$clog2(dsize){1'b0}};
    end
    else begin
      
      //write
      if(we & ~d_full) begin
        d_fifo[w_ptr] <= din;
        w_ptr <= w_ptr + 1;
      end
      
      //read
      if(re & ~d_empty) begin
        dout <= d_fifo[r_ptr];
        r_ptr <= r_ptr + 1;
      end
    end
  end
  

  //Control logic
  assign d_full = (w_ptr+1'b1) == r_ptr;
  assign d_empty = w_ptr == r_ptr;

endmodule