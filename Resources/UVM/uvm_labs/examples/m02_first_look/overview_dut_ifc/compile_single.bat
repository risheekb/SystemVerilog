@rem Windows script to compile single top example from module 2

vlog tx_pkg.sv ^
     +define+UVM_REPORT_DISABLE_FILE_LINE
vlog top.sv ^
     +define+UVM_REPORT_DISABLE_FILE_LINE
vopt +acc top -o top_dbg_bat
vsim top_dbg_bat +UVM_TESTNAME=tx_test +UVM_NO_RELNOTES ^
     -do "run -all"
