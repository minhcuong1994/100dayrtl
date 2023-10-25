class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item)
  
  rand logic rst_n;
  rand logic in;
  logic out;
  
  constraint d_c {in dist {0:/40, 1:/60};}
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
endclass