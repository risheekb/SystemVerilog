
TEST=BaseTest
compile:
	vlog -lint -f run.f

opt: 
	vopt top -o top_opt

sim:
	vsim -c top_opt -do "run -all"
	
qrun:
	qrun -f run.f +testname=$(TEST)

sim-gui: 
	vsim -do +test=$(TEST) "run.do" 
