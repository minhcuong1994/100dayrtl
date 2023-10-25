class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  
  virtual seq_intf intf;
  seq_item item;
  
  function new (string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    if(!(uvm_config_db #(virtual seq_intf)::get(this, "*", "vif", intf))) 
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
      intf.in <= item.in;
      
      seq_item_port.item_done();
    end 
    
  endtask
  
endclass