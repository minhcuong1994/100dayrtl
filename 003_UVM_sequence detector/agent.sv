class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  uvm_sequencer #(seq_item) seqr0;
  driver drv0;
  monitor mon0;
  
  function new (string name = "agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr0 = uvm_sequencer #(seq_item)::type_id::create("seqr0", this);
    drv0 = driver::type_id::create("drv0", this);
    mon0 = monitor::type_id::create("mon0", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv0.seq_item_port.connect(seqr0.seq_item_export);
  endfunction
   
endclass