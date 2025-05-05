package tb_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import instr_reg_pkg::*;

  typedef class tx_base;
  typedef class tx_in;
  typedef class tx_out;
  typedef class seq_reset;
  typedef class seq_write6;
  typedef class seq_writeN;
  typedef class tx_driver;
  typedef class tx_monitor;
  typedef class tx_agent;
  typedef class tx_scoreboard;
  typedef class tb_env;
  typedef class test_reset;
  typedef class test_write6;
  typedef class agent_config;
  typedef class env_config;
  typedef class coverage_collector;
  `include "classes/tx_base.svh"
  `include "classes/tx_in.svh"
  `include "classes/tx_out.svh"
  `include "classes/seq_reset.svh"
  `include "classes/seq_write6.svh"
  `include "classes/tx_driver.svh"
  `include "classes/tx_monitor.svh"
  `include "classes/tx_agent.svh"
  `include "classes/tx_scoreboard.svh"
  `include "classes/tb_env.svh"
  `include "classes/test_reset.svh"
  `include "classes/test_write6.svh"
  `include "classes/test_configuration.svh"
  `include "classes/seq_writeN.svh"
  `include "classes/env_config.svh"
  `include "classes/agent_config.svh"
  `include "classes/coverage_collector.svh"

endpackage
