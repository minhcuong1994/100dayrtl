// Code your design here
parameter dsize = 8;
parameter dwith = 8;

module simple_dual_port_ram (
  input clk, ce, nrst, we, re,
  input [dwith-1:0]adr_a, adr_b, din,
  output reg [dwith-1:0]dout);
  
  reg [dsize-1:0]dram[dwith-1:0];
  
  initial begin
    for (int i=0; i<dsize; i++) begin
      dram[i] = {dwith{1'b0}};
    end
 
    dout = {dwith{1'b0}};
  end
  
  always @(posedge clk, negedge nrst) begin
    //reset
    if(~nrst) begin    
      for (int i=0; i<dsize; i++) begin
        dram[i] = {dwith{1'b0}};
      end
      
      dout = {dwith{1'b0}};
    end
    
    if (ce) begin
      //write, portA
      if (we) dram[adr_a] <= din;
      //read, portB
      if (re) dout <= dram[adr_b];
    end
  end
  
endmodule