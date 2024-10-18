class Scoreboard extends Component;
  data_t expect_a[address_t];
  function void add_input(Transaction trans);
    expect_a[trans.addr] = trans.data_in;
  endfunction

  function void check_output(data_t data,address_t addr);

    //$display("%m %p",expect_a);
    if(data != expect_a[addr])
      $error("Mismatch found @addr : %0d expected : %0d actual : %0d",addr,expect_a[addr],data);
    else
      $display("@ location %0d value = %0d",addr,data);
  endfunction
endclass
