#!/bin/csh -f
# Run all the tests on the lab solutions plus examples
#
# After each test, this script prints the number of expected UVM_INFO,
# UVM_WARNING, and ERROR messages. No FATAL messages are ever expected.
# The number of UVM_INFO sometimes changes by 1, depending on the Questa version.
#
# Also printed are the number of passing and failed transactions,
# and if any error are expected. For Lab 7, there is a switch to
# make the RTL generated an error. This depends on the random stimulus
# so the number of errors might change from release to release.
#

if (! -d lab_solution) then
  echo "Error: $0 must be run from the uvm_labs directory above lab_solution"
  exit
endif

cd lab_solution
make run_all
cd ..

echo "**********************************************************************************"
echo "* Running all examples with Makefiles                                            *"

foreach f (`find examples -name Makefile`)
    echo
    echo "******************************************************************************"
    echo "* Example: $f:h "
    echo "******************************************************************************"
    pushd $f:h > /dev/null
    make check_rpt clean
    popd > /dev/null
end

echo
echo
echo "**********************************************************************************"
echo "* All done                                                                       *"
echo "**********************************************************************************"

exit
