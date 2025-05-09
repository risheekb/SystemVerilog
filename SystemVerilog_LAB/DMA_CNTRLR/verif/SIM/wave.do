onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group APB_INTF /top/apb_pif/clk
add wave -noupdate -group APB_INTF /top/apb_pif/reset
add wave -noupdate -group APB_INTF /top/apb_pif/pclken
add wave -noupdate -group APB_INTF /top/apb_pif/psel
add wave -noupdate -group APB_INTF /top/apb_pif/penable
add wave -noupdate -group APB_INTF /top/apb_pif/paddr
add wave -noupdate -group APB_INTF /top/apb_pif/pwrite
add wave -noupdate -group APB_INTF /top/apb_pif/pwdata
add wave -noupdate -group APB_INTF /top/apb_pif/prdata
add wave -noupdate -group APB_INTF /top/apb_pif/pslverr
add wave -noupdate -group APB_INTF /top/apb_pif/pready
add wave -noupdate -group APB_INTF /top/apb_pif/scan_en
add wave -noupdate -group APB_INTF /top/apb_pif/INT
add wave -noupdate -group APB_INTF /top/apb_pif/idle
add wave -noupdate -group PERIPH_INTF /top/periph_pif/clk
add wave -noupdate -group PERIPH_INTF /top/periph_pif/reset
add wave -noupdate -group PERIPH_INTF /top/periph_pif/periph_tx_req
add wave -noupdate -group PERIPH_INTF /top/periph_pif/periph_tx_clr
add wave -noupdate -group PERIPH_INTF /top/periph_pif/periph_rx_req
add wave -noupdate -group PERIPH_INTF /top/periph_pif/periph_rx_clr
add wave -noupdate -group DUT /top/dut/clk
add wave -noupdate -group DUT /top/dut/reset
add wave -noupdate -group DUT /top/dut/scan_en
add wave -noupdate -group DUT /top/dut/idle
add wave -noupdate -group DUT /top/dut/INT
add wave -noupdate -group DUT /top/dut/periph_tx_req
add wave -noupdate -group DUT /top/dut/periph_tx_clr
add wave -noupdate -group DUT /top/dut/periph_rx_req
add wave -noupdate -group DUT /top/dut/periph_rx_clr
add wave -noupdate -group DUT /top/dut/pclken
add wave -noupdate -group DUT /top/dut/psel
add wave -noupdate -group DUT /top/dut/penable
add wave -noupdate -group DUT /top/dut/paddr
add wave -noupdate -group DUT /top/dut/pwrite
add wave -noupdate -group DUT /top/dut/pwdata
add wave -noupdate -group DUT /top/dut/prdata
add wave -noupdate -group DUT /top/dut/pslverr
add wave -noupdate -group DUT /top/dut/pready
add wave -noupdate -group DUT /top/dut/AWID0
add wave -noupdate -group DUT /top/dut/AWADDR0
add wave -noupdate -group DUT /top/dut/AWLEN0
add wave -noupdate -group DUT /top/dut/AWSIZE0
add wave -noupdate -group DUT /top/dut/AWVALID0
add wave -noupdate -group DUT /top/dut/AWREADY0
add wave -noupdate -group DUT /top/dut/WID0
add wave -noupdate -group DUT /top/dut/WDATA0
add wave -noupdate -group DUT /top/dut/WSTRB0
add wave -noupdate -group DUT /top/dut/WLAST0
add wave -noupdate -group DUT /top/dut/WVALID0
add wave -noupdate -group DUT /top/dut/WREADY0
add wave -noupdate -group DUT /top/dut/BID0
add wave -noupdate -group DUT /top/dut/BRESP0
add wave -noupdate -group DUT /top/dut/BVALID0
add wave -noupdate -group DUT /top/dut/BREADY0
add wave -noupdate -group DUT /top/dut/ARID0
add wave -noupdate -group DUT /top/dut/ARADDR0
add wave -noupdate -group DUT /top/dut/ARLEN0
add wave -noupdate -group DUT /top/dut/ARSIZE0
add wave -noupdate -group DUT /top/dut/ARVALID0
add wave -noupdate -group DUT /top/dut/ARREADY0
add wave -noupdate -group DUT /top/dut/RID0
add wave -noupdate -group DUT /top/dut/RDATA0
add wave -noupdate -group DUT /top/dut/RRESP0
add wave -noupdate -group DUT /top/dut/RLAST0
add wave -noupdate -group DUT /top/dut/RVALID0
add wave -noupdate -group DUT /top/dut/RREADY0
add wave -noupdate -group DUT /top/dut/rd_port_num0
add wave -noupdate -group DUT /top/dut/wr_port_num0
add wave -noupdate -group DUT /top/dut/rd_port_num1
add wave -noupdate -group DUT /top/dut/wr_port_num1
add wave -noupdate -group DUT /top/dut/slv_rd_port_num0
add wave -noupdate -group DUT /top/dut/slv_wr_port_num0
add wave -noupdate -group DUT /top/dut/slv_rd_port_num1
add wave -noupdate -group DUT /top/dut/slv_wr_port_num1
add wave -noupdate -group DUT /top/dut/M0_AWID
add wave -noupdate -group DUT /top/dut/M0_AWADDR
add wave -noupdate -group DUT /top/dut/M0_AWLEN
add wave -noupdate -group DUT /top/dut/M0_AWSIZE
add wave -noupdate -group DUT /top/dut/M0_AWVALID
add wave -noupdate -group DUT /top/dut/M0_AWREADY
add wave -noupdate -group DUT /top/dut/M0_WID
add wave -noupdate -group DUT /top/dut/M0_WDATA
add wave -noupdate -group DUT /top/dut/M0_WSTRB
add wave -noupdate -group DUT /top/dut/M0_WLAST
add wave -noupdate -group DUT /top/dut/M0_WVALID
add wave -noupdate -group DUT /top/dut/M0_WREADY
add wave -noupdate -group DUT /top/dut/M0_BID
add wave -noupdate -group DUT /top/dut/M0_BRESP
add wave -noupdate -group DUT /top/dut/M0_BVALID
add wave -noupdate -group DUT /top/dut/M0_BREADY
add wave -noupdate -group DUT /top/dut/M0_ARID
add wave -noupdate -group DUT /top/dut/M0_ARADDR
add wave -noupdate -group DUT /top/dut/M0_ARLEN
add wave -noupdate -group DUT /top/dut/M0_ARSIZE
add wave -noupdate -group DUT /top/dut/M0_ARVALID
add wave -noupdate -group DUT /top/dut/M0_ARREADY
add wave -noupdate -group DUT /top/dut/M0_RID
add wave -noupdate -group DUT /top/dut/M0_RDATA
add wave -noupdate -group DUT /top/dut/M0_RRESP
add wave -noupdate -group DUT /top/dut/M0_RLAST
add wave -noupdate -group DUT /top/dut/M0_RVALID
add wave -noupdate -group DUT /top/dut/M0_RREADY
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/clk
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/reset
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/awid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/awaddr
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/awlen
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/awsize
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/awvalid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/awready
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/wid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/wdata
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/wstrb
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/wlast
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/wvalid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/wready
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/bid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/bresp
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/bvalid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/bready
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/arid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/araddr
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/arlen
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/arsize
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/arvalid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/arready
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/rid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/rdata
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/rresp
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/rlast
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/rvalid
add wave -noupdate -expand -group AXI_INTF /top/axi_pif/rready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1164 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 341
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2063472 ps} {2101923 ps}
