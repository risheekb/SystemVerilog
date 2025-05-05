This directory contains scripts used by the course developers. There
are two main catagories.

BUILD AND RELEASE:

- build_labs_from_solution.csh - Takes the files in the lab_solution
  directory, strips out the solution code, and puts the result into
  the labNN directories as the start for each lab

- lab_filter.pl - removes the solution code from SV code, for the
  above script

- clean.csh - deletes the Questa and Visualizer output files from the
  labs and the examples

- tar_labs.csh - Cleans, then makes a tar file with date stamp of the
  uvm_labs directory, copies it one level up and in ~/WinLinShare/


RUN REGRESSIONS

- run_all_tests.csh - Looks for Makefiles in the examples, and runs
  check_rpt to see if the example passes or fails the default test

- uvm_filter.pl - Creates a .rpt file from a UVM log file with the
  "UVM Report Summary" lines. Removes the Questa- and UVM- specific
  UVM_INFO messages, so this report can be diff'ed against a gold.rpt

- check_rpt.csh - Runs the above filter and diff's against gold.rpt

- rpt_diff.csh - Script for the lab_solution files

- check_log.csh - obsolete


Nothing interesting for the the students, unless you want to see how
to clean up after a sloppy Emacs / Questa csh / Perl user.
