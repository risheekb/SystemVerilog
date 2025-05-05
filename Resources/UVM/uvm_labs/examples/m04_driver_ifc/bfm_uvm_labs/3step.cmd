@ECHO OFF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Script to compile, optimize and run a UVM lab with Questa
:: Only works in the lab* subdirectories because of relative paths in run.f
::
:: Many arguments:
:: %1: the name of the UVM test class
:: %2 %3 %4 %5 %6 %7: run-time switches such as -gui +FORCE_LOAD_ERROR +NUM_ITEMS=10
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Copyright 2023 Siemens
:: All Rights Reserved Worldwide
::
:: CBS 191212 - Added -suppress 8887
:: CBS 180109 - DOS cleanups
:: CBS 171129 - Rename transcript to lab_test_*.log
:: CBS 170714 - Cleaned up
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::

SETLOCAL ENABLEEXTENSIONS
SET me=%~n0
SET parent=%~dp0

:: Check for UVM test name
IF "%1"=="" (
    echo ERROR: No UVM test name specified, try:
    echo  %0 lab_test_write6
    GOTO :EOF
)

:: Delete the work library to make sure a compile error prevents vsim from running
if EXIST work rmdir work /s /q

:: Compile the SystemVerilog code
vlog -f ../run.f
IF %ERRORLEVEL% NEQ 0 (
  echo "vlog exited with errors, exiting"
  GOTO :EOF
)

:: Optimize the dual-top design with debug access
vopt +acc top_hdl top_tb -o top_opt || exit
IF %ERRORLEVEL% NEQ 0 (
  echo "vopt exited with errors, exiting"
  GOTO :EOF
)

:: Simulate the optimized dual-top design with the UVM test name, and other switches
vsim +UVM_TESTNAME=%1 %2 %3 %4 %5 %6 %7 +UVM_NO_RELNOTES -suppress 8887 -c -do "run -all; quit" top_opt

:: Rename transcript to log file with test name
move /y transcript %1.log
