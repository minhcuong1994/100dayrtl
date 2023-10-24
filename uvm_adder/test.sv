class test extends uvm_test;
  `uvm_component_utils(test);
  
  function new (string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  env test_env;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    test_env = env::type_id::create("test_env",this);
  endfunction
  
  
  test_seq seq;
  virtual task run_phase(uvm_phase phase);
    repeat(2) begin
      phase.raise_objection(this);
      seq = test_seq::type_id::create("seq");
      seq.start(test_env.agnt.seqr);
      phase.drop_objection(this);
    end
  endtask
  
  
  
endclass