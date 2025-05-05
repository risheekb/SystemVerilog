vlog hello_pkg.sv top.sv
vsim -batch top +UVM_TESTNAME=hello_test +UVM_NO_RELNOTES -do "run -all"
