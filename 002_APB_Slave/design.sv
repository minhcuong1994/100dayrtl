//APB slave, 
// Master write => SDATA = {PADDR,PWDATA}
// Master read, send to master PADDR

module apb_slave (
  input wire PCLK, PRESETn, PSEL, PENABLE, PWRITE,
  input reg [31:0] PADDR, PWDATA,
  output wire PREADY, 
  output reg [31:0] PRDATA, 
  output reg [63:0] SDATA);
  
  parameter IDLE = 2'b00, SETUP = 2'b01, ACCESS = 2'b10;
  reg [2:0] current_s, next_s;
 
  
  //State transition ff
  always @(posedge PCLK, negedge PRESETn) begin
    if(!PRESETn) current_s <= IDLE;
    else current_s <= next_s;
  end
  
  //State combination
  always @ * begin
    case (current_s) 
      
      IDLE: if(PSEL) next_s = SETUP;
      
      SETUP: begin
        if(PSEL & PENABLE) next_s = ACCESS;
        else if (PSEL) next_s = SETUP;
        else next_s = IDLE;
      end
      
      ACCESS: begin
        if (!(PSEL | PENABLE)) next_s = IDLE;
        else if (PSEL & (!PENABLE)) next_s = SETUP;
        else next_s = ACCESS;
      end
      
      default: next_s = IDLE;
    endcase
  end
    
    
  //Output control
  assign PREADY = (current_s == ACCESS) ? 1'b0 : 1'b1; 
      
  
  //Reg control
  always @ (posedge PCLK, negedge PRESETn) begin
    if(!PRESETn) begin
      PRDATA = 32'd0;
      SDATA = 64'd0;
    end
    else begin
      if ((current_s == ACCESS) & PWRITE) SDATA = {PADDR,PWDATA};
      else if ((current_s == ACCESS) & !PWRITE) PRDATA = PADDR;
    end  
  end
  
endmodule