class OneZero extends Transaction;

  virtual function void randomize_transaction();
    static bit flag;
    super.randomize_transaction();
    if(!flag) begin
      this.data_in = '0;
      flag = ~flag;
    end
    else begin
      data_in = '1;
      flag = ~flag;
    end
  endfunction

  virtual function void print_transaction();
    $display("%m addr = %0h data_in = %0h",this.addr,this.data_in);
  endfunction

  virtual function OneZero clone();
    clone = OneZero::new();
    clone.copy(this);
  endfunction


endclass
