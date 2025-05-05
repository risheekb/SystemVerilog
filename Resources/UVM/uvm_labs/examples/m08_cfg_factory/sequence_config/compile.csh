#!/bin/csh -f

qrun -quiet \
	-timescale "1ns/1ns" \
	 +define+UVM_REPORT_DISABLE_FILE_LINE \
        +UVM_NO_RELNOTES +UVM_CONFIG_DB_TRACE \
	db_global.sv
