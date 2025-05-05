class tx_out extends tx_base;
  `uvm_object_utils(tx_out)

  function new(string name="tx_out");
    super.new(name);
  endfunction

  instruction_t instruction;

  virtual function void do_copy(uvm_object rhs);
    tx_out tx_rhs;
    if(!$cast(tx_rhs,rhs)) `uvm_fatal(get_type_name(),"Illegal RHS Assignment!!")
    super.do_copy(rhs);
    instruction = tx_rhs.instruction;
  endfunction

  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    tx_out tx_rhs;
    if(!$cast(tx_rhs,rhs)) `uvm_fatal(get_type_name(),"Illegal RHS Assignment!!")
    return (super.do_compare(rhs,comparer) &&
           (instruction === tx_rhs.instruction)
    );
  endfunction

 virtual function string convert2string();
    // Generate a string with the properties for this class
    // Do not call super.convert2string() - too much info
    string s;
    $sformat(s, "%s\n lab_tx_out values (hex):", s);
    $sformat(s, "%s\n read_pointer = %0x", s, read_pointer);
    $sformat(s, "%s\n opcode       = %0x (%s), operand_a, b = %0x, %0x",
	     s, instruction.opc, instruction.opc.name(), instruction.op_a, instruction.op_b);
    return s;
  endfunction

  virtual function void do_record(uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name",get_name())
    `uvm_record_field("instruction",instruction)
  endfunction

endclass
