#set time variable
set milliseconds [clock clicks]
variable time [format "%s" [clock format [clock seconds] -format %y%m%d_%H%M%S]]
set log_f $time
vlog  +incdir+../../dma_axi64 +incdir+../TOP +incdir+../AXI +incdir+../APB +incdir+../REG +incdir+../PERIPH +incdir+../REF ../TOP/top.sv -l $log_f
vsim -voptargs=+acc work.top +test_name=test_ch0_sanity -l $log_f
do wave.do
run -all
