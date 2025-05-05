
TEST?=All

.PHONY: help
help:
	@echo "Makefile Help:"
	@echo "----------------"
	@echo "Targets:"
	@echo "  post_sim      - There are five testcases BaseTest,FullTest,EmptyTest,ClearTest,OneTest,InvalidTest,All"
	@echo "  For example post_sim TEST=BaseTest"
	@echo "  waveform      - Opens the Visualizer to view waveforms after the post_sim cmd"
	@echo "  coverage      - Opens the Visualizer to view coverage"
	@echo "  clean        -Remove intermediate and generated files"
	@echo "Use 'make <target>' to run a target."
	@echo "For example: 'make clean' or 'make coverage'"

 

post_sim:
	@sed -i.bak "s/CMD/$(TEST)/g" run.do
	vsim -c -do run.do
	@mv run.do.bak run.do

waveform:
	visualizer qwave.db
	
coverage: 
	visualizer -viewcov cov.ucdb

clean:
	@rm -f etch*
	@rm -f wlf*
	@rm -f *.log
	@rm -rf *.out
	@rm -rf *.config
	@rm -rf *.mti
	@rm -rf *.wlf
	@rm -rf *.vstf
	@rm -rf transcript work
