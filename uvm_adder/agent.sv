class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  function new (string name = "agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  driver drv;
  monitor mon;
  uvm_sequencer #(seq_item) seqr;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    drv = driver::type_id::create("driver", this);
    seqr = uvm_sequencer #(seq_item)::type_id::create("seqr", this);
    mon = monitor::type_id::create("mon", this);
    
  endfunction
  
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
  
endclass