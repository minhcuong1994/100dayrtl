class env extends uvm_env;
  `uvm_component_utils(env)
  
  function new (string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  scoreboard scb;
  agent agnt;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agnt = agent::type_id::create("agnt", this);
    scb = scoreboard::type_id::create("scb", this);
    
  endfunction
  
  
  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    
    agnt.mon.monitor_port.connect(scb.scb_port);
    
  endfunction
  
  
endclass