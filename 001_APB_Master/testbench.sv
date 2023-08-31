// Code your testbench here
// or browse Examples
module apb_master_tb ();
  
  localparam CMD_NOP = 2'b00, CMD_R = 2'b01, CMD_W = 2'b10;
  
  logic PCLK, PRESETn, PREADY;
  reg [31:0] PRDATA;
  reg [31:0] WDATA, SADDR;
  reg [1:0] CMD;
  logic PSEL0, PENABLE, PWRITE;
  reg [31:0] RDATA, PWDATA, PADDR;
  
  apb_master test(.*);
  
  always #1 PCLK <= ~ PCLK;
  
  
  initial begin
    
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    PCLK = 0;
    PREADY = 0;
    PRESETn = 0;
    
    #2;
    PRESETn = 1;  
    PRDATA = 32'hffff0000;
    SADDR = 32'h00001111;
  
    #2;
    CMD = CMD_W; //APB MASTER WRITE
    
    #2;
    PREADY = 1;
    WDATA = 32'h0000eeee;
    #4;
    WDATA = 32'h0000dddd;
    #4;
    PREADY = 0;
    #6;
    PREADY = 1;
    #2;
    
    CMD = CMD_R; //APB MASTER READ
    #6;
   
    $finish();
  end
  
endmodule