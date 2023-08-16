// Code your design here

`include "single_port_ram.sv"

module dual_port_ram_dual_rate (
  input clk_a, nrst_a, ce_a, we_a, 
  input [dwith-1:0]din_a, adr_a,
  output reg [dwith-1 :0]dout_a,

  input clk_b, nrst_b, ce_b, we_b, 
  input [dwith-1:0]din_b, adr_b,
  output reg [dwith-1 :0]dout_b);
  
  single_port_ram sram_a(clk_a, nrst_a, ce_a, we_a, din_a, adr_a, dout_a);
  single_port_ram sram_b(clk_b, nrst_b, ce_b, we_b, din_b, adr_b, dout_b);
  
endmodule
  
  
  
  