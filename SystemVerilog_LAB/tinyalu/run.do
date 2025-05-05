	vlog -lint -f run.f 

	#vopt +acc work.top -o top_opt

	vsim -voptargs=+acc work.top +testname=BaseTest
	add wave -position insertpoint sim:top/inf/*
	run -all
    #quit -sim
