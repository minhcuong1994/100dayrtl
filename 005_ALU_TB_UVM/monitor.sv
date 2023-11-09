class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  seq_item item;
  uvm_analysis_port #(seq_item) monitor_port;
  virtual alu_interface intf;
  
  
  function new (string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", intf))) 
      begin
        `uvm_error("DRIVER", "Cannot find VIF")
      end
    
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      item = seq_item::type_id::create("item");
      @(posedge intf.clk);
      item.rst_n = intf.rst_n;
      item.ctl = intf.ctl;
      item.a = intf.a;
      item.b = intf.b;
      
       @(posedge intf.clk);
      item.q = intf.q;
      item.cout = intf.cout;
      
      monitor_port.write(item);
      
      `uvm_info("MONITOR", $sformatf("rst_n=%b, ctl=%b, a=%d, b=%d, q=%d, cout=%b", item.rst_n, item.ctl, item.a, item.b, item.q, item.cout), UVM_LOW)
    end
    
  endtask
  
  
  
endclass
  