Example of running two sequences in parallel, one that goes for N
transactions: main_sequence, and one with a forever-loop: noise_sequence.

The issue is how to properly stop the noise sequence, without leaving
anything hanging.

The example currently does not really use the sequencer, as there is
no driver.
