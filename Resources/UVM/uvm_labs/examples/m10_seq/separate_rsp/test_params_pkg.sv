// AHB configuration information shared between design and test

package test_params_pkg;

  // Info on the one slave memory device
  parameter bit [31:0] SLAVE_0_ADDR_LO = 32'h8000;
  parameter bit [31:0] SLAVE_0_ADDR_HI = 32'hFFFF;
  parameter bit [31:0] SLAVE_0_ID      = 0;

endpackage : test_params_pkg
