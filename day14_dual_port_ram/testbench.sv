// Code your testbench here
// or browse Examples
module ram_tb();
  logic clk, nrst, ce, we_a, we_b;
  reg [8:0]din_a, adr_a, din_b, adr_b, dout_a, dout_b;
  
  dual_port_ram dram(clk, nrst, ce, we_a, we_b,din_a, adr_a, din_b, adr_b,dout_a, dout_b);
  
  always @(*) begin
    #2;
    clk <= ~clk;
  end
  
  initial begin
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    nrst = 1; 
    
    for (int i = 0; i<3; i++) begin
      ce = 1;
      
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
      ce = 0;
      #10;
      ce = 1;
      #10;

      //reset
      nrst = 0;
      #20;
      nrst = 1;
      #10;
    
    end
    
    $finish();
  end
  
endmodule