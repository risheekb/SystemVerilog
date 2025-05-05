compile:
	vlib work
	vlog -lint -f run.f

opt:
	vopt work.top -o top_opt -debug

sim:
	vsim -do run.do 
clean:
	rm -f qrun.log vsim.wlf
	rm -rf qrun.out transcript work

