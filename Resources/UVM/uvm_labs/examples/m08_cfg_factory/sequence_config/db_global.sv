/*
 Compile and run in Questa (2020.x or later) with:
 qrun -quiet db_global.sv +UVM_TESTNAME=db_global_test +UVM_CONFIG_DB_TRACE

 INTRODUCTION: The uvm_config_db works well for passing values from
 the test down to components such as environments, agents, etc. This
 is because the first argument to set() and get() is a uvm_component
 handle. However, sequences are not components.

 1. This example makes uvm_config_db entries that are "global", that
 is they are outside the "uvm_test_top" testbench hierarchy.  The test
 class build_phase() calls:

 uvm_config_db#(my_config)::set(null, "DB_GLOBAL", "my_cfg", my_cfg);

 while the sequence body() calls:

 uvm_config_db#(my_config)::get(null, "DB_GLOBAL", "my_cfg", my_cfg);

 This works for ONE configuration object. Stop reading these comments and jump to the code!


 2. What if you have multiple instances of a sequence and each needs
 to be configured differently?  The classic approach is to configure
 based on the sequencer. The test class build_phase() calls:

 uvm_config_db#(my_config)::set(this, "env.agt*", "my_cfg", my_cfg);

 while the sequence body() calls:

 uvm_config_db#(my_config)::get(get_sequencer(), "", "my_cfg", my_cfg);


 3. If multiple instances of one sequences connect to one sequencer,
 that doesn't work. In that case, give every sequence a unique
 instance name in create().

 function void test::build_phase();
   my_cfg0 = my_config::type_id::create("my_cfg0");
   seq0 = my_sequence::type_id::create("seq0");
   my_cfg1 = my_config::type_id::create("my_cfg1");
   seq1 = my_sequence::type_id::create("seq1");

   uvm_config_db#(my_config)::set(null, "DB_GLOBAL", "my_cfg0", my_cfg0);
   uvm_config_db#(my_config)::set(null, "DB_GLOBAL", "my_cfg1", my_cfg1);
 endfunction


 task sequence::body();
   uvm_config_db#(my_config)::set(null, "DB_GLOBAL", get_full_name(), my_cfg);
   // Create sequence items
 endtask

  Also shows uvm_config_db tracing.

 */

module db_global;

  import uvm_pkg::*;
`include "uvm_macros.svh"

// Configuration object, created and initialized in the test, read by the sequence
class my_config extends uvm_object;
  `uvm_object_utils(my_config)
  function new(string name="my_config");
    super.new(name);
  endfunction

  int num_xact=1;	// Number of transactions
endclass


// Sequence class that reads configuration and "generates" the specified number of transactions
// There are no transactions in this example, just uvm_info messages
class my_sequence extends uvm_sequence;
  `uvm_object_utils(my_sequence)
  function new(string name="my_sequence");
    super.new(name);
  endfunction

  task body();
    my_config my_cfg;

    // What is my instance name?
    `uvm_info("get_full_name()", get_full_name(), UVM_MEDIUM)

    // Get the handle to the config object from the DB.
    // Its scope is "DB_GLOBAL:", which is at the same level as "uvm_test_top"
    uvm_config_db#(my_config)::get(null, "DB_GLOBAL:", "my_cfg", my_cfg);

    repeat (my_cfg.num_xact) begin
      `uvm_info("BODY", "One more loop", UVM_MEDIUM)
    end
  endtask
endclass

// Test class that creates and initializes a config object,
// and sets in the uvm_config_db
class db_global_test extends uvm_test;
  `uvm_component_utils(db_global_test)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Create, init and set the config object
  virtual function void build_phase(uvm_phase phase);
    my_config my_cfg;
    my_cfg = my_config::type_id::create("my_cfg");
    uvm_config_db#(my_config)::set(null, "DB_GLOBAL:", "my_cfg", my_cfg);
    my_cfg.num_xact = 2;
  endfunction

  // Create and run the sequence
  virtual task run_phase(uvm_phase phase);
    my_sequence seq;
    seq = my_sequence::type_id::create("seq");
    seq.start(null);	// There is no sequencer in this little example
  endtask
endclass

  initial run_test("db_global_test");

endmodule
