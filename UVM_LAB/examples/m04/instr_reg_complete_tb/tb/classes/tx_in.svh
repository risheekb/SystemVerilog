class tx_in extends tx_base;
  `uvm_object_utils(tx_in)
  function new(string name="tx_in");
    super.new(name);
  endfunction

  constraint c_reset {soft reset_n == 1'b1; }
  constraint c_load_en {soft load_en == 1'b1;}
  constraint c_opa {soft operand_a inside{[30:100]};}
  constraint c_opb {soft operand_b inside{[0:25]};}
endclass
