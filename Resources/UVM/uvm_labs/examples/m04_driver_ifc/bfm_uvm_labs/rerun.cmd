@ECHO OFF
::----------------------------------------------------------------------
:: Windows script to run a UVM lab with Questa (no compile/opt)
:: Only works in the lab* subdirectories because of relative paths in run.f
::
:: Many arguments:
:: %1: the name of the UVM test class
:: %2 %3 %4 %5 %6 %7: run-time switches such as -gui +FORCE_LOAD_ERROR +NUM_ITEMS=10
::----------------------------------------------------------------------
:: Copyright 2023 Siemens
:: All Rights Reserved Worldwide
::
:: CBS 191212 - Added -suppress 8887
:: CBS 180720 - Check for work directory
:: CBS 180109 - DOS cleanups
:: CBS 171129 - Rename transcript to lab_test_*.log
:: CBS 170714 - Cleanups
::----------------------------------------------------------------------

:: Check for UVM test name
IF "%1"=="" (
    echo ERROR: No UVM test name specified, try:
    echo  %0 lab_test_write6
    GOTO :EOF
)

if NOT EXIST work (
    echo ERROR: No work directory found. Recompile with:
    echo  ..\3step.cmd %1
    echo
    GOTO :EOF
)

echo Running simulation with UVM test name %1

:: Simulate the optimized design
vsim +UVM_TESTNAME=%1 %2 %3 %4 %5 %6 %7 +UVM_NO_RELNOTES -suppress 8887 -c -do "run -all" top_opt

:: Rename transcript to log file with test name
move /y transcript %1.log
