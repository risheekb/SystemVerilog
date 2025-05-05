class Transaction;

  address_t addr;
  data_t data_in;


  function void randomize_transaction();
    this.data_in = $urandom_range($random,$random);
  endfunction
  
  function void print_transaction();
    $display("Transaction value %0d",data_in);
  endfunction

  function void copy(Transaction rhs);
    this.addr = rhs.addr;
    this.data_in = rhs.data_in;
  endfunction
endclass
