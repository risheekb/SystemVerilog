#!/usr/bin/perl -w
#----------------------------------------------------------------------
# Perl script to filter UVM log files
# Outputs a report file with just the UVM Report Summary
#----------------------------------------------------------------------
# Chris Spear: 230215: Created
#----------------------------------------------------------------------
#
# Usage:
#	% ./uvm_filter.pl questa.log 
# Creates questa.log.rpt
#

use strict;
use warnings;
use autodie;

my $line = "";		# Input line
my $removed_info = 0;	# Number of UVM_INFO messages removed, to adjust count

my $file = $ARGV[0];
if (!defined $ARGV[0]) {
    $file = "qrun.log";
}

open (my $fh, '<', $file)                        or die "Cannot open file: $!";
open (my $report, '>', sprintf("%s.rpt", $file)) or die "Cannot open file: $!";

# Filter out the UVM header, and Questa-specific messages, end at the first UVM_message
while (get_next_line()) {
    if ($line =~ /Questa UVM/) {
	$removed_info++;
    }
    elsif ($line =~ /\[UVM\/RELNOTES\]/) {
	next;   # UVM 1.2 has [UVM/RELNOTES] before header
    }
    elsif ($line =~ m/^UVM_(INFO)|(WARNING)|(ERROR)|(FATAL)/) {
	last;
    }
}

# Print the the simulation messages
while (get_next_line()) {
    if ($line =~ /--- UVM Report Summary ---/) {
	last;
    }
}

# Print the UVM Report Summary to output and the report file
print_report($line);
for (my $i=0; $i < 2; $i++) {
    get_next_line();
    print_report($line);
}

# Subtract the # of version-specific messages from the UVM_INFO count
get_next_line();
my $info_count = 0;
($info_count) = ($line =~ /(\d+)/);
$line = sprintf("UVM_INFO :    %d\n", $info_count - $removed_info);
print_report($line);

# Print UVM_WARNING, UVM_ERROR, UVM_FATAL count messages and "Report counts by id"
for (my $i=0; $i < 4; $i++) {
    get_next_line();
    print_report($line);
}

# Print the remaining Report counts by [ID]
get_next_line();
while ( $line =~ /^\[/) {
    if ($line =~ /Questa UVM/) {
	get_next_line();
	next;
    }
    elsif ($line =~ /\[UVM\/RELNOTES\]/) {
	get_next_line();
	next;   # UVM 1.2 has [UVM/RELNOTES] count
    }
    if ($line =~ /\[TEST_DONE\]/) {
	get_next_line();
	next; # This is not in the P1800.2 output
    }
    print_report($line);
    get_next_line();
}

close $fh;
close $report;
exit();


##################################################################
# Get the next line, and filter out Questa's "# "
sub get_next_line {
    $line = <$fh>;
    $line = substr($line, 2);
}

##################################################################
# Print to both the filter and report files
sub print_report {
    print $report $_[0];
}
