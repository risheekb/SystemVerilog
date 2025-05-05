# Questa script to compile dual-top example from module 2

vlog instr_reg.sv

vlog tx_pkg.sv \
     +define+UVM_REPORT_DISABLE_FILE_LINE

vlog top_tb.sv \
     +define+UVM_REPORT_DISABLE_FILE_LINE

vlog tx_ifc.sv

vlog top_hdl_dual.sv

vopt +acc top_tb top_hdl -o dual_dbg_bat
vsim dual_dbg_bat +UVM_TESTNAME=tx_test +UVM_NO_RELNOTES  -classdebug \
     -do "run -all"
