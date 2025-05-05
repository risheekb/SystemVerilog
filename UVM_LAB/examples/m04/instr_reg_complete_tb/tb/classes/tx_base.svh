class tx_base extends uvm_sequence_item;
  `uvm_object_utils(tx_base)
  function new(string name = "tx_base");
    super.new(name);
  endfunction

  rand bit reset_n;
  rand bit load_en;
  rand pointer2_t read_pointer;
  rand pointer2_t write_pointer;
  rand opcode_t opcode = ZERO;
  rand operand2_t operand_a;
  rand operand2_t operand_b;
  static pointer2_t last_write_pointer;


  virtual function void do_copy(uvm_object rhs);
    tx_base tx_rhs;
    if(!$cast(tx_rhs,rhs)) `uvm_fatal(get_type_name(),"Illegal RHS Assignment!!")
    super.do_copy(rhs);
    reset_n  = tx_rhs.reset_n;
    load_en  = tx_rhs.load_en;
    read_pointer  = tx_rhs.read_pointer;
    write_pointer  = tx_rhs.write_pointer;
    opcode  = tx_rhs.opcode;
    operand_a  = tx_rhs.operand_a;
    operand_b  = tx_rhs.operand_b;
  endfunction


  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    tx_base tx_rhs;
    if(!$cast(tx_rhs,rhs)) `uvm_fatal(get_type_name(),"Illegal RHS Assignment!!")
    return (super.do_compare(rhs,comparer) &&
           (opcode === tx_rhs.opcode) &&
           (operand_a === tx_rhs.operand_a) &&
           (operand_b === tx_rhs.operand_b) );
  endfunction

  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s, "%s\n lab_tx_base (hex):", s);
    $sformat(s, "%s\n reset_n      = %b, load_en = %b", s, reset_n, load_en);
    $sformat(s, "%s\n read_pointer = %0x, write_pointer = %0x, last_write_pointer = %0x", s, read_pointer, write_pointer, last_write_pointer);
    $sformat(s, "%s\n opcode       = %0x (%s), operand_a, b = %0x, %0x", s, opcode, opcode.name(), operand_a, operand_b);
    return s;
  endfunction

   function void post_randomize();
    read_pointer = last_write_pointer;
    last_write_pointer = write_pointer;
  endfunction

  virtual function void do_record(uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name",get_name())
    `uvm_record_field("resetn",reset_n)
    `uvm_record_field("load_en",load_en)
    `uvm_record_field("read_pointer",read_pointer)
    `uvm_record_field("write_pointer",write_pointer)
    `uvm_record_field("opcode",opcode)
    `uvm_record_field("operand_a",operand_a)
    `uvm_record_field("operand_b",operand_b)
  endfunction

  virtual function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction
endclass
