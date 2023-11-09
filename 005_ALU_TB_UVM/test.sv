class test extends uvm_test;
  `uvm_component_utils(test)
  
  env env0;
  test_sequence seq0;
  
  function new (string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env0 = env::type_id::create("env0", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    repeat(2) begin
      phase.raise_objection(this);
      seq0 = test_sequence::type_id::create("seq0", this);
      seq0.start(env0.agnt0.seqr0);
      phase.drop_objection(this);
      
    end
    
  endtask
  
  
  
endclass