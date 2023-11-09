class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  
  seq_item item;
  virtual alu_interface intf;
  
  function new (string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
   
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!(uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", intf)))
      begin
        `uvm_error("DRIVER", "Cannot find VIF")
      end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      item = seq_item::type_id::create("item");
      seq_item_port.get_next_item(item);
      
      @(posedge intf.clk);
      intf.rst_n <= item.rst_n;
      intf.ctl <= item.ctl;
      intf.a <= item.a;
      intf.b <= item.b;
      
      seq_item_port.item_done();
    end
    
  endtask
  
  
  
endclass