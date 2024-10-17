	vlog -lint -f run.f

	vopt +acc work.top -o top_opt

	vsim top_opt
	add wave -position insertpoint sim:top/*
	run -all
    #quit -sim
