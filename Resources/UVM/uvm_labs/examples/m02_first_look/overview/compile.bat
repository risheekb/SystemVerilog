vlog tx_ifc.sv
vlog dut.sv
vlog tx_pkg.sv
vlog top_tb.sv
vlog top_hdl.sv
vopt top_tb top_hdl +acc -o top_opt
vsim top_opt +UVM_TESTNAME=tx_test -do "run -all"
