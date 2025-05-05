#!/bin/csh -f
# Script to look for messages in the log file

if ("$1" == "") then
    echo "Error: First argument to this script is a file name"
    exit
endif

set file = $1
if (! -f $file) then
    echo "Error: No such file $file"
    exit
endif
shift

loop:
if ("$1" == "") exit
if ("$2" == "") then
    echo "Error: Arguments to this script are pairs of strings and expected-counts"
    exit
endif

set string = $1
set expect = $2
shift; shift
echo ">> grep $string $file | wc -l"

set found = `grep $string $file | wc -l`
# echo "Count=$expect, found=$found"
if ($expect == $found) then
    echo "Success: found $found '$string' in $file"
else
    echo "Error: found $found '$string' in $file, but expecting $expect"
endif

goto loop
