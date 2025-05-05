package tx_pkg;
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef class tx_item;
  typedef class tx_sequence;
  typedef class tx_driver;
  typedef class tx_monitor;
  typedef class tx_agent_config;
  typedef class tx_agent;
  typedef class tx_env_config;
  typedef class tx_env;
  typedef class tx_test;
  
  `include "tx_item.svh"
  `include "tx_sequence.svh"
  `include "tx_driver.svh"
  `include "tx_monitor.svh"
  `include "tx_agent_config.svh"
  `include "tx_agent.svh"
  `include "tx_env_config.svh"
  `include "tx_env.svh"
  `include "tx_test.svh"

endpackage
