vlog -lint axi_pkg.sv axi_inf.sv axi_memory.sv axi_assertion.sv top.sv
#vsim work.top -voptargs=+acc +testname=test_5_wr_5_rd
vsim work.top -voptargs=+acc +testname=test_wrap_wr_rd
do wave.do
run -all
