#!/bin/csh -f
#----------------------------------------------------------------------
# Unix script to transform the lab solution files into student files
# For use by course developers
#
# Reads the lab solution and removes the code between
#	//BEGIN SOLUTION
#	//END SOLUTION
#----------------------------------------------------------------------
# Copyright 2017-2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 210701 - Update for Siemens
# CBS 170714 - Cleanups
#----------------------------------------------------------------------

# Check the current director
if ( $PWD:t != "uvm_labs") then
    echo ERROR: $0 must be run from the uvm_labs directory
    exit
endif


# Look through the solution directory, and generate new student files
# Source:	lab_solution/lab00_foo_solution.svh
# Student:	lab00*/lab00_foo.svh

set src_dir = "lab_solution"
foreach src (${src_dir}/lab0*.svh)
    set src_file = $src:t
    set dst_name = `echo $src_file | sed 's/_solution//'`
    set dst_dir_pre  = `echo $src_file | sed 's/_\w*.svh//g'`
    set dst_dir = `\ls -d ${dst_dir_pre}*`
    set dst = ${dst_dir}/${dst_name}

    echo "${src_dir}/$src_file 	${dst}"
    ./bin/lab_filter.pl < ${src} > ${dst}
end

# An original package is kept in the solution directory
cp lab_testbench/lab_package_start.sv lab_testbench/lab_package.sv
