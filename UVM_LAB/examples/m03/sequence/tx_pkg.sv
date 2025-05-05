package tx_pkg;


  `include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef enum {READ,WRITE,CROAK} command_t;

  typedef class tx_item;
  typedef class tx_payload;
  typedef class tx_sequence;
  typedef class tx_driver;
  typedef class tx_agent;
  typedef class seq_item_test;
  `include "tx_item.svh"
  `include "tx_payload.svh"
  `include "tx_sequence.svh"
  `include "tx_driver.svh"
  `include "tx_agent.svh"
  `include "seq_item_test.svh"


endpackage
