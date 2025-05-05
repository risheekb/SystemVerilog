package tx_pkg;
`include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef enum {READ, WRITE, CROAK} command_t;

`include "tx_payload.svh"
`include "tx_item.svh"
`include "tx_sequence.svh"
`include "tx_driver.svh"
`include "tx_agent.svh"
`include "seq_item_test.svh"

endpackage
