class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(seq_item, scoreboard) scb_port;
  seq_item trans[$];
  bit[3:0] seq_pattern, seq_result;
  
  function new (string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    scb_port = new ("scb_port", this);
    uvm_config_db #(bit[3:0])::get(this, "*",  "v_pattern", seq_pattern); //get ref_pattern in testbench
  endfunction
  
  virtual function void write(seq_item item);
    trans.push_back(item);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      seq_item c_tran;
      wait(trans.size() != 0);
      c_tran = trans.pop_front();
      compare(c_tran);
    end
  endtask
    
  virtual task compare (seq_item item);
    bit expected_out;
    expected_out = (seq_result == seq_pattern) ? 1 : 0;
    
    if(expected_out != item.out) begin
      `uvm_error("SCB", $sformatf("Test failed seq = %b, expected_out = %b, out = %b", seq_result, expected_out, item.out))
    end
    
    seq_result = seq_result << 1 | item.in;
    
  endtask
  
endclass