/////////////////////////////////////////////////////////////////////////////
// Basic transaction class
class tx_item extends uvm_sequence_item;
  rand bit [31:0] src, dst; // DUT input: 2-state
  rand command_t cmd;       // DUT input: Enum
  logic [31:0] result;      // DUT output: 4-state
  rand tx_payload pay;    // Handle to a separate object

  `uvm_object_utils(tx_item);
  function new(string name="tx_item");
    super.new(name);
    pay = tx_payload::type_id::create("pay");
  endfunction


  virtual function void do_copy(uvm_object rhs);
    tx_item tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_copy argument")

    super.do_copy(rhs);

    src    = tx_rhs.src;
    dst    = tx_rhs.dst;
    cmd    = tx_rhs.cmd;
    result = tx_rhs.result;
    pay.copy(tx_rhs.pay);
  endfunction


  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    tx_item tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_copy argument")

    return (super.do_compare(rhs, comparer) &&
	    (src    === tx_rhs.src)         &&
	    (dst    === tx_rhs.dst)         &&
	    (cmd    === tx_rhs.cmd)         &&
	    (result === tx_rhs.result)      &&  // 4-state!
	    (pay.compare(tx_rhs.pay, comparer)));
  endfunction


  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s, "%s  tx_item values are:\n", s);
    $sformat(s, "%s  cmd      = %s (0x%0x)\n", s, cmd.name(), cmd);
    $sformat(s, "%s  src,dst  = %0x,%0x\n", s, src, dst);
    $sformat(s, "%s  result   = %0x\n", s, result);
    $sformat(s, "%s  payload  = %s\n",  s, pay ? pay.convert2string() : "null");
    return s;
  endfunction

  virtual function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

  // You might want to put a `uvm_warning() in these, just in case
  virtual function void do_pack(uvm_packer packer);
    `uvm_warning("UNIMPL", {"do_pack not implemented for ", get_type_name()})
  endfunction

  virtual function void do_unpack(uvm_packer packer);
    `uvm_warning("UNIMPL", {"do_unpack not implemented for ", get_type_name()})
  endfunction

  virtual function void do_record(uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name", get_name()); // Returns instance name
    `uvm_record_field("cmd", cmd);
    `uvm_record_field("src", src);
    `uvm_record_field("dst", dst);
    `uvm_record_field("result", result);
    pay.record(recorder);
  endfunction

endclass : tx_item
