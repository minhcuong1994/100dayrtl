class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
 
  function new (string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  
  uvm_analysis_port #(seq_item) monitor_port;
  virtual fa_interface intf;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor_port = new("monitor_port", this); 
    
    if(!(uvm_config_db #(virtual fa_interface)::get(this, "*", "vif", intf)))
      begin
        `uvm_error("MONITOR", "Failed to connect VIF")
      end
    
  endfunction
  
  
  seq_item item;
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      item = seq_item::type_id::create("item");
      
      @(posedge intf.clk);
      item.rstn = intf.rstn;
      item.cin = intf.cin;
      item.a = intf.a;
      item.b = intf.b;
      
      @(posedge intf.clk);
      item.cout = intf.cout;
      item.q = intf.q;
      
      //push item to analysis port
      monitor_port.write(item);
      
    end
  endtask
  
  
  
endclass