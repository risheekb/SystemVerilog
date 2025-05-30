***********************************************************
LAB :: Overview
***********************************************************
DESIGN UNDER TEST (DUT) : A Bus Protocol module 

	*) The bus_protocol.v module
	  - Drives dValid, data and dAck signals
	  - for a simple bus protocol as shown in LAB Handout. 

LAB Objectives: 
	1) Modeling temporal domain assertions for bus interface type logic. 
	2) Reinforce understanding of Edge sensitive sampled value functions, consecutive repetition,
	   boolean expressions, etc.

***********************************************************
LAB :: Database 
***********************************************************
FILES:
	bus_protocol.v :: bus_protocol module that drive a simple bus protocol 
	bus_protocol_property.sv :: SVA file for bus_protocol assertions. 
		Note that this file is only an empty module shell.
		You will add properties that meet the specification described above.

	test_bus_protocol.sv :: Testbench for the bus_protocol module.
		Note the use of 'bind' in this testbench.

***********************************************************
LAB :: What you will do... 
***********************************************************
	Code assertions to check for the following conditions in the 'bus_protocol' design.
	Code these assertions in the file "bus_protocol_property.sv"

	ASSERTIONS TO CODE
	==================

	CHECK # 1. Check that once dValid goes high that it is consecutively 
	   asserted (high) for minimum 2 and maximum 4 clocks

	CHECK # 2. Check that data remains stable and not unknown
           whenever dValid is asserted (high).

	CHECK # 3. Check that 'dAck' rises only before the last data phase.
	   In other words, 'dValid' must fall the clock after 'dAck' rises.
	   Note that this check must work correct with CHECK # 1 (i.e., since
	   dValid must remain asserted for at least 2 clocks after it's rising 
	   edge, dAck cannot rise for at least 1 clock after dValid rises. Rest
	   of the specs are for you to correctly extrapolate from the timing
	   diagram provided).

***********************************************************
LAB :: How To compile/simulate (for Aldec's Riviera-PRO simulator).
***********************************************************

       Follow the steps below to add your assertion for each check.

       Then compile/simulate with your assertion and see that
       your results match with those stored in the ./.solution directory

       Here's step by step instructions...

1.      % cd <myDir>/SVA_LAB/LAB5
        % vi bus_protocol_property.sv

                Edit this file to add your properties.

                Note that DUMMY properties are coded in bus_protocol_property.sv to
                simply allow the module to compile.

                You must remove the DUMMY properties and code correct properties
                as required above.

2.      First run the design without any bugs introduced in it.
        % run_nobugs
        - This will create the file test_bus_protocol_nobugs.log
        - Study this log to familiarize yourself with how the bus_protocol works.

    The remaining flow of the exericise is such that when you run any of the following scripts,
    a specific bug is introduced in the design that your assertion should catch.

3.      % vi bus_protocol_property.sv
        - Look for `ifdef check1
        - Remove the 'DUMMY' property and code your property as specified above for CHECK #1 
        - Save the file and run the following simulation.

        % run_check1
        - If you have coded the property correct, you should see a failure for the
          CHECK #1 specified above.
        - Simulation will create test_bus_protocol_check1.log
        - Compare test_bus_protocol_check1.log with .solution/test_bus_protocol_check1.log and see
          if your results match with the log in the .solution directory.
        - If your results don't match, revisit your property and repeat step 3.

4.      % vi bus_protocol_property.sv
        - Look for `ifdef check2
        - Remove the 'DUMMY' property and code your property as specified above for CHECK #2
        - Save the file and run the following simulation.

        % run_check2
        - If you have coded the property correct, you should see a failure for the
          CHECK #2 specified above.
        - Simulation will create test_bus_protocol_check2.log
        - Compare test_bus_protocol_check2.log with .solution/test_bus_protocol_check2.log and see
          if your results match with the log in the .solution directory.
        - If your results don't match, revisit your property and repeat step 4.

5.      % vi bus_protocol_property.sv
        - Look for `ifdef check3
        - Remove the 'DUMMY' property and code your property as specified above for CHECK #3
        - Save the file and run the following simulation.

        % run_check3
        - If you have coded the property correct, you should see a failure for the
          CHECK #3 specified above.
        - Simulation will create test_bus_protocol_check3.log
        - Compare test_bus_protocol_check3.log with .solution/test_bus_protocol_check3.log and see
          if your results match with the log in the .solution directory.
        - If your results don't match, revisit your property and repeat step 5.

6. 	This step is to simply run the design with ALL the bugs introduced and all the
	assertions fired.     

        % run_checkall
        - If you have coded all your properties correct, you should see all of the failures
 	  specifically to learn how more than one design bug could be present at a given time. 

        - Simulation will create test_bus_protocol_checkall.log
        - Compare test_bus_protocol_checkall.log with .solution/test_bus_protocol_checkall.log and see
          if your results match with the log in the .solution directory.
        - If your results don't match, one of your steps 3 or 4 or 5 did not complete correct. 
