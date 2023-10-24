interface fa_interface #(w) (input bit clk);
  logic rstn;
  logic cin;
  logic [w-1:0]a;
  logic [w-1:0]b;
  logic cout;
  logic [w-1:0]q;
endinterface