#!/bin/csh -f

qrun -quiet \
	+define+UVM_REPORT_DISABLE_FILE_LINE \
	noise_pkg.sv \
	top_hvl.sv 
