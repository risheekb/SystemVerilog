package axi_pkg;
  typedef enum bit[1:0]{
    NORMAL,
    EXCLUSIVE,
    LOCKED,
    LOCK_RSVD
  }lock_t;
  typedef enum bit{
    READ,
    WRITE} wr_rd_t;

  typedef enum bit [2:0]{
    BURST_SIZE_1_BYTE,
    BURST_SIZE_2_BYTE,
    BURST_SIZE_4_BYTE,
    BURST_SIZE_8_BYTE,
    BURST_SIZE_16_BYTE,
    BURST_SIZE_32_BYTE,
    BURST_SIZE_64_BYTE,
    BURST_SIZE_128_BYTE
  } burst_size_t;

  typedef enum bit [1:0]{
    FIXED,
    INCR,
    WRAP,
    BURST_RSVD
  } burst_t;


  typedef enum bit[1:0] {
    OKAY,
    EXOKAY,
    SLVERR,
    DECERR
  } resp_t;

  typedef class axi_env;
  typedef class axi_gen;
  typedef class axi_mon;
  typedef class axi_bfm;
  typedef class axi_scb;
  typedef class axi_cov;
  typedef class axi_common;
  typedef class axi_tx;

  `include "classes/axi_common.sv"
  `include "classes/axi_tx.svh"
  `include "classes/axi_env.svh"
  `include "classes/axi_gen.svh"
  `include "classes/axi_mon.svh"
  `include "classes/axi_bfm.svh"
  `include "classes/axi_scb.svh"
  `include "classes/axi_cov.svh"
endpackage
