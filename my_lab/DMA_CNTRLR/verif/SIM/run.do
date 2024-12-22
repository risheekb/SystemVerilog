vlog +incdir+../../dma_axi64 +incdir+../TOP +incdir+../AXI +incdir+../APB +incdir+../PERIPH +incdir+../REF ../TOP/top.sv
vsim -voptargs=+acc work.top +test_name=test_ch0_sanity
do wave.do
run -all
