/////////////////////////////////////////////////////////////////////////////
// A tx_item has a payload. Both classes are sequence items
class tx_payload extends uvm_sequence_item;
  `uvm_object_utils(tx_payload)
  function new(string name="tx_payload");
    super.new(name);
  endfunction

  rand bit [3:0] data;
  tx_item tx; // "parent" transaction

  virtual function void do_copy(uvm_object rhs);
    tx_payload tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_copy argument")
    super.do_copy(rhs);
    data = tx_rhs.data;
    tx.copy(tx_rhs.tx);
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

  // Record properties for transaction debug
  virtual function void do_record(uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name", get_name()); // Returns instance name
    `uvm_record_field("data", data);
  endfunction

  virtual function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

  virtual function void do_pack(uvm_packer packer);
    `uvm_warning("UNIMPL", {"do_pack not implemented for ", get_type_name()})
  endfunction

  virtual function void do_unpack(uvm_packer packer);
    `uvm_warning("UNIMPL", {"do_unpack not implemented for ", get_type_name()})
  endfunction

endclass : tx_payload
