`timescale 1ns/1ns

//Interface ----------------------------------------------------
interface alu_interface (input clk);
  logic rst_n;
  logic [2:0]ctl;
  logic [7:0]a,b;
  logic [7:0]q;
  logic cout;
  
endinterface

//Golden model -------------------------------------------------
module golden_model(clk, rst_n, ctl, a, b, md_q, md_cout);
  input clk, rst_n, ctl, a,b;
  output md_q, md_cout;
  
  logic clk, rst_n;
  logic [2:0] ctl;
  logic [7:0] a, b, md_q;
  logic md_cout; 
  logic [8:0] md_tmp;
  
  initial begin
    md_tmp = 8'd0;
  end
 
  always @ (ctl, a, b) begin
    case(ctl)
      3'b000: md_tmp = a + b;
      3'b001: md_tmp = a - b;
      3'b010: md_tmp = a * b;
      3'b011: md_tmp = a / b;
      default: md_tmp = a + b;
    endcase
  end
  
  always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      md_q = 7'd0;
      md_cout = 1'd0;
    end
    else begin
      md_q = md_tmp[7:0];
      md_cout = md_tmp[8];
    end
  end
endmodule

//Compare result between DUT vs. Golden model -----------------
task compare_result;
  input logic [7:0] dut_q;
  input dut_cout;
  input [7:0]md_q;
  input md_cout;
  logic [8:0] dut_tmp, md_tmp;
  
  assign dut_tmp = {dut_cout, dut_q};
  assign md_tmp = {md_cout, md_q};
  
  begin
    if (dut_tmp == md_tmp) begin
      $display("Passed! DUT q=%b , cout=%b, MDL q=%b, cout=%b",dut_q, dut_cout, md_q, md_cout);
    end else begin
      $display("Failed! DUT q=%b , cout=%b, MDL q=%b, cout=%b",dut_q, dut_cout, md_q, md_cout);
    end
  end
endtask


//Test bench---------------------------------------------------
module test_bench ();
  
  logic clk, rst_n;
  logic [7:0] a, b, q;
  logic [2:0] ctl;
  logic cout;
  
  logic [7:0] mdl_q; 
  logic mdl_cout;
  
  logic [7:0] dut_q;
  logic dut_cout;
  
  
  //clock generator
  initial begin
    clk = 0;
  end
  always @ * begin
    clk <= #1 ~clk;
  end
  
  //simulation configuration
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    #50;
    $finish();
  end
  
  //connect interface vs. dut
  alu_interface intf(clk);
  alu dut(.clk(intf.clk),
           .rst_n(intf.rst_n),
           .ctl(intf.ctl),
           .a(intf.a),
           .b(intf.b),
           .q(intf.q),
           .cout(intf.cout)
          );
  
  
  //stimulus signal generator
  initial begin
    rst_n = 0;
    #2;
    rst_n = 1;
    
    for(int i = 0; i < 20; i= i+1) begin
      a = i+1;
      b = i * 2;
      ctl = i%4;
      #2;
    end
  end
  
  //drive stimulus signal to dut
  always @(rst_n, ctl, a, b) begin
    intf.rst_n = rst_n;
    intf.ctl = ctl;
    intf.a = a;
    intf.b = b;
  end
  
  //monior signal from dut:
  always @ * begin
    dut_q = intf.q;
    dut_cout = intf.cout;
  end
  
  //golden model
  golden_model mdl0 (.clk(clk),
                     .rst_n(rst_n),
                     .ctl(ctl),
                     .a(a),
                     .b(b),
                     .md_q(mdl_q),
                     .md_cout(mdl_cout)
                    );
  
  //compare result
  always @(posedge clk) begin
    compare_result(dut_q, dut_cout, mdl_q, mdl_cout);
  end
  
endmodule

