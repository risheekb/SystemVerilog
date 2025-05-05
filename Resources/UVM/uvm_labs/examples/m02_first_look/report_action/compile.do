vlog report_action.sv
vopt +acc report_action -o dbg_do
vsim dbg_do +UVM_TESTNAME=report_action_test \
     +UVM_NO_RELNOTES
