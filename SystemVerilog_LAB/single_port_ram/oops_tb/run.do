vlog -f run.f
vopt +acc top -o top_opt
vsim top_opt
#capture waves
add wave sim:/top/DUT/*

run -all
