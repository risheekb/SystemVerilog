# Makefile for testing the lab solution files
# Runs simulations, then compares the UVM reports against a gold copy in ./rpt/

# Default - run all tests in regression mode
run_all:
	@make reset write6 force_load_error cfg override vseq

reset:
	../3step.csh lab_test_reset > /dev/null
	@../bin/rpt_diff.csh lab_test_reset.log

write6:
	../rerun.csh lab_test_write6 > /dev/null
	@../bin/rpt_diff.csh lab_test_write6.log

# Lab 7
force_load_error:
	../rerun.csh lab_test_write6 +FORCE_LOAD_ERROR > /dev/null
	mv lab_test_write6.log lab_test_write6_error.log
	@../bin/rpt_diff.csh lab_test_write6_error.log

# Lab 8 - part 1
cfg:
	../rerun.csh lab_test_configuration +uvm_set_config_int=uvm_test_top,count,200 > /dev/null
	mv lab_test_configuration.log lab_test_configuration_200.log
	@../bin/rpt_diff.csh lab_test_configuration_200.log


# Lab 8 - part 2
override:
	../rerun.csh lab_test_override +uvm_set_config_int=uvm_test_top,count,500 > /dev/null
	@../bin/rpt_diff.csh lab_test_override.log

# Lab 9
vseq:
	../rerun.csh lab_test_vseq > /dev/null > /dev/null
	@../bin/rpt_diff.csh lab_test_vseq.log

clean:
	@rm -rf work transcript *.log work *~ *.rpt design.bin
