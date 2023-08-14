// Code your design here
module single_port_ram #(parameter dsize = 8, dwith = 16) (
  input clk, nrst, ce, wr, 
  input [dwith-1:0] d_in,
  input [dsize-1:0] addr,
  output reg [dwith-1:0] d_out);
  
  reg [dwith-1:0] d_ram [dsize-1:0];
  
  initial begin
    d_out <= {dwith{1'b1}};
  end
  
  always @(posedge clk) begin
    //reset
    if (~nrst) begin 
      d_out <= {dwith{1'b1}};
      
      for (int i=0; i<dsize; i++) begin
        d_ram[i] <= {dwith{1'b1}};
      end 
      
    end
    
    //nrst=1, ce=1
    else if (ce) begin 
      //write
      if (wr) begin 
        d_ram[addr] <= d_in;
      end
      
      //read
      else begin 
        d_out <= d_ram[addr];
      end
    end
      
  end
  
endmodule
  