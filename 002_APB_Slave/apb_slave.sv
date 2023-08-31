// Code your design here
module apb_slave (
  input logic PCLK, PRESETn, PSEL, PENABLE, PWRITE,
  input reg [31:0] PADDR, PWDATA,
  output logic PREADY, 
  output reg [31:0] PRDATA, SDATA);
  
  typedef enum logic [1:0] {B_IDLE, B_SETUP, B_ACCESS} bus_state_t;
  bus_state_t current_state, next_state;
  
  //State
  always_ff @(posedge PCLK, negedge PRESETn) begin
    if(!PRESETn) current_state <= B_IDLE;
    else current_state <= next_state;
  end
  
  always_comb begin
    case (current_state) 
      
      B_IDLE: if(PSEL) next_state <= B_SETUP;
      
      B_SETUP: begin
        if(PSEL) next_state <= B_ACCESS;
        else next_state <= B_IDLE;
      end
      
      B_ACCESS: begin
        if (!(PSEL | PENABLE)) next_state <= B_IDLE;
        else if (PSEL & (!PENABLE)) next_state <= B_SETUP;
        else next_state <= B_ACCESS;
      end
      
      default: next_state <= B_IDLE;
    endcase
  end
    
    //Output control
    assign PREADY = (!(current_state == B_IDLE) & PRESETn);
    
    //Reg control
    always_ff @(posedge PCLK, negedge PRESETn) begin
      if(!PRESETn) begin
        PRDATA <= {32{1'b0}};
        SDATA <= {32{1'b0}};
      end
      else begin
        if ((current_state == B_ACCESS) & PWRITE) SDATA <= PWDATA + PADDR;
        else if ((current_state == B_ACCESS) & !PWRITE) PRDATA <= PADDR;
      end
    end
  
 
endmodule