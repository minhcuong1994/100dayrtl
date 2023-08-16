// Code your design here
parameter dsize = 8; 
parameter dwith = 8;

module single_port_ram (
  input clk, nrst, ce, we, 
  input [dwith-1:0]din, adr,
  output reg [dwith-1 :0]dout);
  
  reg [dsize-1:0]dram[dwith-1:0];
  
  initial begin 
    for (int i=0; i<dsize; i++) begin
      dram[i] = {dwith{1'b1}};  
    end
      
    dout = {dwith{1'b1}};
  end
  
  always @(posedge clk, negedge nrst) begin
    //reset
    if(~nrst) begin
      for (int i=0; i<dsize; i++) begin
        dram[i] = {dwith{1'b1}};
      end
      
      dout = {dwith{1'b1}};
    end
    
    // chip_en
    else if (ce) begin
      //write
      if (we) begin
        dram[adr] <= din;
      end
      else begin
        dout <= dram[adr];
      end
    end
  end
  
endmodule
  