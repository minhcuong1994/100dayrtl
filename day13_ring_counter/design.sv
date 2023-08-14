// Code your design here
module ring_counter(
  input clk, ori,
  output reg [3:0]cnt);

  parameter S0 = 4'b0001;
  parameter S1 = 4'b0010;
  parameter S2 = 4'b0100;
  parameter S3 = 4'b1000;
  
  reg [3:0]c_state, n_state;
  
  initial begin
    cnt <= 4'b000;
  end
  
  always_ff @(posedge clk) begin
    c_state <= n_state;
  end
  
  always_comb begin
    case (c_state)
      S0: begin 
        if (ori) n_state = S1;
        else n_state = S0;
      end
      
      S1: begin
        if (ori) n_state = S2;
        else n_state = S0;    
      end
      
       S2: begin
        if (ori) n_state = S3;
        else n_state = S0;    
      end
      
       S3: n_state = S0;  
      
      default: if (~ori) n_state = S0;
    endcase 
  end
  
  always@(*) begin
    cnt <= c_state;
  end
  
  
  
endmodule
  
  