class test_seq extends uvm_sequence #(seq_item);
  `uvm_object_utils(test_seq)
  `uvm_declare_p_sequencer(uvm_sequencer #(seq_item))
  
  function new (string name = "test_seq");
    super.new(name);
  endfunction
  
 
  virtual task pre_body();
    if(starting_phase != null) starting_phase.raise_objection (this);
  endtask
  
  
  seq_item item;
  virtual task body();
   //reset
   repeat(2) begin 
     item = seq_item::type_id::create("item");
     start_item(item);
     item.randomize() with {rstn == 0;};
     finish_item(item);
    end
   //normal
   repeat(8) begin
     item = seq_item::type_id::create("item"); 
     start_item(item);
     item.randomize() with {rstn == 1;};
     finish_item(item); 
   end
  endtask
  
  
  virtual task post_body();
    if(starting_phase != null) starting_phase.drop_objection (this);
  endtask
  
endclass