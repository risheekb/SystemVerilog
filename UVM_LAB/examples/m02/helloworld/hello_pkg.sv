package hello;
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  class helloworld extends uvm_test;
    `uvm_component_utils(helloworld)

    function new(string name,uvm_component parent);
      super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
      `uvm_info(get_type_name(),"Hello World !!",UVM_LOW)
    endtask
    
  endclass


endpackage











