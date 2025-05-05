/***********************************************************************
 * SystemVerilog RTL model of an instruction memory
 *
 * Inject an error in the design by simulating with:
 *    % vsim +FORCE_LOAD_ERROR ...
 **********************************************************************/

module instr_reg
  import instr_reg_pkg::*;
  (input  logic         clk, load_en, reset_n,
   input  operand4_t    operand_a, operand_b,
   input  opcode_t      opcode,
   input  pointer4_t    write_pointer,		// Where to write input values
   input  pointer4_t    read_pointer,		// Where to read output values
   output instruction_t instruction_word,	// Output data
   output logic         valid			// Only set if the output is a valid entry
  );

  timeunit 1ns; timeprecision 1ns;

  instruction_t  reg_array [MEMORY_SIZE];	// An array of instruction structures
  logic          ivalid[MEMORY_SIZE];		// Does this location contain a valid instruction value?

  bit force_load_error;

  always@(posedge clk, negedge reset_n) begin	// Write into register
    if (!reset_n) begin
      foreach (reg_array[i]) begin
        reg_array[i] = '{opc:ZERO,default:0};	// Reset all entries to all zeros
	ivalid[i] = 0;				// Clear all valid bits
      end
    end
    else if (load_en) begin
      ivalid[write_pointer] = 1;		// Now this entry is valid
      reg_array[write_pointer].opc  = opcode;	// Store the opcode
      reg_array[write_pointer].op_a = operand_a; // Store OpA

      if (force_load_error)			// Should we inject a bug for scoreboard testing?
         reg_array[write_pointer].op_b = operand_a; // Yes - DESIGN BUG!
      else
         reg_array[write_pointer].op_b = operand_b; // Default correct functionality
    end
  end

  assign instruction_word = reg_array[read_pointer];  // Continuously read from register
  assign valid            = ivalid[read_pointer];	// and tell the world if this is valid or junk


  initial begin
    if ($test$plusargs("FORCE_LOAD_ERROR")) begin
      // Control simulation with plus-args
      // When you run with:
      //    % vsim +FORCE_LOAD_ERROR ...
      // the design code injects a bug, to make sure your testbench really works
      force_load_error = 1;
      $display("\n**************************************************");
      $display("FORCING DESIGN ERRORS BECAUSE OF +FORCE_LOAD_ERROR");
      $display("**************************************************\n");
    end
    else begin
`ifdef FORCE_LOAD_ERROR
      // Legacy code for conditional compilation
      // Less eleganthan controlling simulation with a command line switch
      force_load_error = 1;
      $display("\n*********************************************************");
      $display("FORCING DESIGN ERRORS BECAUSE OF +define+FORCE_LOAD_ERROR");
      $display("*********************************************************\n");
`else
      force_load_error = 0;
`endif
    end
  end

//  instruction_t  test_reg;  // not used in this model -- used for testing UVM register layer
//  assign test_reg = reg_array[read_pointer];

endmodule: instr_reg
