// Code your design here

`include "single_port_ram.sv"

module dual_port_ram (
  input clk, nrst, ce, we_a, we_b, 
  input [dwith-1:0]din_a, adr_a, din_b, adr_b,
  output reg [dwith-1 :0]dout_a, dout_b);
  
  single_port_ram sram_a(clk, nrst, ce, we_a, din_a, adr_a, dout_a);
  single_port_ram sram_b(clk, nrst, ce, we_b, din_b, adr_b, dout_b);
  
endmodule
  
  
  
  