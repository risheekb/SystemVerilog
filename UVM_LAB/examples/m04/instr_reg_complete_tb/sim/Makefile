compile:
	vlog -f ../run.f 

opt: compile
	vopt top_tb top_hdl +acc -o top_opt

sim_reset: opt
	vsim -suppress 8887 -c top_opt +UVM_TESTNAME=test_reset -do "run -all"

sim_write6: opt
	vsim -suppress 8887 -c top_opt +UVM_TESTNAME=test_write6 -do "run -all"

sim_writeN: opt
	vsim -suppress 8887 -c top_opt +UVM_TESTNAME=test_configuration +uvm_set_config_int=uvm_test_top,nitems,30 -do "run -all"
run_reset: sim_reset
run_write6: sim_write6
run_writeN: sim_writeN
