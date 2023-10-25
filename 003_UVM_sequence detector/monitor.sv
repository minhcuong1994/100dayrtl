class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  uvm_analysis_port #(seq_item) monitor_port;
  virtual seq_intf intf;
  seq_item item;
  
  function new (string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual seq_intf)::get(this, "*", "vif", intf)))
      begin
        `uvm_error("MONITOR", "Not found VIF")
      end
    
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      item = seq_item::type_id::create("item");
      @(posedge intf.clk);
      item.rst_n <= intf.rst_n;
      item.in <= intf.in;
      item.out <= intf.out;
      monitor_port.write(item);
      
      `uvm_info("MONITOR", $sformatf("rst_n =%b, in=%b, out=%b", item.rst_n, item.in, item.out), UVM_LOW);
    end
  endtask
  
  
  
  
  
endclass