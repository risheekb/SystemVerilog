# Questa script to compile and run the scoreboard example

vlog test_params_pkg.sv \
     ahb/ahb_pkg.sv \
     ahb/ahb_test_pkg.sv \
     ahb/ahb_ifc.sv \
     ahb/ahb_slave_mem.sv \
     top_tb.sv \
     top_hdl.sv

vopt +acc top_tb top_hdl -o opt

vsim \
     +UVM_TESTNAME=ahb_test_wr_rd \
     +UVM_NO_RELNOTES \
     -do "run 10us; quit" \
     opt

# Run with timeout
run 10us