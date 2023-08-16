// Code your testbench here
// or browse Examples
module ram_tb();
  logic clk_a, nrst_a, ce_a, we_a; 
  reg [7:0]din_a, adr_a;
  reg [7:0]dout_a;

  logic clk_b, nrst_b, ce_b, we_b; 
  reg [7:0]din_b, adr_b;
  reg [7:0]dout_b;
  
  dual_port_ram_dual_rate dram(clk_a, nrst_a, ce_a, we_a, din_a, adr_a, dout_a, clk_b, nrst_b, ce_b, we_b, din_b, adr_b, dout_b);
  
  always @(*) begin
    #2;
    clk_a <= ~clk_a;
  end
  
  always @(*) begin
    #4;
    clk_b <= ~clk_b;
  end
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk_a = 0; 
    clk_b = 0;
    nrst_a = 1;
    nrst_b = 1;
    
    for (int i = 0; i<3; i++) begin
      ce_a = 1;
      ce_b = 1;
      
      //write
      we_a = 1; 
      we_b = 1;
      
      din_a = 16'h77 + i;
      adr_a = 2*i+0;
      #10;
  
      din_a = 16'hee - i;
      adr_a = 2*i+1;
      #10;
      
      din_b = 16'h33 + i;
      adr_b = 2*i+2;
      #10;
      din_b = 16'haa + i;
      adr_b = 2*i+3;
      #10;
    
      //read
      we_a = 0;
      adr_a = 2*i+0;
      #10;
      adr_a = 2*i+1;
      #10;
      
      we_b = 0;
      adr_b = 2*i+2;
      #10;
      adr_b = 2*i+3;
      #10;
    
      //chip en = 0
      ce_a = 0;
      ce_b = 0;
      
      adr_a = 0;
      adr_b = 0;
      #15;

      //reset
      nrst_a = 0;
      #20;
      nrst_a = 1;
      #10;
    
    end
    
    $finish();
  end
  
endmodule