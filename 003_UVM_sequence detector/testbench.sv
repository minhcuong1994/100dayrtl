`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"

parameter ref_pattern = 4'b1101;

module test_top();
  
  //clock generator
  logic clk;
  initial clk = 0;
  always #1 clk = ~clk;
  
  //connect dut
  seq_intf intf(clk);
  seq_detect dut(.clk(intf.clk),
                 .rst_n(intf.rst_n),
                 .in(intf.in),
                 .out(intf.out));
  
  
  //uvm config
  bit [3:0] pattern = ref_pattern; //ref pattern
  
  initial begin
    uvm_config_db #(virtual seq_intf)::set(null, "*", "vif", intf);
    //pass ref pattern to scoreboard
    uvm_config_db #(bit[3:0])::set(null, "*", "v_pattern", pattern);
    
    run_test("test");
  end
  

  //simulation & EPW config
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    #300;
    $finish();
  end
  
endmodule