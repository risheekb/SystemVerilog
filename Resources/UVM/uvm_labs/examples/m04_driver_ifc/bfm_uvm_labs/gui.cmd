@ECHO OFF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Windows script to run a UVM example, no compilation, and bring up Questa GUI
:: One argument: the name of the UVM test class
::
:: Many arguments:
:: %1: the name of the UVM test class
:: %2 %3 %4 %5 %6 %7: run-time switches such as -gui +FORCE_LOAD_ERROR +NUM_ITEMS=10
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Copyright 2023 Siemens
:: All Rights Reserved Worldwide
::
:: CBS 191212 - Added -suppress 8887
:: CBS 180720 - Check for work directory
:: CBS 180109 - DOS cleanups
:: CBS 170714 - Cleaned up
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::

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

echo "Running Questa GUI with UVM test %1"

:: Simulate the dual-top design
echo "Running vsim GUI with debug switches: -classdebug -uvmcontrol=all -msgmode both"
vsim ^
	-gui -classdebug -uvmcontrol=all -msgmode both ^
	+UVM_TESTNAME=%1 %2 %3 %4 %5 %6 %7 ^
	+UVM_NO_RELNOTES -suppress 8887 ^
	top_opt

:: Don't create a filtered log file as GUI sessions may not run to the end
