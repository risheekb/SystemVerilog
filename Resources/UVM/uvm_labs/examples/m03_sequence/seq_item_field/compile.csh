#!/bin/csh -f
# Unix script to compile an example of a UVM sequence item with do_*() methods.
# Runs in batch, not with the GUI

# Find the QuestaSIM installation
set q = `which qrun`
if ($status == 1) then
    echo "qrun not found, check your installation"
    exit
endif
setenv Q_HOME $q:h:h

qrun tx_pkg.sv seq_item.sv \
	-quiet \
	+incdir+${Q_HOME}/verilog_src/uvm-1.1d/src \
	+define+UVM_NO_DEPRECATED \
	+UVM_NO_RELNOTES
