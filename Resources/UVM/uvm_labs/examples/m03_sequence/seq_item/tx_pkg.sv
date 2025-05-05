package tx_pkg;
`include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef enum {READ, WRITE, CROAK} command_t;

  typedef class tx_payload;	// There is a circular reference 
  typedef class tx_item;	// between these two classes

`include "tx_payload.svh"
`include "tx_item.svh"
`include "tx_sequence.svh"
`include "tx_driver.svh"
`include "tx_agent.svh"
`include "seq_item_test.svh"

endpackage
