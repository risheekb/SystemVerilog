/////////////////////////////////////////////////////////////////////////////
// A tx_item has a payload. Both classes are sequence items
class tx_payload extends uvm_sequence_item;
  rand bit [3:0] data;
  `uvm_object_utils_begin(tx_payload)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="tx_payload");
    super.new(name);
  endfunction


  virtual function void do_copy(uvm_object rhs);
    tx_payload tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_copy argument")
    super.do_copy(rhs);
    data = tx_rhs.data;
  endfunction

  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    tx_payload tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_copy argument")
    do_compare = (super.do_compare(rhs, comparer) &&
		  data === tx_rhs.data);
  endfunction

  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s, "%s tx_payload: data = %0x\n", s, data);
    return s;
  endfunction

  // Print transactions with convert2string()
  virtual function void do_print(input uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

endclass : tx_payload
