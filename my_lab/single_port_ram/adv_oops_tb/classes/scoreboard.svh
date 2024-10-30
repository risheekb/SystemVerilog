class Scoreboard extends Component;
  data_t expect_a[address_t];
  
  mailbox #(Transaction) mon_in_h,mon_out_h;
  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      mon_in_h.get(trans_h);
      add_input(trans_h);
    end
  endtask


  function void add_input(Transaction trans);
    expect_a[trans.addr] = trans.data_in;
  endfunction

  virtual task check(int n);
    repeat(n) begin
      Transaction trans_h;
      mon_out_h.get(trans_h);
      check_output(trans_h);
    end
  endtask

  function void check_output(Transaction trans_h);

    //$display("%m %p",expect_a);
    if(trans_h.data_in != expect_a[trans_h.addr])
      $error("Mismatch found @addr : %0d expected : %0d actual : %0d",trans_h.addr,expect_a[trans_h.addr],trans_h.data_in);
    else
      $display("@ location %0d value = %0d",trans_h.addr,trans_h.data_in);
  endfunction
endclass
