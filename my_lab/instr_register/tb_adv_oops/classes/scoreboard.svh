class Scoreboard extends Component;
  instruction_t expect_a[index_t];

  function void add_input(Transaction trans_h);
    expect_a[trans_h.index] = '{trans_h.opcode,trans_h.operand_a,trans_h.operand_b};
    //$display("%m :: %p",expect_a);
  endfunction

  function void check_output(instruction_t instr_word,index_t read_index);

    //$display("%m :: expect_a %p instr_word %p read_index %p ",expect_a,instr_word,read_index);
      $display("%0t %m index = %0d opcode = %s operand_a = %0d operand_b = %0d",$realtime,read_index,instr_word.opc,instr_word.op_a,instr_word.op_b);
    if(instr_word != expect_a[read_index])
      $error("@%0t %0m Insertion Mismatch Expected : %p Actual : %p",$realtime,expect_a[read_index],instr_word);
  endfunction
endclass
