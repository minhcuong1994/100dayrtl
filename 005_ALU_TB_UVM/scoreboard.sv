class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  seq_item trans[$];
  uvm_analysis_imp #(seq_item, scoreboard) scoreboard_port;
  
  function new (string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    scoreboard_port = new ("scoreboard_port", this);
    
  endfunction
  
  virtual function void write(seq_item item);
    trans.push_back(item);
  endfunction
  
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      seq_item item;
      wait(trans.size()!=0);
      item = trans.pop_front();
      compare(item);
      
    end
    
  endtask
  
  
  virtual task compare(seq_item item);
    logic sm_rst_n;
    logic [2:0] sm_ctl;
    logic [7:0] sm_a, sm_b;
    
    logic [7:0] dut_q;
    logic dut_cout;
    
    logic [7:0] mdl_q;
    logic mdl_cout;
    logic [8:0] mdl_temp;
    
    sm_rst_n = item.rst_n;
    sm_ctl = item.ctl;
    sm_a = item.a;
    sm_b = item.b;
      
    dut_q = item.q;
    dut_cout = item.cout;

    case (sm_ctl)
      3'b000: mdl_temp = sm_a + sm_b;
      3'b001: mdl_temp = sm_a - sm_b;
      3'b010: mdl_temp = sm_a * sm_b;
      3'b011: mdl_temp = sm_a / sm_b;
      default: mdl_temp = sm_a + sm_b;
    endcase
    
    if(!sm_rst_n) mdl_temp = 8'd0;
    
    mdl_q = mdl_temp[7:0];
    mdl_cout = mdl_temp[8];
    
    if ((mdl_q == dut_q) && (mdl_cout == dut_cout)) 
      begin
        `uvm_info("SCB", $sformatf("PASSED!, q=%d, c=%b", dut_q, dut_cout), UVM_LOW)
      end else
        `uvm_error("SCB", $sformatf("FAILED!, rst_n=%b, ctl=%b, a=%d, b=%d, dut_q=%d, dut_c=%b, mdl_q=%d, mdl_c=%b", sm_rst_n, sm_ctl, sm_a, sm_b, dut_q, dut_cout, mdl_q, mdl_cout), UVM_LOW)
      begin
      end
    
  endtask
  
endclass