// Code your design here
module apb_master (
  input logic PCLK, PRESETn, PREADY,
  input reg [31:0] PRDATA,
  input reg [31:0] WDATA, SADDR,
  input reg [1:0] CMD,
  output logic PSEL0, PENABLE, PWRITE,
  output reg [31:0] RDATA, PWDATA, PADDR);

  localparam CMD_NOP = 2'b00, CMD_R = 2'b01, CMD_W = 2'b10;
  
  typedef enum logic [1:0] {B_IDLE, B_SETUP, B_ACCESS} apb_state_t;
  apb_state_t apb_state_current, apb_state_next;

  //ff apb state update
  always_ff @(posedge PCLK, negedge PRESETn) begin
    if (!PRESETn) apb_state_current <= B_IDLE;
    else apb_state_current <= apb_state_next;
  end

  //state combination
  always_comb begin
    case (apb_state_current) 
        
        B_IDLE: if ((CMD == CMD_R)|(CMD == CMD_W)) apb_state_next <= B_SETUP;
        B_SETUP: apb_state_next <= B_ACCESS;
        B_ACCESS: begin
          if (PREADY & ((CMD == CMD_R)|(CMD == CMD_W))) apb_state_next <= B_SETUP;
          else if (PREADY & (CMD == CMD_NOP)) apb_state_next <= B_IDLE; 
          else if (!PREADY) apb_state_next <= B_ACCESS;
        end

        default: apb_state_next <= B_IDLE;
    endcase
  end

  //write/read signal
  assign PSEL0 = PRESETn & ((apb_state_current == B_SETUP) | (apb_state_current == B_ACCESS));
  assign PENABLE = PRESETn & (apb_state_current == B_ACCESS);
  assign PWRITE = PRESETn & (CMD == CMD_W) & ((apb_state_current == B_SETUP)|(apb_state_current == B_ACCESS));
  
  //Write/Read REG
  always_ff @(posedge PCLK, negedge PRESETn) begin
    if(!PRESETn) begin
      PWDATA <= {32{1'b0}};
      PADDR <= {32{1'b0}};
    end

    else begin
      PADDR <= SADDR;    
      if(PENABLE & ~(PWRITE)) RDATA <= PRDATA;
      if(PWRITE) PWDATA <= WDATA;
    end
    
  end
  
endmodule
  
  