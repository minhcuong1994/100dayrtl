class test_sequence extends uvm_sequence;
  `uvm_object_utils(test_sequence)
  `uvm_declare_p_sequencer(uvm_sequencer #(seq_item))
  
  seq_item item;
  
  function new (string name = "test_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat (2) begin
      item = seq_item::type_id::create("item");
      start_item(item);
      item.randomize() with {rst_n == 0;};
      finish_item(item);
    end
    
    repeat (10) begin
      item = seq_item::type_id::create("item");
      start_item(item);
      item.randomize() with {rst_n == 1;};
      finish_item(item);
    end
  endtask
  
endclass
  