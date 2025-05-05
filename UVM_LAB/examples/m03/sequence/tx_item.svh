class tx_item extends uvm_sequence_item;

  rand bit [31:0] src,dst;
  rand command_t cmd;
  logic [31:0] result;
  rand tx_payload pay;

  `uvm_object_utils(tx_item)

  function new(string name = "tx_item");
    super.new(name);
    pay = tx_payload::type_id::create("pay");
  endfunction


  virtual function void do_copy(uvm_object rhs);

    tx_item tx_rhs;
    if(!$cast(tx_rhs,rhs)) `uvm_fatal(get_type_name,"Handle Cast Failed")
    super.do_copy(tx_rhs);
    this.src = tx_rhs.src;
    this.dst = tx_rhs.dst;
    this.cmd = tx_rhs.cmd;
    this.result = tx_rhs.result;
    this.pay.copy(tx_rhs.pay);
  endfunction

  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    tx_item tx_rhs;
    if(!$cast(tx_rhs,rhs)) `uvm_fatal(get_type_name,"Handle Casting Failed")
    return(super.do_compare(tx_rhs,comparer) &&
          (this.src === tx_rhs.src) &&
          (this.dst === tx_rhs.dst) &&
          (this.cmd === tx_rhs.cmd) &&
          (this.result === tx_rhs.result) &&
          (pay.compare(tx_rhs.pay,comparer)));
  endfunction

  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s, "%s  tx_item values are:\n", s);
    $sformat(s,"%s command = %s (0x%0x)\n",s,cmd.name,cmd);
    $sformat(s,"%s src,dst = (%0x %0x)\n",s,src,dst);
    $sformat(s,"%s result = (%0x)\n",s,result);
    $sformat(s,"%s payload = %s",s,pay?pay.convert2string():"null");
    return s;
  endfunction

  virtual function void do_record(uvm_recorder recorder);
    `uvm_record_field("name",get_name());
    `uvm_record_field("src",src);
    `uvm_record_field("dst",dst);
    `uvm_record_field("cmd",cmd);
    `uvm_record_field("result",result);
    pay.record(recorder);
  endfunction

  virtual function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction


endclass
