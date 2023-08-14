// Code your testbench here
// or browse Examples
module ram_tb();
  
  logic clk, nrst, ce, wr;
  reg [15:0]din, dout;
  reg [7:0]addr;
  
  always @(*) begin
  	#2;
    clk <= ~clk;
  end
  
  single_port_ram sp_ram(clk, nrst, ce, wr, din, addr, dout);
  
  initial begin 
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    clk = 0;
    nrst = 1; 
    
    for (int i = 0; i<3; i++) begin
      ce = 1;
      
      //write
      wr = 1;
      din = 16'h77 + i;
      addr = 2*i+0;
      #10;
      din = 16'hee - i;
      addr = 2*i+1;
      #10;
    
      //read
      wr = 0;
      addr = 2*i+0;
      #10;
      addr = 2*i+1;
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