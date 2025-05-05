/////////////////////////////////////////////////////////////////////////////
// Basic transaction class
class tx_item extends uvm_sequence_item;
  rand bit [31:0] src, dst; // DUT input: 2-state
  rand command_t cmd;       // DUT input: Enum
  logic [31:0] result;      // DUT output: 4-state
  rand tx_payload pay;      // Handle to a separate object

  `uvm_object_utils_begin(tx_item)
    `uvm_field_int(src, UVM_ALL_ON)
    `uvm_field_int(dst, UVM_ALL_ON)
    `uvm_field_enum(command_t, cmd, UVM_ALL_ON)
    `uvm_field_int(result, UVM_ALL_ON)
    `uvm_field_object(pay, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="tx_item");
    super.new(name);
    pay = tx_payload::type_id::create("pay");
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

  // Print transactions with convert2string()
  virtual function void do_print(input uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

endclass : tx_item
