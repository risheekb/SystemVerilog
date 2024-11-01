	vlog -lint -f run.f +ERROR_INJECT

	#vopt +acc work.top -o top_opt

	vsim -voptargs=+acc work.top +testname=BaseTest
	add wave -position insertpoint sim:top/inf/*
	run -all
    #quit -sim
