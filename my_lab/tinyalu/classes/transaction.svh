class Transaction;
  operand_t A;
  operand_t B;
  opcode_t opcode;
  result_t result;

  function void randomize_transaction();
    A = $random;
    B = $random;
    opcode = opcode_t'($urandom_range(0,7));
  endfunction
  function void print_transaction();
  endfunction
endclass
