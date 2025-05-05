#!/bin/csh -f
# Unix script to run all examples in the Siemens examples directory
# Run with no arguments

echo "$0 started with $1"

if (x$1 == "x") then
  # If no arguments, find all the compile scripts
  find . -name compile.csh -exec run_all_tests.csh {} \;
else
  echo
  echo
  echo "------------------------------------------------------------------"
  echo "Running $1"
  pushd $1:h
  ./$1:t
  popd
endif
