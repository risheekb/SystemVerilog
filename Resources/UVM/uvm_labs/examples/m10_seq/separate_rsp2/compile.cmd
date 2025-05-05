@ECHO OFF
:: Windows DOS script to compile and run the AHB / UVM Configuration example with Questa, no virtual sequences

set testname=%1
IF "%1"=="" ( set testname="ahb_test" )

@rem Clean up old results
rmdir work /s /q

@rem Compile
vlog test_params_pkg.sv ^
     ahb/ahb_pkg.sv ^
     ahb/ahb_test_pkg.sv ^
     ahb/ahb_ifc.sv ^
     ahb/ahb_slave_mem.sv ^
     top_tb.sv ^
     top_hdl.sv

@rem Optimize, +acc for debug
vopt +acc top_tb top_hdl -o opt

@rem Simulate with a timeout
vsim ^
     +UVM_TESTNAME=%testname% ^
     +UVM_NO_RELNOTES ^
     -do "run 10us; quit" ^
     opt
exit
