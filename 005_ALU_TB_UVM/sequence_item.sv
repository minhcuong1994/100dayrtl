class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item)
  
  function new (string name = "seq_item");
    super.new(name);
  endfunction
  
  rand logic rst_n;
  rand logic [2:0] ctl;
  rand logic [7:0] a, b;
  logic [7:0] q;
  logic cout;
  
endclass