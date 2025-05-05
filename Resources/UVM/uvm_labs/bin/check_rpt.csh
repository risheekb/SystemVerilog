#!/bin/csh -f
if ("x$1" == "x") then
    set log = "qrun.log"
else
    set log = $1
endif

../../../bin/uvm_filter.pl ${log}
diff ${log}.rpt gold.rpt
if ($status != 0) then
    echo "***ERROR: Example failed, check ${log} file ***"
else
    echo "Test passed in `pwd`"
endif
