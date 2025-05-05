class tx_payload extends uvm_sequence_item;


  `uvm_object_utils(tx_payload)
  function new(string name="tx_payload");
    super.new(name);
  endfunction

  rand bit [3:0] data;
  tx_item  tx; //parent transaction

  virtual function void do_copy(uvm_object rhs);
    tx_payload pay_rhs;
    if(!$cast(pay_rhs,rhs)) `uvm_fatal(get_type_name,"Handle casting failed")
    super.do_copy(pay_rhs);
    this.data = pay_rhs.data;
    tx.copy(pay_rhs.tx);
  endfunction

  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    tx_payload pay_rhs;
    if(!$cast(pay_rhs,rhs)) `uvm_fatal(get_type_name,"Handle casting has failed")
    return ( super.do_compare(pay_rhs,comparer) &&
            this.data === pay_rhs.data
    );
  endfunction

  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s,"%s payload data = %0x",s,data);
    return s;
  endfunction

  virtual function void do_record(uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name",get_name)
    `uvm_record_field("payload",data)
  endfunction

  virtual function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction
endclass
