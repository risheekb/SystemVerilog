class Driver extends Component;
  virtual alu_interface vif;

  mailbox #(Transaction) gen2drv_h;

  function new(virtual alu_interface vif);
    this.vif = vif;
  endfunction

  virtual task reset();
   @(posedge vif.clk)
    vif.reset_n <= 1'b0;
    repeat(5) @(posedge vif.clk);
    vif.reset_n <= 1'b1; 
  endtask

  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      gen2drv_h.get(trans_h);
      send_transaction(trans_h);
    end

  endtask

  virtual task send_transaction(Transaction trans);
    @(posedge vif.clk) 
    vif.start <= 1'b1;
    vif.A <= trans.A;
    vif.B <= trans.B;
    vif.opcode <= trans.opcode;
    if(trans.opcode == MUL || trans.opcode == INC)begin
      repeat(3) @(posedge vif.clk);
      vif.start <= 1'b0;
    end
    else begin
      repeat(1) @(posedge vif.clk);
      vif.start <= 1'b0;
    end
  endtask 

  virtual task check(int n);
    repeat(n) begin
      Transaction trans_h;
      gen2drv_h.get(trans_h);
      check_transaction(n);
    end
  endtask

  virtual task check_transaction(int n);
    wait(vif.done); //wait for the alu to produce outputs
  endtask

endclass
