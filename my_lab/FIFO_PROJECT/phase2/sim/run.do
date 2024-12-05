# Questa script to compile and run with debug, includes optional plusargs

vlog -f run.f +cover=sbecfx

# Gather the script arguments
quietly set args ""
while {$argc > 0} {
    quietly lappend args $1
    shift
}
if {[llength $args] == 0} {

  #vsim work.top -voptargs=+acc +test=CMD  
   vsim work.top -coverage -voptargs=+acc -qwavedb=+signal+transaction+class+uvm_schematic+wavefile+memory=4096,5  +test=CMD
} else {

  vsim work.top -voptargs=+acc -coverage  {*}$args
}


# Capture waves
#add wave sim:/top/inf/*
run -all

coverage report -assert -binrhs -details -cvg 
coverage save cov.ucdb
quit
