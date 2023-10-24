class seq_item extends uvm_sequence_item;
  
  rand logic rstn;
  rand logic cin;
  rand logic [7:0]a,b;
  rand logic cout;
  rand logic [7:0]q;

  
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(a, UVM_DEFAULT)
  `uvm_field_int(b, UVM_DEFAULT)
  `uvm_field_int(q, UVM_DEFAULT)
  `uvm_object_utils_end


  constraint a_c {a inside {[250:255]};};
  constraint b_c {b inside {10,20,30,40};};
  
  
  function new (string name = "seq_item");
    super.new(name);
  endfunction
  
endclass: seq_item