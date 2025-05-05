# Questa script to compile and run with debug, includes optional plusargs

# Gather the script arguments
quietly set args ""
while {$argc > 0} {
    quietly lappend args $1
    shift
}

vlog -f run.f
vopt +acc top -o top_opt
vsim top_opt {*}$args

# Capture waves
add wave sim:/top/inf/*

run -all
