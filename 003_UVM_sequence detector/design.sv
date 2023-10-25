// Code your design here

//1101
module seq_detect (clk, rst_n, in, out);
  input clk, rst_n, in;
  output out;
  
  wire clk, rst_n, in, out;
   
  parameter S0=4'b0000;
  parameter S1=4'b0001;
  parameter S2=4'b0011;
  parameter S3=4'b0110;
  parameter S4=4'b1101;
    
  logic [3:0]c_state, n_state;
  
  always_ff @(posedge clk) begin    
    if (!rst_n) c_state <= S0;  
    else c_state <= n_state; 
  end
     
  always_comb begin
        
    case (c_state)    
      S0: begin     
        if(in) n_state = S1;   
      end

      S1: begin      
        if(in) n_state = S2;    
        else n_state = S0;
      end
             
      S2: begin
        if(~in) n_state = S3;
      end
            
            
      S3: begin
        if(in) n_state = S4;   
        else n_state = S0;
      end
                    
      S4: begin
        if(in) n_state = S1;  
        else n_state = S0; 
      end

      default: n_state = S0;
    endcase 
  end

  assign out = (c_state == S4)? 1: 0;
    

endmodule