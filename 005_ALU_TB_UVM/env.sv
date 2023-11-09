class env extends uvm_env;
  `uvm_component_utils(env)
  
  agent agnt0;
  scoreboard scb0;
  
  function new (string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agnt0 = agent::type_id::create("agnt0", this);
    scb0 = scoreboard::type_id::create("scb0", this);  
  endfunction

  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    agnt0.mon0.monitor_port.connect(scb0.scoreboard_port);
    
  endfunction
  
  
endclass