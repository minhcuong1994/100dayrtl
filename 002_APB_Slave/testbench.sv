// Code your testbench here
// or browse Examples
module apb_slave_tb ();
  
  logic PCLK, PRESETn, PSEL, PENABLE, PWRITE;
  reg [31:0] PADDR, PWDATA;
  logic PREADY; 
  reg [31:0] PRDATA, SDATA;
  
  apb_slave test(.*);
  
  always #1 PCLK <= ~ PCLK;
  
  
  initial begin
    
    $dumpfile("file.vcd");
    $dumpvars(1);
    
    PCLK = 0;
    PRESETn = 0;
    PSEL = 0;
    PENABLE = 0;
    PWRITE = 0;
    
    #2;
    PRESETn = 1;
    #4;
    
    
    //READ
    PSEL = 1;
    PWRITE = 0;
    #2;
    PADDR = 1;
    #2;
    PENABLE = 1;
    #2;
    PADDR = 2;
    #2;
    PADDR = 3;
    #2;
    
    //WRITE
    PWRITE = 1;
    PWDATA = 2;
    #2;
    PADDR = 1;
    #2;
    PENABLE = 1;
    #2;
    PADDR = 2;
    #2;
    PADDR = 3;
    #2;
    
    
    
    #4;
   
    $finish();
  end
  
endmodule