// Code your design here

// f/2
module clock_divider(
  input clk, rst, 
  output reg q);
  
  initial begin
    q = 0;
  end
   
  always @(posedge clk, negedge rst) begin
    if(~rst) q <= 1'b0;
    else q <= ~q;
  end
  
endmodule

// f/(2^n)
module clock_divider_n #(parameter n=3) (
  input clk, rst, 
  output reg q);
  
  reg [n:0]qt;
  
  assign qt[0] = clk;
 
  genvar i;
  generate
    for(i=0; i<n; i++) begin
      clock_divider ckl_div(qt[i], rst, qt[i+1]);
    end
  endgenerate
  
  assign q = qt[n];
  
  
endmodule

