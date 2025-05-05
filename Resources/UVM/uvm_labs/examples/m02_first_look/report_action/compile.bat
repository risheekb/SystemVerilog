vlog report_action.sv
vopt +acc report_action -o dbg_bat
vsim dbg_bat +UVM_TESTNAME=report_action_test ^
     +UVM_NO_RELNOTES ^
     -do "run -all; quit" 
