compile:
	vlog -lint -f run.f

opt:
	vopt work.top -o top_opt -debug

sim:
	vsim top_opt
	add wave -position insertpoint sim:top/*
	run -all
