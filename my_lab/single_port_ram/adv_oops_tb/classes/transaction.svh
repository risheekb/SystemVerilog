class Transaction extends Component;

  address_t addr;
  data_t data_in;


  virtual function void randomize_transaction();
    this.data_in = $urandom_range($random,$random);
  endfunction
  
  virtual function void print_transaction();
    $display("Transaction value %0d",data_in);
  endfunction

  virtual function void copy(Transaction rhs);
    this.addr = rhs.addr;
    this.data_in = rhs.data_in;
  endfunction

  virtual function Transaction clone();
    clone = Transaction::new();
    clone.copy(this);
  endfunction
endclass
