//7bit data serial rx, clk sync, no parity

`define PARITY_EVEN

module serial_rx(clk, rst_n, in, out, done, err);
  input clk, rst_n, in;
  output out, done, err;
  
  wire clk, in, rst_n, done, err;
  wire [7:0] out;
    
  reg [3:0] rx_count, parity_sum;
  reg parity_err;
  reg [7:0] rx_byte; 
  
  reg [3:0] current_s, next_s;
  parameter IDLE = 3'd0, START = 3'd1, DATA = 3'd2, STOP = 3'd3, ERR = 3'd4;
    
    
  //state transition ff
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n)
      current_s = IDLE;  
    else
      current_s = next_s;
  end
    
    
  //state combination
  always @ * begin  
    case (current_s)     
      IDLE: begin 
        if (!in) next_s = START;
        else next_s = IDLE; 
      end
      
      START: begin
        next_s = DATA;
      end
            
      DATA: begin
        if (rx_count < 8) next_s = DATA;    
        else begin
          if (in) next_s = STOP;   
          else next_s = ERR;     
        end   
      end
             
      STOP: begin
        if (!in) next_s = START;   
        else next_s = IDLE;  
      end
            
      ERR: begin
        if (in) next_s = IDLE;
        else next_s = ERR;
      end
              
      default: next_s = IDLE;
    endcase
  end
    
  
  //rx data handle
   always @(posedge clk, negedge rst_n) begin       
    if(!rst_n) begin       
      rx_count = 4'd0;     
      rx_byte = 8'd0; 
      parity_err = 1'b0;
      parity_sum = 8'd0;
      
    end  
    else begin       
      if(current_s == DATA) begin   
        
        if (rx_count > 7) begin
          rx_count = 4'd0;  
          parity_sum = 4'd0;  
        end
 
        rx_byte = {in, rx_byte[7:1]};
    
        if (rx_count < 7) parity_sum = parity_sum + in;
 
        if(rx_count == 7) begin
          `ifdef PARITY_EVEN  
          if ((parity_sum % 2) != in) parity_err = 1'b1;
          else parity_err = 1'b0;
          `endif

          `ifdef PARITY_ODD
          if (((parity_sum+1) % 2) != in) parity_err = 1'b1; 
          else parity_err = 1'b0;
          `endif
        end
        
        rx_count = rx_count + 1;
      end    
    end  
  end
  
  
  //output hanle
  assign done = (current_s == STOP)? 1 : 0;
  assign out = ((current_s == STOP) || (!rst_n)) ? {0, rx_byte[6:0]} : out;
  assign err = (current_s == STOP) ? parity_err : 1'b0;

endmodule
