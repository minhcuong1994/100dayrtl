class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  function new (string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  uvm_analysis_imp #(seq_item, scoreboard) scb_port;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    scb_port = new("scb_port", this);
    
  endfunction
  
  
  seq_item trans[$];
  virtual function void write(seq_item item);
    trans.push_back(item);
  endfunction
  
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      seq_item curr_trans;
      wait(trans.size() != 0);
      curr_trans = trans.pop_front();
      compare(curr_trans);
    end
  endtask
  
  
  virtual task compare(seq_item item);
    logic [7:0] actual_q, expected_q;
    logic actual_c, expected_c;
    logic [8:0] temp;
    
    if(!item.rstn) temp = 0;
    else temp = item.a + item.b + item.cin;  
    expected_q = temp[7:0];
    actual_q = item.q;
    expected_c = temp[8];
    actual_c= item.cout;
    
    if ((actual_q == expected_q) & (actual_c == expected_c)) 
      `uvm_info("SCB", $sformatf("Passed! rstn=%b, cin=%b, a=%d, b=%d, cout=%b, q=%d", item.rstn, item.cin, item.a, item.b, item.cout, item.q), UVM_LOW)
    else
      `uvm_error("SCB", $sformatf("rstn=%b, cin=%b, a=%d, b=%d, cout=%b, q=%d", item.rstn, item.cin, item.a, item.b, item.cout, item.q));
      
  endtask
  
  
endclass