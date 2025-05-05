UVM example of a scoreboard with a built-in evaluator and
predictor. It requires multiple imp exports.

*** The sequence item class, alu_txn_p, is parameterized, and then a
specialized type is defined with a typedef, alu_txn. Once you create
that type, you can use it in the rest of the testbench and ignore the
parameter. 

This expands the code in the Siemens UVM Basics course, module 7

Includes scripts to compile and run on Unix, Windows, and in Questa

