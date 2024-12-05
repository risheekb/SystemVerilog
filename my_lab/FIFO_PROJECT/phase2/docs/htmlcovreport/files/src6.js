var g_data = {"name":"../rtl/classes/transaction.svh","src":"class Transaction extends Component;\n  \n  rand data_t data;\n  logic [$clog2(DEPTH)-1:0] index;\n\n\n  virtual function void print_transaction;\n    $display(\"location = %0d data = %0h\",index,data);\n  endfunction\n\n\n  virtual function void copy(Transaction rhs);\n    this.data = rhs.data;\n    this.index = rhs.index;\n  endfunction\n\n  virtual function Transaction clone();\n    clone = Transaction::new();\n    clone.copy(this);\n  endfunction\nendclass\n","lang":"verilog"};
processSrcData(g_data);