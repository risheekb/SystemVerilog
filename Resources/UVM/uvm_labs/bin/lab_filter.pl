#!/usr/bin/perl -w
#----------------------------------------------------------------------
# Perl script for UVM lab files
# Remove solution code from a solution file, to create a student file
# For use by course developers
#----------------------------------------------------------------------
# Copyright 2017-2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 210701 - Update for Siemens
# CBS 170714 - Cleanups
#----------------------------------------------------------------------
#
# Solution code is surrounded by:
#	//BEGIN SOLUTION
#	remove this
#	//END SOLUTION

use strict;
use warnings;
use autodie;

my $state = "PASS";

# Look for starting expression
while ( <> ) {  # <> reads from STDIN
#    print STDERR "$state $_";
    if ( $state eq "PASS") {
	if (m/BEGIN SOLUTION/) {
	    $state = "BLOCK";
	}
	else {
	    print $_;
	}
    } elsif (m/END SOLUTION/) {
	$state = "PASS";
    }
} # while
