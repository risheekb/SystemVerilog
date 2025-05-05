#!/bin/csh -f
#----------------------------------------------------------------------
# Unix script to create tar file of course files and release
# For use by course developers
#
# Clean up lab directories and create a tar file
# The tar file name has a date stamp such as 170214
# The tar files is put in .., and a copy in ~/Desktop
#
# Usage:
#   Make tar file with all student and instructor lab files
#	./tar_labs.csh
#----------------------------------------------------------------------
# Copyright 2017-2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 210701 - Update for Siemens
# CBS 170714 - Cleanups
#----------------------------------------------------------------------

# Find out what lab directory we are running in: uvm_labs, svv_labs, etc.
set labs = $PWD:t
set target = `date +"${labs}_%y%m%d.tar"`

if (! -e ./bin/tar_labs.csh) then
    echo "ERROR, run this in the labs directory, above the bin directory"
    exit
endif

echo "Cleaning lab directories and creating tar file for $labs"

./bin/clean.csh quiet

# Use -h to get links to files in ./bin
pushd ..
tar cfh ${target}  ${labs}
popd

echo "Created ../${target}"

# This is a shared director between Linux and Windows (has to be set up)
# Alternative is ~/Destop
set dir = "~/WinLinShare"

# If there is a proper destination directory, put a copy there for drag & drop
if (-d ${dir} ) then
    cp ../${target} ${dir}
    echo "Created ${dir}/${target}"
else
   echo "Error: No ${dir} directory"
endif

echo "Before releasing the labs, run ./bin/run_all_tests.csh, and fix the .version file"
