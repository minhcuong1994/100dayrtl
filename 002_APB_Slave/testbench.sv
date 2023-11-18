// or browse Examples
module apb_slave_tb ();
  logic PCLK, PRESETn, PSEL, PENABLE, PWRITE;
  logic [31:0] PADDR, PWDATA;
  logic PREADY; 
  logic [31:0] PRDATA; 
  logic [63:0] SDATA;
  
  //stimulus vars
  logic [31:0] rand_addr, rand_data;
  //model vars
  logic [31:0] MDL_PRDATA; 
  logic [63:0] MDL_SDATA;
  
  apb_slave test(.*);
  
  //Clock gen
  initial begin 
    PCLK = 0;
  end
  always #5 PCLK <= ~ PCLK;
  
  //simulation configuration
  initial begin
    $dumpfile("file.vcd");
    $dumpvars;
    
    #300;
    $finish();
    
  end
  
  //generate random signal => drive to dut
  initial begin

    //reset state---------------
    PRESETn = 0;
    PSEL = 0;
    PENABLE = 0;
    PWRITE = 0;
    @(posedge PCLK);
    
    //compare dut vs. model
    MDL_SDATA = 64'd0;
    MDL_PRDATA = 32'd0;
    if ((MDL_SDATA == SDATA) & (MDL_PRDATA == PRDATA))
      $display("PASS - RSTn");
    else
      $display("FAILED - RSTn, MDL SDATA=%h, PRDATA=%h, DUT SDATA=%h, PRDATA=%h",MDL_SDATA, MDL_PRDATA, SDATA, PRDATA);
    
    
    
    //idle state----------------
    PRESETn = 1;
    @(posedge PCLK);
    
    
    //Master Write---------------
    repeat (5) begin
      rand_addr = $urandom() & 32'h0000_ffff;
      rand_data = $urandom() & 32'h0000_ffff;
      PADDR = rand_addr;
      PWDATA = rand_data;
      PWRITE = 1;
      PSEL = 1;
      @(posedge PCLK);

      PENABLE = 1; 
      @(posedge PCLK);
      @(posedge PCLK);
      
      
      //compare dut vs. model
      #1;
      MDL_SDATA = {rand_addr, rand_data};
      if (MDL_SDATA == SDATA)
        $display("PASS - PWRITE");
    else
      $display("FAILED - PWRITE, MDL SDATA=%h, DUT SDATA=%h",MDL_SDATA, SDATA);
 
      PENABLE = 0; 
      @(posedge PCLK);
      
    end
    
   
   //Master Read 
    repeat (3) begin
      rand_addr = $urandom() & 32'h0000_ffff;
      PADDR = rand_addr;
      PWDATA = rand_data;
      PWRITE = 0;
      
      PENABLE = 1;
      @(posedge PCLK);
      @(posedge PCLK);
      
      //compare dut vs. model
      #1;
      MDL_PRDATA = rand_addr; 
      if (MDL_PRDATA == PRDATA)
        $display("PASS - PREAD");
      else
        $display("FAILED - PREAD, MDL PRDATA=%h, DUT PRDATA=%h",MDL_PRDATA, PRDATA);
      
      PENABLE = 0;
      @(posedge PCLK);
      
    end
  end
  
endmodule