// Top of the Design Under Test

module top_hdl();
  timeunit 1ns; timeprecision 1ns;

  import test_params_pkg::*;
  
  ahb_ifc ahb_if();
  ahb_slave_mem #(.ADDR_LO(SLAVE_0_ADDR_LO), 
		  .ADDR_HI(SLAVE_0_ADDR_HI),
		  .ID(0))
  slv_mem0 (ahb_if);

endmodule : top_hdl
