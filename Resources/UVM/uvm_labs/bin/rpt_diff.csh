#!/bin/csh -f
# rpt_diff.csh
# Filter the UVM log file and compare the report with the gold copy

../bin/uvm_filter.pl $1

echo "diff $1.log.rpt rpt"
diff $1.rpt rpt
