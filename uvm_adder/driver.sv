class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  
  function new (string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  virtual fa_interface intf;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!(uvm_config_db #(virtual fa_interface)::get(this, "*", "vif", intf)))
      begin
        `uvm_error("DRIVER", "Failed to connect VIF")
      end
    
  endfunction
  
  
  seq_item item;
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      item = seq_item::type_id::create("item");
      
      seq_item_port.get_next_item(item);

      @(posedge intf.clk);
      intf.rstn <= item.rstn;
      intf.cin <= item.cin;
      intf.a <= item.a;
      intf.b <= item.b;

      seq_item_port.item_done();
    end
    
  endtask
  
endclass