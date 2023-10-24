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

parameter width = 8;



module test_top();
  
  //clock & interface--------------------------------
  logic clk;
  
  initial begin
    clk = 0;
    forever begin
      clk = ~clk;
      #1;
    end
  end
  
  fa_interface #(width) intf(clk);
  simple_fa #(width) dut(intf.rstn,
                     intf.clk,
                     intf.cin,
                     intf.a,
                     intf.b,
                     intf.cout,
                     intf.q
                    );
  
  //uvm------------------------------------------------
  initial begin
    uvm_config_db #(virtual fa_interface)::set(null, "*", "vif", intf);
    run_test("test");
  end
  
  //EPWave ---------------------------------------------
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();

    #2000;
    $finish();    
  end
  
endmodule