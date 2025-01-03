/*#############################################################################################
#                                                   					      #
#                                                   					      #
#                                                   					      #
#############      Copyright (C) 2012-2020 VLSIGuru Training Institute        #################
#                                                   					      #
###### www.vlsiguru.com | contact@vlsiguru.com | +91-9986194191 | Horamavu, Bangalore  ########
#                                                   					      #
###### This Code is proprietary of VLSIGuru Training Institute. This code can't be reused #####
###### or distributed without prior consent from VLSIGuru Training Institute.           #######
#                                                   					      #
#                                                   					      #
#                                                   					      #
##############################################################################################*/
//reg [31:0] ch0_cmd_reg0; //Vector(DUT) => it is changed in to a class definition format
class ch0_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch0_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8; //Divided whole range in to 8 regions, on which coverage will be done
		}
	endgroup

	function new();
		ch0_cmd_reg0_cg = new();
	endfunction

	//we can do 3 things to the register: 1. reset  2. write  3. read
	//when we apply reset to a register, its contents will become 0(unless it is mentioend in different manner)
	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		ch0_cmd_reg0_cg.sample(); //whenever register write is done, sampling is also done, so that coverage collection will happen
	endfunction

	function reg [31:0] read();
		return {rd_start_addr}; //reading the fields of the register
	endfunction
endclass

class ch0_cmd_reg1;
	reg [31:0] value;
	bit [31:0] wr_start_addr;
	covergroup ch0_cmd_reg1_cg;
		WR_START_ADDR_CP : coverpoint wr_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_cmd_reg1_cg = new();
	endfunction

	function void reset();
		wr_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_start_addr = data[31:0];
		ch0_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_start_addr};
	endfunction
endclass

class ch0_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch0_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		ch0_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch0_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch0_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		ch0_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch0_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch0_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		ch0_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch0_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch0_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		ch0_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch0_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch0_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		ch0_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch0_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch0_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		ch0_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		ch0_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch0_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch0_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		ch0_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		ch0_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch0_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch0_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		ch0_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch0_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch0_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		ch0_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch0_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch0_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		ch0_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch0_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch0_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32; //initialize with FIFO size
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0]; //This is Read only field, which can't be updated by testbench
		//wr_fullness = data[25:16];
		//ch0_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return 32'h0002001e;
	endfunction
endclass
class ch0_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch0_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		ch0_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch0_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch0_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		ch0_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch0_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch0_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		ch0_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch0_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch0_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_rd_active = data[0];
		ch_wr_active = data[1];
		ch0_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch0_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch0_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		//ch0_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch0_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch0_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		ch0_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch0_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch0_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		ch0_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch0_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch0_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		ch0_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch0_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch0_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		ch0_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		ch0_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch1_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch1_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch1_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch1_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch1_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch1_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch1_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch1_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch1_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch1_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch1_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch1_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch1_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch1_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch1_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch1_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch1_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch1_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch1_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch1_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch1_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch1_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch1_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch1_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch1_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch1_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch1_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch1_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch1_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch1_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch1_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch1_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch1_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [31:24] rsvd2;
	covergroup ch1_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch1_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, rd_offset};
	endfunction
endclass
class ch1_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [31:24] rsvd2;
	covergroup ch1_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch1_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_offset};
	endfunction
endclass
class ch1_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch1_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32;
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch1_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch1_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch1_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch1_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch1_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch1_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch1_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch1_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch1_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch1_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch1_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch1_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch1_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch1_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch1_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch1_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch1_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch1_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch1_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch1_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch1_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch1_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch1_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch1_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch1_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch1_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch1_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch1_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch1_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch2_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch2_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch2_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch2_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch2_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch2_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch2_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch2_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch2_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch2_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch2_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch2_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch2_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch2_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch2_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch2_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch2_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch2_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch2_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch2_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch2_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch2_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch2_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch2_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch2_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch2_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch2_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch2_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch2_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch2_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch2_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch2_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch2_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch2_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch2_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch2_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch2_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch2_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch2_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch2_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32;
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch2_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch2_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch2_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch2_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch2_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch2_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch2_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch2_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch2_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch2_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch2_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch2_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch2_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch2_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch2_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch2_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch2_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch2_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch2_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch2_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch2_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch2_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch2_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch2_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch2_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch2_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch2_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch2_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch2_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch3_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch3_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch3_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch3_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch3_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch3_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch3_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch3_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch3_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch3_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch3_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch3_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch3_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch3_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch3_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch3_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch3_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch3_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch3_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch3_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch3_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch3_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch3_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch3_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch3_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch3_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch3_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch3_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch3_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch3_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch3_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch3_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch3_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch3_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch3_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch3_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch3_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch3_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch3_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch3_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32;
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch3_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch3_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch3_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch3_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch3_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch3_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch3_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch3_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch3_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch3_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch3_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch3_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch3_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch3_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch3_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch3_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch3_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch3_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch3_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch3_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch3_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch3_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch3_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch3_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch3_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch3_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch3_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch3_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch3_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch4_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch4_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch4_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch4_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch4_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch4_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch4_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch4_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch4_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch4_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch4_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch4_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch4_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch4_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch4_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch4_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch4_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch4_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch4_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch4_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch4_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch4_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch4_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch4_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch4_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch4_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch4_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch4_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch4_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch4_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch4_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch4_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch4_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch4_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch4_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch4_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch4_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch4_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch4_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch4_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32;
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch4_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch4_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch4_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch4_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch4_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch4_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch4_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch4_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch4_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch4_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch4_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch4_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch4_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch4_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch4_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch4_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch4_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch4_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch4_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch4_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch4_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch4_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch4_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch4_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch4_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch4_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch4_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch4_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch4_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch5_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch5_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch5_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch5_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch5_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch5_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch5_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch5_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch5_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch5_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch5_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch5_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch5_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch5_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch5_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch5_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch5_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch5_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch5_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch5_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch5_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch5_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch5_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch5_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch5_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch5_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch5_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch5_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch5_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch5_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch5_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch5_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch5_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch5_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch5_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch5_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch5_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch5_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch5_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch5_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32;
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch5_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch5_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch5_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch5_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch5_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch5_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch5_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch5_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch5_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch5_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch5_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch5_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch5_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch5_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch5_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch5_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch5_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch5_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch5_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch5_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch5_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch5_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch5_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch5_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch5_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch5_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch5_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch5_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch5_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch6_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch6_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch6_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch6_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch6_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch6_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch6_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch6_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch6_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch6_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int;
	bit cmd_last;
	bit [29:0] cmd_next_addr;
	covergroup ch6_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch6_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch6_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch6_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch6_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch6_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch6_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch6_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch6_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch6_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch6_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch6_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch6_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch6_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch6_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch6_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch6_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch6_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch6_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch6_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch6_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch6_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch6_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch6_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch6_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch6_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch6_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch6_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch6_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch6_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32;
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch6_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch6_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch6_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch6_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch6_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch6_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch6_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch6_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch6_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch6_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch6_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch6_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch6_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch6_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch6_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch6_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch6_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch6_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch6_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch6_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch6_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch6_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch6_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch6_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch6_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch6_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch6_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch6_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch6_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class ch7_cmd_reg0;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch7_cmd_reg0_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_cmd_reg0_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch7_cmd_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch7_cmd_reg1;
	reg [31:0] value;
	bit [31:0] rd_start_addr;
	covergroup ch7_cmd_reg1_cg;
		RD_START_ADDR_CP : coverpoint rd_start_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_cmd_reg1_cg = new();
	endfunction

	function void reset();
		rd_start_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_start_addr = data[31:0];
		//ch7_cmd_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_start_addr};
	endfunction
endclass
class ch7_cmd_reg2;
	reg [31:0] value;
	bit [9:0] buffer_size;
	covergroup ch7_cmd_reg2_cg;
		BUFFER_SIZE_CP : coverpoint buffer_size {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_cmd_reg2_cg = new();
	endfunction

	function void reset();
		buffer_size = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		buffer_size = data[9:0];
		//ch7_cmd_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {buffer_size};
	endfunction
endclass
class ch7_cmd_reg3;
	reg [31:0] value;
	bit cmd_set_int; //1
	bit cmd_last; //1
	bit [29:0] cmd_next_addr; //30
	covergroup ch7_cmd_reg3_cg;
		CMD_SET_INT_CP : coverpoint cmd_set_int {
			option.auto_bin_max = 8;
		}
		CMD_LAST_CP : coverpoint cmd_last {
			option.auto_bin_max = 8;
		}
		CMD_NEXT_ADDR_CP : coverpoint cmd_next_addr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_cmd_reg3_cg = new();
	endfunction

	function void reset();
		cmd_set_int = 0;
		cmd_last = 0;
		cmd_next_addr = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		cmd_set_int = data[0];
		cmd_last = data[1];
		cmd_next_addr = data[31:2];
		//ch7_cmd_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {cmd_next_addr, cmd_last, cmd_set_int};
	endfunction
endclass
class ch7_static_reg0;
	reg [31:0] value;
	bit [7:0] rd_burst_max_size;
	bit [11:8] rsvd1;
	bit rd_allow_full_burst;
	bit rd_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] rd_tokens;
	bit [23:22] rsvd3;
	bit [27:24] rd_outs_max;
	bit [29:28] rsvd4;
	bit rd_outstanding;
	bit rd_incr;
	covergroup ch7_static_reg0_cg;
		RD_BURST_MAX_SIZE_CP : coverpoint rd_burst_max_size {
			option.auto_bin_max = 8;
		}
		//RD_ALLOW_FULL_BURST_CP : coverpoint rd_allow_full_burst {
		//	option.auto_bin_max = 8;
		//}
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		RD_TOKENS_CP : coverpoint rd_tokens {
			option.auto_bin_max = 8;
		}
		RD_OUTS_MAX_CP : coverpoint rd_outs_max {
			option.auto_bin_max = 8;
		}
		//RD_OUTSTANDING_CP : coverpoint rd_outstanding {
		//	option.auto_bin_max = 8;
		//}
		RD_INCR_CP : coverpoint rd_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_static_reg0_cg = new();
	endfunction

	function void reset();
		rd_burst_max_size = 0;
		rsvd1 = 0;
		rd_allow_full_burst = 0;
		rd_allow_full_fifo = 0;
		rsvd2 = 0;
		rd_tokens = 1;
		rsvd3 = 0;
		rd_outs_max = 4;
		rsvd4 = 0;
		rd_outstanding = 0;
		rd_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_burst_max_size = data[9:0];
		//rd_allow_full_burst = data[12];
		//rd_allow_full_fifo = data[13];
		rd_tokens = data[21:16];
		rd_outs_max = data[27:24];
		//rd_outstanding = data[30];
		rd_incr = data[31];
		//ch7_static_reg0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rd_incr, rd_outstanding, rsvd4, rd_outs_max, rsvd3, rd_tokens, rsvd2, rd_allow_full_fifo, rd_allow_full_burst, rsvd1, rd_burst_max_size};
	endfunction
endclass
class ch7_static_reg1;
	reg [31:0] value;
	bit [7:0] wr_burst_max_size;
	bit [11:8] rsvd1;
	bit wr_allow_full_burst;
	bit wr_allow_full_fifo;
	bit [15:14] rsvd2;
	bit [21:16] wr_tokens;
	bit [23:22] rsvd3;
	bit [27:24] wr_outs_max;
	bit [29:28] rsvd4;
	bit wr_outstanding;
	bit wr_incr;
	covergroup ch7_static_reg1_cg;
		WR_BURST_MAX_SIZE_CP : coverpoint wr_burst_max_size {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_BURST_CP : coverpoint wr_allow_full_burst {
			option.auto_bin_max = 8;
		}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		WR_TOKENS_CP : coverpoint wr_tokens {
			option.auto_bin_max = 8;
		}
		WR_OUTS_MAX_CP : coverpoint wr_outs_max {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_CP : coverpoint wr_outstanding {
			option.auto_bin_max = 8;
		}
		WR_INCR_CP : coverpoint wr_incr {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_static_reg1_cg = new();
	endfunction

	function void reset();
		wr_burst_max_size = 0;
		rsvd1 = 0;
		wr_allow_full_burst = 0;
		wr_allow_full_fifo = 0;
		rsvd2 = 0;
		wr_tokens = 1;
		rsvd3 = 0;
		wr_outs_max = 4;
		rsvd4 = 0;
		//wr_outstanding = 1;
		wr_incr = 1;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_burst_max_size = data[9:0];
		//wr_allow_full_burst = data[12];
		//wr_allow_full_fifo = data[13];
		wr_tokens = data[21:16];
		wr_outs_max = data[27:24];
		//wr_outstanding = data[30];
		wr_incr = data[31];
		//ch7_static_reg1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_incr, wr_outstanding, rsvd4, wr_outs_max, rsvd3, wr_tokens, rsvd2, wr_allow_full_fifo, wr_allow_full_burst, rsvd1, wr_burst_max_size};
	endfunction
endclass
class ch7_static_reg2;
	reg [31:0] value;
	bit [11:0] frame_width;
	bit [14:12] rsvd1;
	bit block;
	bit joint;
	bit auto_retry;
	bit [19:18] rsvd2;
	bit rd_cmd_port_num;
	bit rd_port_num;
	bit wr_port_num;
	bit rsvd3;
	bit [26:24] int_num;
	bit rsvd4;
	bit [29:28] end_swap;
	bit [31:30] rsvd5;
	covergroup ch7_static_reg2_cg;
		//FRAME_WIDTH_CP : coverpoint frame_width {
		//	option.auto_bin_max = 8;
		//}
		//BLOCK_CP : coverpoint block {
		//	option.auto_bin_max = 8;
		//}
		JOINT_CP : coverpoint joint {
			option.auto_bin_max = 8;
		}
		//AUTO_RETRY_CP : coverpoint auto_retry {
		//	option.auto_bin_max = 8;
		//}
		//RD_CMD_PORT_NUM_CP : coverpoint rd_cmd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//RD_PORT_NUM_CP : coverpoint rd_port_num {
		//	option.auto_bin_max = 8;
		//}
		//WR_PORT_NUM_CP : coverpoint wr_port_num {
		//	option.auto_bin_max = 8;
		//}
		//INT_NUM_CP : coverpoint int_num {
		//	option.auto_bin_max = 8;
		//}
		END_SWAP_CP : coverpoint end_swap {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_static_reg2_cg = new();
	endfunction

	function void reset();
		frame_width = 0;
		rsvd1 = 0;
		block = 0;
		joint = 0;
		auto_retry = 0;
		rsvd2 = 0;
		rd_cmd_port_num = 0;
		rd_port_num = 0;
		wr_port_num = 0;
		rsvd3 = 0;
		int_num = 0;
		rsvd4 = 0;
		end_swap = 0;
		rsvd5 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//frame_width = data[11:0];
		//block = data[15];
		joint = data[16];
		//auto_retry = data[17];
		//rd_cmd_port_num = data[20];
		//rd_port_num = data[21];
		//wr_port_num = data[22];
		//int_num = data[26:24];
		end_swap = data[29:28];
		//ch7_static_reg2_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd5, end_swap, rsvd4, int_num, rsvd3, wr_port_num, rd_port_num, rd_cmd_port_num, rsvd2, auto_retry, joint, block, rsvd1, frame_width};
	endfunction
endclass
class ch7_static_reg3;
	reg [31:0] value;
	bit [11:0] rd_wait_limit;
	bit [15:12] rsvd1;
	bit [27:16] wr_wait_limit;
	bit [31:28] rsvd2;
	covergroup ch7_static_reg3_cg;
		//RD_WAIT_LIMIT_CP : coverpoint rd_wait_limit {
		//	option.auto_bin_max = 8;
		//}
		//WR_WAIT_LIMIT_CP : coverpoint wr_wait_limit {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch7_static_reg3_cg = new();
	endfunction

	function void reset();
		rd_wait_limit = 0;
		rsvd1 = 0;
		wr_wait_limit = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		//rd_wait_limit = data[11:0];
		//wr_wait_limit = data[27:16];
		//ch7_static_reg3_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_wait_limit, rsvd1, rd_wait_limit};
	endfunction
endclass
class ch7_static_reg4;
	reg [31:0] value;
	bit [4:0] rd_periph_num;
	bit [7:5] rsvd1;
	bit [10:8] rd_periph_delay;
	bit [14:11] rsvd2;
	bit rd_periph_block;
	bit [20:16] wr_periph_num;
	bit [23:21] rsvd3;
	bit [26:24] wr_periph_delay;
	bit [30:27] rsvd4;
	bit wr_periph_block;
	covergroup ch7_static_reg4_cg;
		RD_PERIPH_NUM_CP : coverpoint rd_periph_num {
			option.auto_bin_max = 8;
		}
		RD_PERIPH_DELAY_CP : coverpoint rd_periph_delay {
			option.auto_bin_max = 8;
		}
		//RD_PERIPH_BLOCK_CP : coverpoint rd_periph_block {
		//	option.auto_bin_max = 8;
		//}
		WR_PERIPH_NUM_CP : coverpoint wr_periph_num {
			option.auto_bin_max = 8;
		}
		WR_PERIPH_DELAY_CP : coverpoint wr_periph_delay {
			option.auto_bin_max = 8;
		}
		//WR_PERIPH_BLOCK_CP : coverpoint wr_periph_block {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		//ch7_static_reg4_cg = new();
	endfunction

	function void reset();
		rd_periph_num = 0;
		rsvd1 = 0;
		rd_periph_delay = 0;
		rsvd2 = 0;
		rd_periph_block = 0;
		wr_periph_num = 0;
		rsvd3 = 0;
		wr_periph_delay = 0;
		rsvd4 = 0;
		wr_periph_block = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_periph_num = data[4:0];
		rd_periph_delay = data[10:8];
		//rd_periph_block = data[15];
		wr_periph_num = data[20:16];
		wr_periph_delay = data[26:24];
		//wr_periph_block = data[31];
		//ch7_static_reg4_cg.sample();
	endfunction

	function reg [31:0] read();
		return {wr_periph_block, rsvd4, wr_periph_delay, rsvd3, wr_periph_num, rd_periph_block, rsvd2, rd_periph_delay, rsvd1, rd_periph_num};
	endfunction
endclass
class ch7_restrict_reg;
	reg [31:0] value;
	bit rd_allow_full_fifo;
	bit wr_allow_full_fifo;
	bit allow_full_fifo;
	bit allow_full_burst;
	bit allow_joint_burst;
	bit rd_outstanding_stat;
	bit wr_outstanding_stat;
	bit block_non_align_stat;
	bit simple_stat;
	bit [31:9] rsvd1;
	covergroup ch7_restrict_reg_cg;
		//RD_ALLOW_FULL_FIFO_CP : coverpoint rd_allow_full_fifo {
		//	option.auto_bin_max = 8;
		//}
		WR_ALLOW_FULL_FIFO_CP : coverpoint wr_allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_FIFO_CP : coverpoint allow_full_fifo {
			option.auto_bin_max = 8;
		}
		ALLOW_FULL_BURST_CP : coverpoint allow_full_burst {
			option.auto_bin_max = 8;
		}
		ALLOW_JOINT_BURST_CP : coverpoint allow_joint_burst {
			option.auto_bin_max = 8;
		}
		RD_OUTSTANDING_STAT_CP : coverpoint rd_outstanding_stat {
			option.auto_bin_max = 8;
		}
		WR_OUTSTANDING_STAT_CP : coverpoint wr_outstanding_stat {
			option.auto_bin_max = 8;
		}
		BLOCK_NON_ALIGN_STAT_CP : coverpoint block_non_align_stat {
			option.auto_bin_max = 8;
		}
		SIMPLE_STAT_CP : coverpoint simple_stat {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_restrict_reg_cg = new();
	endfunction

	function void reset();
		rd_allow_full_fifo = 0;
		wr_allow_full_fifo = 0;
		allow_full_fifo = 0;
		allow_full_burst = 0;
		allow_joint_burst = 0;
		rd_outstanding_stat = 0;
		wr_outstanding_stat = 0;
		block_non_align_stat = 0;
		simple_stat = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_allow_full_fifo = data[0];
		wr_allow_full_fifo = data[1];
		allow_full_fifo = data[2];
		allow_full_burst = data[3];
		allow_joint_burst = data[4];
		rd_outstanding_stat = data[5];
		wr_outstanding_stat = data[6];
		block_non_align_stat = data[7];
		simple_stat = data[8];
		//ch7_restrict_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, simple_stat, block_non_align_stat, wr_outstanding_stat, rd_outstanding_stat, allow_joint_burst, allow_full_burst, allow_full_fifo, wr_allow_full_fifo, rd_allow_full_fifo};
	endfunction
endclass
class ch7_read_offset_reg;
	reg [31:0] value;
	bit [15:0] rd_offset;
	bit [32:17] rsvd1;
	covergroup ch7_read_offset_reg_cg;
		RD_OFFSET_CP : coverpoint rd_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_read_offset_reg_cg = new();
	endfunction

	function void reset();
		rd_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_offset = data[15:0];
		//ch7_read_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, rd_offset};
	endfunction
endclass
class ch7_write_offset_reg;
	reg [31:0] value;
	bit [15:0] wr_offset;
	bit [32:17] rsvd1;
	covergroup ch7_write_offset_reg_cg;
		WR_OFFSET_CP : coverpoint wr_offset {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_write_offset_reg_cg = new();
	endfunction

	function void reset();
		wr_offset = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		wr_offset = data[15:0];
		//ch7_write_offset_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, wr_offset};
	endfunction
endclass
class ch7_fifo_fullness_reg;
	reg [31:0] value;
	bit [9:0] rd_gap;
	bit [15:10] rsvd1;
	bit [25:16] wr_fullness;
	bit [31:26] rsvd2;
	covergroup ch7_fifo_fullness_reg_cg;
		RD_GAP_CP : coverpoint rd_gap {
			option.auto_bin_max = 8;
		}
		WR_FULLNESS_CP : coverpoint wr_fullness {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_fifo_fullness_reg_cg = new();
	endfunction

	function void reset();
		rd_gap = 32; //20
		rsvd1 = 0;
		wr_fullness = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//rd_gap = data[9:0];
		//wr_fullness = data[25:16];
		//ch7_fifo_fullness_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_fullness, rsvd1, rd_gap};
	endfunction
endclass
class ch7_cmd_outs_reg;
	reg [31:0] value;
	bit [5:0] rd_cmd_outs;
	bit [7:6] rsvd1;
	bit [13:8] wr_cmd_outs;
	bit [31:14] rsvd2;
	covergroup ch7_cmd_outs_reg_cg;
		RD_CMD_OUTS_CP : coverpoint rd_cmd_outs {
			option.auto_bin_max = 8;
		}
		WR_CMD_OUTS_CP : coverpoint wr_cmd_outs {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_cmd_outs_reg_cg = new();
	endfunction

	function void reset();
		rd_cmd_outs = 0;
		rsvd1 = 0;
		wr_cmd_outs = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		rd_cmd_outs = data[5:0];
		wr_cmd_outs = data[13:8];
		//ch7_cmd_outs_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, wr_cmd_outs, rsvd1, rd_cmd_outs};
	endfunction
endclass
class ch7_ch_enable_reg;
	reg [31:0] value;
	bit ch_enable;
	bit [31:1] rsvd1;
	covergroup ch7_ch_enable_reg_cg;
		CH_ENABLE_CP : coverpoint ch_enable {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_ch_enable_reg_cg = new();
	endfunction

	function void reset();
		ch_enable = 1;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_enable = data[0];
		//ch7_ch_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_enable};
	endfunction
endclass
class ch7_ch_start_reg;
	reg [31:0] value;
	bit ch_start;
	bit [31:1] rsvd1;
	covergroup ch7_ch_start_reg_cg;
		CH_START_CP : coverpoint ch_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_ch_start_reg_cg = new();
	endfunction

	function void reset();
		ch_start = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		ch_start = data[0];
		//ch7_ch_start_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_start};
	endfunction
endclass
class ch7_ch_active_reg;
	reg [31:0] value;
	bit ch_rd_active;
	bit ch_wr_active;
	bit [31:2] rsvd1;
	covergroup ch7_ch_active_reg_cg;
		CH_RD_ACTIVE_CP : coverpoint ch_rd_active {
			option.auto_bin_max = 8;
		}
		CH_WR_ACTIVE_CP : coverpoint ch_wr_active {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_ch_active_reg_cg = new();
	endfunction

	function void reset();
		ch_rd_active = 0;
		ch_wr_active = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//ch_rd_active = data[0];
		//ch_wr_active = data[1];
		////ch7_ch_active_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, ch_wr_active, ch_rd_active};
	endfunction
endclass
class ch7_count_reg;
	reg [31:0] value;
	bit [15:0] buff_count;
	bit [21:16] int_count;
	bit [31:22] rsvd1;
	covergroup ch7_count_reg_cg;
		BUFF_COUNT_CP : coverpoint buff_count {
			option.auto_bin_max = 8;
		}
		INT_COUNT_CP : coverpoint int_count {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_count_reg_cg = new();
	endfunction

	function void reset();
		buff_count = 0;
		int_count = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		//value = data;
		//buff_count = data[15:0];
		//int_count = data[21:16];
		////ch7_count_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_count, buff_count};
	endfunction
endclass
class ch7_int_rawstat_reg;
	reg [31:0] value;
	bit int_rawstat_ch_end;
	bit int_rawstat_rd_decerr;
	bit int_rawstat_rd_slverr;
	bit int_rawstat_wr_decerr;
	bit int_rawstat_wr_slverr;
	bit int_rawstat_overflow;
	bit int_rawstat_underflow;
	bit int_rawstat_timeout_r;
	bit int_rawstat_timeout_ar;
	bit int_rawstat_timeout_b;
	bit int_rawstat_timeout_w;
	bit int_rawstat_timeout_aw;
	bit int_rawstat_wdt;
	bit [31:13] rsvd;
	covergroup ch7_int_rawstat_reg_cg;
		INT_RAWSTAT_CH_END_CP : coverpoint int_rawstat_ch_end {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_DECERR_CP : coverpoint int_rawstat_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_RD_SLVERR_CP : coverpoint int_rawstat_rd_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_DECERR_CP : coverpoint int_rawstat_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WR_SLVERR_CP : coverpoint int_rawstat_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_OVERFLOW_CP : coverpoint int_rawstat_overflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_UNDERFLOW_CP : coverpoint int_rawstat_underflow {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_R_CP : coverpoint int_rawstat_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AR_CP : coverpoint int_rawstat_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_B_CP : coverpoint int_rawstat_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_W_CP : coverpoint int_rawstat_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_TIMEOUT_AW_CP : coverpoint int_rawstat_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_RAWSTAT_WDT_CP : coverpoint int_rawstat_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_int_rawstat_reg_cg = new();
	endfunction

	function void reset();
		int_rawstat_ch_end = 0;
		int_rawstat_rd_decerr = 0;
		int_rawstat_rd_slverr = 0;
		int_rawstat_wr_decerr = 0;
		int_rawstat_wr_slverr = 0;
		int_rawstat_overflow = 0;
		int_rawstat_underflow = 0;
		int_rawstat_timeout_r = 0;
		int_rawstat_timeout_ar = 0;
		int_rawstat_timeout_b = 0;
		int_rawstat_timeout_w = 0;
		int_rawstat_timeout_aw = 0;
		int_rawstat_wdt = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_rawstat_ch_end = data[0];
		int_rawstat_rd_decerr = data[1];
		int_rawstat_rd_slverr = data[2];
		int_rawstat_wr_decerr = data[3];
		int_rawstat_wr_slverr = data[4];
		int_rawstat_overflow = data[5];
		int_rawstat_underflow = data[6];
		int_rawstat_timeout_r = data[7];
		int_rawstat_timeout_ar = data[8];
		int_rawstat_timeout_b = data[9];
		int_rawstat_timeout_w = data[10];
		int_rawstat_timeout_aw = data[11];
		int_rawstat_wdt = data[12];
		//ch7_int_rawstat_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, int_rawstat_wdt, int_rawstat_timeout_aw, int_rawstat_timeout_w, int_rawstat_timeout_b, int_rawstat_timeout_ar, int_rawstat_timeout_r, int_rawstat_underflow, int_rawstat_overflow, int_rawstat_wr_slverr, int_rawstat_wr_decerr, int_rawstat_rd_slverr, int_rawstat_rd_decerr, int_rawstat_ch_end};
	endfunction
endclass
class ch7_int_clear_reg;
	reg [31:0] value;
	bit int_clr_ch_end;
	bit int_clr_rd_decerr;
	bit int_clr_rd_svlerr;
	bit int_clr_wr_decerr;
	bit int_clr_wr_slverr;
	bit int_clr_overflow;
	bit int_clr_underflow;
	bit int_clr_timeout_r;
	bit int_clr_timeout_ar;
	bit int_clr_timeout_b;
	bit int_clr_timeout_w;
	bit int_clr_timeout_aw;
	bit int_clr_wdt;
	bit [31:13] rsvd1;
	covergroup ch7_int_clear_reg_cg;
		INT_CLR_CH_END_CP : coverpoint int_clr_ch_end {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_DECERR_CP : coverpoint int_clr_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_RD_SVLERR_CP : coverpoint int_clr_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_DECERR_CP : coverpoint int_clr_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_CLR_WR_SLVERR_CP : coverpoint int_clr_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_CLR_OVERFLOW_CP : coverpoint int_clr_overflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_UNDERFLOW_CP : coverpoint int_clr_underflow {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_R_CP : coverpoint int_clr_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AR_CP : coverpoint int_clr_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_B_CP : coverpoint int_clr_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_W_CP : coverpoint int_clr_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_CLR_TIMEOUT_AW_CP : coverpoint int_clr_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_CLR_WDT_CP : coverpoint int_clr_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_int_clear_reg_cg = new();
	endfunction

	function void reset();
		int_clr_ch_end = 0;
		int_clr_rd_decerr = 0;
		int_clr_rd_svlerr = 0;
		int_clr_wr_decerr = 0;
		int_clr_wr_slverr = 0;
		int_clr_overflow = 0;
		int_clr_underflow = 0;
		int_clr_timeout_r = 0;
		int_clr_timeout_ar = 0;
		int_clr_timeout_b = 0;
		int_clr_timeout_w = 0;
		int_clr_timeout_aw = 0;
		int_clr_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_clr_ch_end = data[0];
		int_clr_rd_decerr = data[1];
		int_clr_rd_svlerr = data[2];
		int_clr_wr_decerr = data[3];
		int_clr_wr_slverr = data[4];
		int_clr_overflow = data[5];
		int_clr_underflow = data[6];
		int_clr_timeout_r = data[7];
		int_clr_timeout_ar = data[8];
		int_clr_timeout_b = data[9];
		int_clr_timeout_w = data[10];
		int_clr_timeout_aw = data[11];
		int_clr_wdt = data[12];
		//ch7_int_clear_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_clr_wdt, int_clr_timeout_aw, int_clr_timeout_w, int_clr_timeout_b, int_clr_timeout_ar, int_clr_timeout_r, int_clr_underflow, int_clr_overflow, int_clr_wr_slverr, int_clr_wr_decerr, int_clr_rd_svlerr, int_clr_rd_decerr, int_clr_ch_end};
	endfunction
endclass
class ch7_int_enable_reg;
	reg [31:0] value;
	bit int_enable_ch_end;
	bit int_enable_rd_decerr;
	bit int_enable_rd_svlerr;
	bit int_enable_wr_decerr;
	bit int_enable_wr_slverr;
	bit int_enable_overflow;
	bit int_enable_underflow;
	bit int_enable_timeout_r;
	bit int_enable_timeout_ar;
	bit int_enable_timeout_b;
	bit int_enable_timeout_w;
	bit int_enable_timeout_aw;
	bit int_enable_wdt;
	bit [31:13] rsvd1;
	covergroup ch7_int_enable_reg_cg;
		INT_ENABLE_CH_END_CP : coverpoint int_enable_ch_end {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_DECERR_CP : coverpoint int_enable_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_RD_SVLERR_CP : coverpoint int_enable_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_DECERR_CP : coverpoint int_enable_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WR_SLVERR_CP : coverpoint int_enable_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_OVERFLOW_CP : coverpoint int_enable_overflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_UNDERFLOW_CP : coverpoint int_enable_underflow {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_R_CP : coverpoint int_enable_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AR_CP : coverpoint int_enable_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_B_CP : coverpoint int_enable_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_W_CP : coverpoint int_enable_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_TIMEOUT_AW_CP : coverpoint int_enable_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_ENABLE_WDT_CP : coverpoint int_enable_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_int_enable_reg_cg = new();
	endfunction

	function void reset();
		int_enable_ch_end = 0;
		int_enable_rd_decerr = 0;
		int_enable_rd_svlerr = 0;
		int_enable_wr_decerr = 0;
		int_enable_wr_slverr = 0;
		int_enable_overflow = 0;
		int_enable_underflow = 0;
		int_enable_timeout_r = 0;
		int_enable_timeout_ar = 0;
		int_enable_timeout_b = 0;
		int_enable_timeout_w = 0;
		int_enable_timeout_aw = 0;
		int_enable_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_enable_ch_end = data[0];
		int_enable_rd_decerr = data[1];
		int_enable_rd_svlerr = data[2];
		int_enable_wr_decerr = data[3];
		int_enable_wr_slverr = data[4];
		int_enable_overflow = data[5];
		int_enable_underflow = data[6];
		int_enable_timeout_r = data[7];
		int_enable_timeout_ar = data[8];
		int_enable_timeout_b = data[9];
		int_enable_timeout_w = data[10];
		int_enable_timeout_aw = data[11];
		int_enable_wdt = data[12];
		//ch7_int_enable_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_enable_wdt, int_enable_timeout_aw, int_enable_timeout_w, int_enable_timeout_b, int_enable_timeout_ar, int_enable_timeout_r, int_enable_underflow, int_enable_overflow, int_enable_wr_slverr, int_enable_wr_decerr, int_enable_rd_svlerr, int_enable_rd_decerr, int_enable_ch_end};
	endfunction
endclass
class ch7_int_status_reg;
	reg [31:0] value;
	bit int_status_ch_end;
	bit int_status_rd_decerr;
	bit int_status_rd_svlerr;
	bit int_status_wr_decerr;
	bit int_status_wr_slverr;
	bit int_status_overflow;
	bit int_status_underflow;
	bit int_status_timeout_r;
	bit int_status_timeout_ar;
	bit int_status_timeout_b;
	bit int_status_timeout_w;
	bit int_status_timeout_aw;
	bit int_status_wdt;
	bit [31:13] rsvd1;
	covergroup ch7_int_status_reg_cg;
		INT_STATUS_CH_END_CP : coverpoint int_status_ch_end {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_DECERR_CP : coverpoint int_status_rd_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_RD_SVLERR_CP : coverpoint int_status_rd_svlerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_DECERR_CP : coverpoint int_status_wr_decerr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WR_SLVERR_CP : coverpoint int_status_wr_slverr {
			option.auto_bin_max = 8;
		}
		INT_STATUS_OVERFLOW_CP : coverpoint int_status_overflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_UNDERFLOW_CP : coverpoint int_status_underflow {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_R_CP : coverpoint int_status_timeout_r {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AR_CP : coverpoint int_status_timeout_ar {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_B_CP : coverpoint int_status_timeout_b {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_W_CP : coverpoint int_status_timeout_w {
			option.auto_bin_max = 8;
		}
		INT_STATUS_TIMEOUT_AW_CP : coverpoint int_status_timeout_aw {
			option.auto_bin_max = 8;
		}
		INT_STATUS_WDT_CP : coverpoint int_status_wdt {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		//ch7_int_status_reg_cg = new();
	endfunction

	function void reset();
		int_status_ch_end = 0;
		int_status_rd_decerr = 0;
		int_status_rd_svlerr = 0;
		int_status_wr_decerr = 0;
		int_status_wr_slverr = 0;
		int_status_overflow = 0;
		int_status_underflow = 0;
		int_status_timeout_r = 0;
		int_status_timeout_ar = 0;
		int_status_timeout_b = 0;
		int_status_timeout_w = 0;
		int_status_timeout_aw = 0;
		int_status_wdt = 0;
		rsvd1 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		int_status_ch_end = data[0];
		int_status_rd_decerr = data[1];
		int_status_rd_svlerr = data[2];
		int_status_wr_decerr = data[3];
		int_status_wr_slverr = data[4];
		int_status_overflow = data[5];
		int_status_underflow = data[6];
		int_status_timeout_r = data[7];
		int_status_timeout_ar = data[8];
		int_status_timeout_b = data[9];
		int_status_timeout_w = data[10];
		int_status_timeout_aw = data[11];
		int_status_wdt = data[12];
		//ch7_int_status_reg_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd1, int_status_wdt, int_status_timeout_aw, int_status_timeout_w, int_status_timeout_b, int_status_timeout_ar, int_status_timeout_r, int_status_underflow, int_status_overflow, int_status_wr_slverr, int_status_wr_decerr, int_status_rd_svlerr, int_status_rd_decerr, int_status_ch_end};
	endfunction
endclass
class int0_status;
	reg [31:0] value;
	bit core0_ch0_int0_stat;
	bit core0_ch1_int0_stat;
	bit core0_ch2_int0_stat;
	bit core0_ch3_int0_stat;
	bit core0_ch4_int0_stat;
	bit core0_ch5_int0_stat;
	bit core0_ch6_int0_stat;
	bit core0_ch7_int0_stat;
	bit core1_ch0_int0_stat;
	bit core1_ch1_int0_stat;
	bit core1_ch2_int0_stat;
	bit core1_ch3_int0_stat;
	bit core1_ch4_int0_stat;
	bit core1_ch5_int0_stat;
	bit core1_ch6_int0_stat;
	bit core1_ch7_int0_stat;
	bit [31:16] rsvd;
	covergroup int0_status_cg;
		CORE0_CH0_INT0_STAT_CP : coverpoint core0_ch0_int0_stat {
			option.auto_bin_max = 8;
		}
		//CORE0_CH1_INT0_STAT_CP : coverpoint core0_ch1_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE0_CH2_INT0_STAT_CP : coverpoint core0_ch2_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE0_CH3_INT0_STAT_CP : coverpoint core0_ch3_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE0_CH4_INT0_STAT_CP : coverpoint core0_ch4_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE0_CH5_INT0_STAT_CP : coverpoint core0_ch5_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE0_CH6_INT0_STAT_CP : coverpoint core0_ch6_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE0_CH7_INT0_STAT_CP : coverpoint core0_ch7_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH0_INT0_STAT_CP : coverpoint core1_ch0_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH1_INT0_STAT_CP : coverpoint core1_ch1_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH2_INT0_STAT_CP : coverpoint core1_ch2_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH3_INT0_STAT_CP : coverpoint core1_ch3_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH4_INT0_STAT_CP : coverpoint core1_ch4_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH5_INT0_STAT_CP : coverpoint core1_ch5_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH6_INT0_STAT_CP : coverpoint core1_ch6_int0_stat {
		//	option.auto_bin_max = 8;
		//}
		//CORE1_CH7_INT0_STAT_CP : coverpoint core1_ch7_int0_stat {
		//	option.auto_bin_max = 8;
		//}
	endgroup

	function new();
		int0_status_cg = new();
	endfunction

	function void reset();
		core0_ch0_int0_stat = 0;
		core0_ch1_int0_stat = 0;
		core0_ch2_int0_stat = 0;
		core0_ch3_int0_stat = 0;
		core0_ch4_int0_stat = 0;
		core0_ch5_int0_stat = 0;
		core0_ch6_int0_stat = 0;
		core0_ch7_int0_stat = 0;
		core1_ch0_int0_stat = 0;
		core1_ch1_int0_stat = 0;
		core1_ch2_int0_stat = 0;
		core1_ch3_int0_stat = 0;
		core1_ch4_int0_stat = 0;
		core1_ch5_int0_stat = 0;
		core1_ch6_int0_stat = 0;
		core1_ch7_int0_stat = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		core0_ch0_int0_stat = data[0];
		core0_ch1_int0_stat = data[1];
		core0_ch2_int0_stat = data[2];
		core0_ch3_int0_stat = data[3];
		core0_ch4_int0_stat = data[4];
		core0_ch5_int0_stat = data[5];
		core0_ch6_int0_stat = data[6];
		core0_ch7_int0_stat = data[7];
		core1_ch0_int0_stat = data[8];
		core1_ch1_int0_stat = data[9];
		core1_ch2_int0_stat = data[10];
		core1_ch3_int0_stat = data[11];
		core1_ch4_int0_stat = data[12];
		core1_ch5_int0_stat = data[13];
		core1_ch6_int0_stat = data[14];
		core1_ch7_int0_stat = data[15];
		int0_status_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, core1_ch7_int0_stat, core1_ch6_int0_stat, core1_ch5_int0_stat, core1_ch4_int0_stat, core1_ch3_int0_stat, core1_ch2_int0_stat, core1_ch1_int0_stat, core1_ch0_int0_stat, core0_ch7_int0_stat, core0_ch6_int0_stat, core0_ch5_int0_stat, core0_ch4_int0_stat, core0_ch3_int0_stat, core0_ch2_int0_stat, core0_ch1_int0_stat, core0_ch0_int0_stat};
	endfunction
endclass

class core0_joint_mode;
	reg [31:0] value;
	bit core0_joint_mode;
	bit [31:1] rsvd;
	covergroup core0_joint_mode_cg;
		CORE0_JOINT_MODE_CP : coverpoint core0_joint_mode {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		core0_joint_mode_cg = new();
	endfunction

	function void reset();
		core0_joint_mode = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		core0_joint_mode = data[0];
		core0_joint_mode_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, core0_joint_mode};
	endfunction
endclass

class core0_priority;
	reg [31:0] value;
	bit [2:0] core0_rd_prio_top_num;
	bit core0_rd_prio_top;
	bit [6:4] core0_rd_prio_high_num;
	bit core0_rd_prio_high;
	bit [10:8] core0_wr_prio_top_num;
	bit core0_wr_prio_top;
	bit [14:12] core0_wr_prio_high_num;
	bit core0_wr_prio_high;
	bit [31:16] rsvd;
	covergroup core0_priority_cg;
		CORE0_RD_PRIO_TOP_NUM_CP : coverpoint core0_rd_prio_top_num {
			option.auto_bin_max = 8;
		}
		CORE0_RD_PRIO_TOP_CP : coverpoint core0_rd_prio_top {
			option.auto_bin_max = 8;
		}
		CORE0_RD_PRIO_HIGH_NUM_CP : coverpoint core0_rd_prio_high_num {
			option.auto_bin_max = 8;
		}
		CORE0_RD_PRIO_HIGH_CP : coverpoint core0_rd_prio_high {
			option.auto_bin_max = 8;
		}
		CORE0_WR_PRIO_TOP_NUM_CP : coverpoint core0_wr_prio_top_num {
			option.auto_bin_max = 8;
		}
		CORE0_WR_PRIO_TOP_CP : coverpoint core0_wr_prio_top {
			option.auto_bin_max = 8;
		}
		CORE0_WR_PRIO_HIGH_NUM_CP : coverpoint core0_wr_prio_high_num {
			option.auto_bin_max = 8;
		}
		CORE0_WR_PRIO_HIGH_CP : coverpoint core0_wr_prio_high {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		core0_priority_cg = new();
	endfunction

	function void reset();
		core0_rd_prio_top_num = 0;
		core0_rd_prio_top = 0;
		core0_rd_prio_high_num = 0;
		core0_rd_prio_high = 0;
		core0_wr_prio_top_num = 0;
		core0_wr_prio_top = 0;
		core0_wr_prio_high_num = 0;
		core0_wr_prio_high = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		core0_rd_prio_top_num = data[2:0];
		core0_rd_prio_top = data[3];
		core0_rd_prio_high_num = data[6:4];
		core0_rd_prio_high = data[7];
		core0_wr_prio_top_num = data[10:8];
		core0_wr_prio_top = data[11];
		core0_wr_prio_high_num = data[14:12];
		core0_wr_prio_high = data[15];
		core0_priority_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, core0_wr_prio_high, core0_wr_prio_high_num, core0_wr_prio_top, core0_wr_prio_top_num, core0_rd_prio_high, core0_rd_prio_high_num, core0_rd_prio_top, core0_rd_prio_top_num};
	endfunction
endclass

class core0_ch_start;
	reg [31:0] value;
	bit [6:0] core0_channel_start;
	bit [31:8] rsvd;
	covergroup core0_ch_start_cg;
		CORE0_CHANNEL_START_CP : coverpoint core0_channel_start {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		core0_ch_start_cg = new();
	endfunction

	function void reset();
		core0_channel_start = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		core0_channel_start = data[6:0];
		core0_ch_start_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, core0_channel_start};
	endfunction
endclass

class periph_rx_ctrl;
	reg [31:0] value;
	bit [31:0] periph_rx_req;
	covergroup periph_rx_ctrl_cg;
		PERIPH_RX_REQ_CP : coverpoint periph_rx_req {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		periph_rx_ctrl_cg = new();
	endfunction

	function void reset();
		periph_rx_req = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		periph_rx_req = data[31:0];
		periph_rx_ctrl_cg.sample();
	endfunction

	function reg [31:0] read();
		return {periph_rx_req};
	endfunction
endclass
class periph_tx_ctrl;
	reg [31:0] value;
	bit [31:0] periph_tx_req;
	covergroup periph_tx_ctrl_cg;
		PERIPH_TX_REQ_CP : coverpoint periph_tx_req {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		periph_tx_ctrl_cg = new();
	endfunction

	function void reset();
		periph_tx_req = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		periph_tx_req = data[31:0];
		periph_tx_ctrl_cg.sample();
	endfunction

	function reg [31:0] read();
		return {periph_tx_req};
	endfunction
endclass
class idle;
	reg [31:0] value;
	bit idle;
	bit [31:1] rsvd;
	covergroup idle_cg;
		IDLE_CP : coverpoint idle {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		idle_cg = new();
	endfunction

	function void reset();
		idle = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		idle = data[0];
		idle_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, idle};
	endfunction
endclass
class user_def_status;
	reg [31:0] value;
	bit [3:0] user_def_int_num;
	bit rsvd1;
	bit user_def_dual_core;
	bit user_def_ic;
	bit user_def_ic_dual_port;
	bit user_def_clkgate;
	bit [31:9] rsvd2;
	covergroup user_def_status_cg;
		USER_DEF_INT_NUM_CP : coverpoint user_def_int_num {
			option.auto_bin_max = 8;
		}
		USER_DEF_DUAL_CORE_CP : coverpoint user_def_dual_core {
			option.auto_bin_max = 8;
		}
		USER_DEF_IC_CP : coverpoint user_def_ic {
			option.auto_bin_max = 8;
		}
		USER_DEF_IC_DUAL_PORT_CP : coverpoint user_def_ic_dual_port {
			option.auto_bin_max = 8;
		}
		USER_DEF_CLKGATE_CP : coverpoint user_def_clkgate {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		user_def_status_cg = new();
	endfunction

	function void reset();
		user_def_int_num = 0;
		rsvd1 = 0;
		user_def_dual_core = 0;
		user_def_ic = 0;
		user_def_ic_dual_port = 0;
		user_def_clkgate = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		user_def_int_num = data[3:0];
		user_def_dual_core = data[5];
		user_def_ic = data[6];
		user_def_ic_dual_port = data[7];
		user_def_clkgate = data[8];
		user_def_status_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, user_def_clkgate, user_def_ic_dual_port, user_def_ic, user_def_dual_core, rsvd1, user_def_int_num};
	endfunction
endclass
class user_core0_def_status0;
	reg [31:0] value;
	bit [3:0] user_def_core0_ch_num;
	bit [7:4] user_def_core0_fifo_size;
	bit [11:8] user_def_core0_wcmd_depth;
	bit [15:12] user_def_core0_rcmd_depth;
	bit [21:16] user_def_core0_addr_bits;
	bit user_def_core0_axi_32;
	bit rsvd1;
	bit [28:24] user_def_core0_buff_bits;
	bit [31:29] rsvd2;
	covergroup user_core0_def_status0_cg;
		USER_DEF_CORE0_CH_NUM_CP : coverpoint user_def_core0_ch_num {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_FIFO_SIZE_CP : coverpoint user_def_core0_fifo_size {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_WCMD_DEPTH_CP : coverpoint user_def_core0_wcmd_depth {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_RCMD_DEPTH_CP : coverpoint user_def_core0_rcmd_depth {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_ADDR_BITS_CP : coverpoint user_def_core0_addr_bits {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_AXI_32_CP : coverpoint user_def_core0_axi_32 {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_BUFF_BITS_CP : coverpoint user_def_core0_buff_bits {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		user_core0_def_status0_cg = new();
	endfunction

	function void reset();
		user_def_core0_ch_num = 0;
		user_def_core0_fifo_size = 0;
		user_def_core0_wcmd_depth = 0;
		user_def_core0_rcmd_depth = 0;
		user_def_core0_addr_bits = 0;
		user_def_core0_axi_32 = 0;
		rsvd1 = 0;
		user_def_core0_buff_bits = 0;
		rsvd2 = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		user_def_core0_ch_num = data[3:0];
		user_def_core0_fifo_size = data[7:4];
		user_def_core0_wcmd_depth = data[11:8];
		user_def_core0_rcmd_depth = data[15:12];
		user_def_core0_addr_bits = data[21:16];
		user_def_core0_axi_32 = data[22];
		user_def_core0_buff_bits = data[28:24];
		user_core0_def_status0_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd2, user_def_core0_buff_bits, rsvd1, user_def_core0_axi_32, user_def_core0_addr_bits, user_def_core0_rcmd_depth, user_def_core0_wcmd_depth, user_def_core0_fifo_size, user_def_core0_ch_num};
	endfunction
endclass
class user_core0_def_status1;
	reg [31:0] value;
	bit user_def_core0_wdt;
	bit user_def_core0_timeout;
	bit user_def_core0_tokens;
	bit user_def_core0_prio;
	bit user_def_core0_outs;
	bit user_def_core0_wait;
	bit user_def_core0_block;
	bit user_def_core0_joint;
	bit user_def_core0_independent;
	bit user_def_core0_periph;
	bit user_def_core0_lists;
	bit user_def_core0_end;
	bit user_def_core0_clkdiv;
	bit [31:13] rsvd;
	covergroup user_core0_def_status1_cg;
		USER_DEF_CORE0_WDT_CP : coverpoint user_def_core0_wdt {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_TIMEOUT_CP : coverpoint user_def_core0_timeout {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_TOKENS_CP : coverpoint user_def_core0_tokens {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_PRIO_CP : coverpoint user_def_core0_prio {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_OUTS_CP : coverpoint user_def_core0_outs {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_WAIT_CP : coverpoint user_def_core0_wait {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_BLOCK_CP : coverpoint user_def_core0_block {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_JOINT_CP : coverpoint user_def_core0_joint {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_INDEPENDENT_CP : coverpoint user_def_core0_independent {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_PERIPH_CP : coverpoint user_def_core0_periph {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_LISTS_CP : coverpoint user_def_core0_lists {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_END_CP : coverpoint user_def_core0_end {
			option.auto_bin_max = 8;
		}
		USER_DEF_CORE0_CLKDIV_CP : coverpoint user_def_core0_clkdiv {
			option.auto_bin_max = 8;
		}
	endgroup

	function new();
		user_core0_def_status1_cg = new();
	endfunction

	function void reset();
		user_def_core0_wdt = 0;
		user_def_core0_timeout = 0;
		user_def_core0_tokens = 0;
		user_def_core0_prio = 0;
		user_def_core0_outs = 0;
		user_def_core0_wait = 0;
		user_def_core0_block = 0;
		user_def_core0_joint = 0;
		user_def_core0_independent = 0;
		user_def_core0_periph = 0;
		user_def_core0_lists = 0;
		user_def_core0_end = 0;
		user_def_core0_clkdiv = 0;
		rsvd = 0;
	endfunction

	function void write(reg [31:0] data);
		value = data;
		user_def_core0_wdt = data[0];
		user_def_core0_timeout = data[1];
		user_def_core0_tokens = data[2];
		user_def_core0_prio = data[3];
		user_def_core0_outs = data[4];
		user_def_core0_wait = data[5];
		user_def_core0_block = data[6];
		user_def_core0_joint = data[7];
		user_def_core0_independent = data[8];
		user_def_core0_periph = data[9];
		user_def_core0_lists = data[10];
		user_def_core0_end = data[11];
		user_def_core0_clkdiv = data[12];
		user_core0_def_status1_cg.sample();
	endfunction

	function reg [31:0] read();
		return {rsvd, user_def_core0_clkdiv, user_def_core0_end, user_def_core0_lists, user_def_core0_periph, user_def_core0_independent, user_def_core0_joint, user_def_core0_block, user_def_core0_wait, user_def_core0_outs, user_def_core0_prio, user_def_core0_tokens, user_def_core0_timeout, user_def_core0_wdt};
	endfunction
endclass

class dma_ctrl_reg_block;
//Instantiate all the registers
ch0_cmd_reg0 ch0_cmd_reg0_i = new();
ch0_cmd_reg1 ch0_cmd_reg1_i = new();
ch0_cmd_reg2 ch0_cmd_reg2_i = new();
ch0_cmd_reg3 ch0_cmd_reg3_i = new();
ch0_static_reg0 ch0_static_reg0_i = new();
ch0_static_reg1 ch0_static_reg1_i = new();
ch0_static_reg2 ch0_static_reg2_i = new();
ch0_static_reg3 ch0_static_reg3_i = new();
ch0_static_reg4 ch0_static_reg4_i = new();
ch0_restrict_reg ch0_restrict_reg_i = new();
ch0_read_offset_reg ch0_read_offset_reg_i = new();
ch0_write_offset_reg ch0_write_offset_reg_i = new();
ch0_fifo_fullness_reg ch0_fifo_fullness_reg_i = new();
ch0_cmd_outs_reg ch0_cmd_outs_reg_i = new();
ch0_ch_enable_reg ch0_ch_enable_reg_i = new();
ch0_ch_start_reg ch0_ch_start_reg_i = new();
ch0_ch_active_reg ch0_ch_active_reg_i = new();
ch0_count_reg ch0_count_reg_i = new();
ch0_int_rawstat_reg ch0_int_rawstat_reg_i = new();
ch0_int_clear_reg ch0_int_clear_reg_i = new();
ch0_int_enable_reg ch0_int_enable_reg_i = new();
ch0_int_status_reg ch0_int_status_reg_i = new();
ch1_cmd_reg0 ch1_cmd_reg0_i = new();
ch1_cmd_reg1 ch1_cmd_reg1_i = new();
ch1_cmd_reg2 ch1_cmd_reg2_i = new();
ch1_cmd_reg3 ch1_cmd_reg3_i = new();
ch1_static_reg0 ch1_static_reg0_i = new();
ch1_static_reg1 ch1_static_reg1_i = new();
ch1_static_reg2 ch1_static_reg2_i = new();
ch1_static_reg3 ch1_static_reg3_i = new();
ch1_static_reg4 ch1_static_reg4_i = new();
ch1_restrict_reg ch1_restrict_reg_i = new();
ch1_read_offset_reg ch1_read_offset_reg_i = new();
ch1_write_offset_reg ch1_write_offset_reg_i = new();
ch1_fifo_fullness_reg ch1_fifo_fullness_reg_i = new();
ch1_cmd_outs_reg ch1_cmd_outs_reg_i = new();
ch1_ch_enable_reg ch1_ch_enable_reg_i = new();
ch1_ch_start_reg ch1_ch_start_reg_i = new();
ch1_ch_active_reg ch1_ch_active_reg_i = new();
ch1_count_reg ch1_count_reg_i = new();
ch1_int_rawstat_reg ch1_int_rawstat_reg_i = new();
ch1_int_clear_reg ch1_int_clear_reg_i = new();
ch1_int_enable_reg ch1_int_enable_reg_i = new();
ch1_int_status_reg ch1_int_status_reg_i = new();
ch2_cmd_reg0 ch2_cmd_reg0_i = new();
ch2_cmd_reg1 ch2_cmd_reg1_i = new();
ch2_cmd_reg2 ch2_cmd_reg2_i = new();
ch2_cmd_reg3 ch2_cmd_reg3_i = new();
ch2_static_reg0 ch2_static_reg0_i = new();
ch2_static_reg1 ch2_static_reg1_i = new();
ch2_static_reg2 ch2_static_reg2_i = new();
ch2_static_reg3 ch2_static_reg3_i = new();
ch2_static_reg4 ch2_static_reg4_i = new();
ch2_restrict_reg ch2_restrict_reg_i = new();
ch2_read_offset_reg ch2_read_offset_reg_i = new();
ch2_write_offset_reg ch2_write_offset_reg_i = new();
ch2_fifo_fullness_reg ch2_fifo_fullness_reg_i = new();
ch2_cmd_outs_reg ch2_cmd_outs_reg_i = new();
ch2_ch_enable_reg ch2_ch_enable_reg_i = new();
ch2_ch_start_reg ch2_ch_start_reg_i = new();
ch2_ch_active_reg ch2_ch_active_reg_i = new();
ch2_count_reg ch2_count_reg_i = new();
ch2_int_rawstat_reg ch2_int_rawstat_reg_i = new();
ch2_int_clear_reg ch2_int_clear_reg_i = new();
ch2_int_enable_reg ch2_int_enable_reg_i = new();
ch2_int_status_reg ch2_int_status_reg_i = new();
ch3_cmd_reg0 ch3_cmd_reg0_i = new();
ch3_cmd_reg1 ch3_cmd_reg1_i = new();
ch3_cmd_reg2 ch3_cmd_reg2_i = new();
ch3_cmd_reg3 ch3_cmd_reg3_i = new();
ch3_static_reg0 ch3_static_reg0_i = new();
ch3_static_reg1 ch3_static_reg1_i = new();
ch3_static_reg2 ch3_static_reg2_i = new();
ch3_static_reg3 ch3_static_reg3_i = new();
ch3_static_reg4 ch3_static_reg4_i = new();
ch3_restrict_reg ch3_restrict_reg_i = new();
ch3_read_offset_reg ch3_read_offset_reg_i = new();
ch3_write_offset_reg ch3_write_offset_reg_i = new();
ch3_fifo_fullness_reg ch3_fifo_fullness_reg_i = new();
ch3_cmd_outs_reg ch3_cmd_outs_reg_i = new();
ch3_ch_enable_reg ch3_ch_enable_reg_i = new();
ch3_ch_start_reg ch3_ch_start_reg_i = new();
ch3_ch_active_reg ch3_ch_active_reg_i = new();
ch3_count_reg ch3_count_reg_i = new();
ch3_int_rawstat_reg ch3_int_rawstat_reg_i = new();
ch3_int_clear_reg ch3_int_clear_reg_i = new();
ch3_int_enable_reg ch3_int_enable_reg_i = new();
ch3_int_status_reg ch3_int_status_reg_i = new();
ch4_cmd_reg0 ch4_cmd_reg0_i = new();
ch4_cmd_reg1 ch4_cmd_reg1_i = new();
ch4_cmd_reg2 ch4_cmd_reg2_i = new();
ch4_cmd_reg3 ch4_cmd_reg3_i = new();
ch4_static_reg0 ch4_static_reg0_i = new();
ch4_static_reg1 ch4_static_reg1_i = new();
ch4_static_reg2 ch4_static_reg2_i = new();
ch4_static_reg3 ch4_static_reg3_i = new();
ch4_static_reg4 ch4_static_reg4_i = new();
ch4_restrict_reg ch4_restrict_reg_i = new();
ch4_read_offset_reg ch4_read_offset_reg_i = new();
ch4_write_offset_reg ch4_write_offset_reg_i = new();
ch4_fifo_fullness_reg ch4_fifo_fullness_reg_i = new();
ch4_cmd_outs_reg ch4_cmd_outs_reg_i = new();
ch4_ch_enable_reg ch4_ch_enable_reg_i = new();
ch4_ch_start_reg ch4_ch_start_reg_i = new();
ch4_ch_active_reg ch4_ch_active_reg_i = new();
ch4_count_reg ch4_count_reg_i = new();
ch4_int_rawstat_reg ch4_int_rawstat_reg_i = new();
ch4_int_clear_reg ch4_int_clear_reg_i = new();
ch4_int_enable_reg ch4_int_enable_reg_i = new();
ch4_int_status_reg ch4_int_status_reg_i = new();
ch5_cmd_reg0 ch5_cmd_reg0_i = new();
ch5_cmd_reg1 ch5_cmd_reg1_i = new();
ch5_cmd_reg2 ch5_cmd_reg2_i = new();
ch5_cmd_reg3 ch5_cmd_reg3_i = new();
ch5_static_reg0 ch5_static_reg0_i = new();
ch5_static_reg1 ch5_static_reg1_i = new();
ch5_static_reg2 ch5_static_reg2_i = new();
ch5_static_reg3 ch5_static_reg3_i = new();
ch5_static_reg4 ch5_static_reg4_i = new();
ch5_restrict_reg ch5_restrict_reg_i = new();
ch5_read_offset_reg ch5_read_offset_reg_i = new();
ch5_write_offset_reg ch5_write_offset_reg_i = new();
ch5_fifo_fullness_reg ch5_fifo_fullness_reg_i = new();
ch5_cmd_outs_reg ch5_cmd_outs_reg_i = new();
ch5_ch_enable_reg ch5_ch_enable_reg_i = new();
ch5_ch_start_reg ch5_ch_start_reg_i = new();
ch5_ch_active_reg ch5_ch_active_reg_i = new();
ch5_count_reg ch5_count_reg_i = new();
ch5_int_rawstat_reg ch5_int_rawstat_reg_i = new();
ch5_int_clear_reg ch5_int_clear_reg_i = new();
ch5_int_enable_reg ch5_int_enable_reg_i = new();
ch5_int_status_reg ch5_int_status_reg_i = new();
ch6_cmd_reg0 ch6_cmd_reg0_i = new();
ch6_cmd_reg1 ch6_cmd_reg1_i = new();
ch6_cmd_reg2 ch6_cmd_reg2_i = new();
ch6_cmd_reg3 ch6_cmd_reg3_i = new();
ch6_static_reg0 ch6_static_reg0_i = new();
ch6_static_reg1 ch6_static_reg1_i = new();
ch6_static_reg2 ch6_static_reg2_i = new();
ch6_static_reg3 ch6_static_reg3_i = new();
ch6_static_reg4 ch6_static_reg4_i = new();
ch6_restrict_reg ch6_restrict_reg_i = new();
ch6_read_offset_reg ch6_read_offset_reg_i = new();
ch6_write_offset_reg ch6_write_offset_reg_i = new();
ch6_fifo_fullness_reg ch6_fifo_fullness_reg_i = new();
ch6_cmd_outs_reg ch6_cmd_outs_reg_i = new();
ch6_ch_enable_reg ch6_ch_enable_reg_i = new();
ch6_ch_start_reg ch6_ch_start_reg_i = new();
ch6_ch_active_reg ch6_ch_active_reg_i = new();
ch6_count_reg ch6_count_reg_i = new();
ch6_int_rawstat_reg ch6_int_rawstat_reg_i = new();
ch6_int_clear_reg ch6_int_clear_reg_i = new();
ch6_int_enable_reg ch6_int_enable_reg_i = new();
ch6_int_status_reg ch6_int_status_reg_i = new();
ch7_cmd_reg0 ch7_cmd_reg0_i = new();
ch7_cmd_reg1 ch7_cmd_reg1_i = new();
ch7_cmd_reg2 ch7_cmd_reg2_i = new();
ch7_cmd_reg3 ch7_cmd_reg3_i = new();
ch7_static_reg0 ch7_static_reg0_i = new();
ch7_static_reg1 ch7_static_reg1_i = new();
ch7_static_reg2 ch7_static_reg2_i = new();
ch7_static_reg3 ch7_static_reg3_i = new();
ch7_static_reg4 ch7_static_reg4_i = new();
ch7_restrict_reg ch7_restrict_reg_i = new();
ch7_read_offset_reg ch7_read_offset_reg_i = new();
ch7_write_offset_reg ch7_write_offset_reg_i = new();
ch7_fifo_fullness_reg ch7_fifo_fullness_reg_i = new();
ch7_cmd_outs_reg ch7_cmd_outs_reg_i = new();
ch7_ch_enable_reg ch7_ch_enable_reg_i = new();
ch7_ch_start_reg ch7_ch_start_reg_i = new();
ch7_ch_active_reg ch7_ch_active_reg_i = new();
ch7_count_reg ch7_count_reg_i = new();
ch7_int_rawstat_reg ch7_int_rawstat_reg_i = new();
ch7_int_clear_reg ch7_int_clear_reg_i = new();
ch7_int_enable_reg ch7_int_enable_reg_i = new();
ch7_int_status_reg ch7_int_status_reg_i = new();
int0_status int0_status_i = new();
core0_joint_mode core0_joint_mode_i = new();
core0_priority core0_priority_i = new();
core0_ch_start core0_ch_start_i = new();
periph_rx_ctrl periph_rx_ctrl_i = new();
periph_tx_ctrl periph_tx_ctrl_i = new();
idle idle_i = new();
user_def_status user_def_status_i = new();
user_core0_def_status0 user_core0_def_status0_i = new();
user_core0_def_status1 user_core0_def_status1_i = new();
	//Reset registers function
	function void reset_reg(); //this method is called from reference model, all register values will get reset
		ch0_cmd_reg0_i.reset();
		ch0_cmd_reg1_i.reset();
		ch0_cmd_reg2_i.reset();
		ch0_cmd_reg3_i.reset();
		ch0_static_reg0_i.reset();
		ch0_static_reg1_i.reset();
		ch0_static_reg2_i.reset();
		ch0_static_reg3_i.reset();
		ch0_static_reg4_i.reset();
		ch0_restrict_reg_i.reset();
		ch0_read_offset_reg_i.reset();
		ch0_write_offset_reg_i.reset();
		ch0_fifo_fullness_reg_i.reset();
		ch0_cmd_outs_reg_i.reset();
		ch0_ch_enable_reg_i.reset();
		ch0_ch_start_reg_i.reset();
		ch0_ch_active_reg_i.reset();
		ch0_count_reg_i.reset();
		ch0_int_rawstat_reg_i.reset();
		ch0_int_clear_reg_i.reset();
		ch0_int_enable_reg_i.reset();
		ch0_int_status_reg_i.reset();
		ch1_cmd_reg0_i.reset();
		ch1_cmd_reg1_i.reset();
		ch1_cmd_reg2_i.reset();
		ch1_cmd_reg3_i.reset();
		ch1_static_reg0_i.reset();
		ch1_static_reg1_i.reset();
		ch1_static_reg2_i.reset();
		ch1_static_reg3_i.reset();
		ch1_static_reg4_i.reset();
		ch1_restrict_reg_i.reset();
		ch1_read_offset_reg_i.reset();
		ch1_write_offset_reg_i.reset();
		ch1_fifo_fullness_reg_i.reset();
		ch1_cmd_outs_reg_i.reset();
		ch1_ch_enable_reg_i.reset();
		ch1_ch_start_reg_i.reset();
		ch1_ch_active_reg_i.reset();
		ch1_count_reg_i.reset();
		ch1_int_rawstat_reg_i.reset();
		ch1_int_clear_reg_i.reset();
		ch1_int_enable_reg_i.reset();
		ch1_int_status_reg_i.reset();
		ch2_cmd_reg0_i.reset();
		ch2_cmd_reg1_i.reset();
		ch2_cmd_reg2_i.reset();
		ch2_cmd_reg3_i.reset();
		ch2_static_reg0_i.reset();
		ch2_static_reg1_i.reset();
		ch2_static_reg2_i.reset();
		ch2_static_reg3_i.reset();
		ch2_static_reg4_i.reset();
		ch2_restrict_reg_i.reset();
		ch2_read_offset_reg_i.reset();
		ch2_write_offset_reg_i.reset();
		ch2_fifo_fullness_reg_i.reset();
		ch2_cmd_outs_reg_i.reset();
		ch2_ch_enable_reg_i.reset();
		ch2_ch_start_reg_i.reset();
		ch2_ch_active_reg_i.reset();
		ch2_count_reg_i.reset();
		ch2_int_rawstat_reg_i.reset();
		ch2_int_clear_reg_i.reset();
		ch2_int_enable_reg_i.reset();
		ch2_int_status_reg_i.reset();
		ch3_cmd_reg0_i.reset();
		ch3_cmd_reg1_i.reset();
		ch3_cmd_reg2_i.reset();
		ch3_cmd_reg3_i.reset();
		ch3_static_reg0_i.reset();
		ch3_static_reg1_i.reset();
		ch3_static_reg2_i.reset();
		ch3_static_reg3_i.reset();
		ch3_static_reg4_i.reset();
		ch3_restrict_reg_i.reset();
		ch3_read_offset_reg_i.reset();
		ch3_write_offset_reg_i.reset();
		ch3_fifo_fullness_reg_i.reset();
		ch3_cmd_outs_reg_i.reset();
		ch3_ch_enable_reg_i.reset();
		ch3_ch_start_reg_i.reset();
		ch3_ch_active_reg_i.reset();
		ch3_count_reg_i.reset();
		ch3_int_rawstat_reg_i.reset();
		ch3_int_clear_reg_i.reset();
		ch3_int_enable_reg_i.reset();
		ch3_int_status_reg_i.reset();
		ch4_cmd_reg0_i.reset();
		ch4_cmd_reg1_i.reset();
		ch4_cmd_reg2_i.reset();
		ch4_cmd_reg3_i.reset();
		ch4_static_reg0_i.reset();
		ch4_static_reg1_i.reset();
		ch4_static_reg2_i.reset();
		ch4_static_reg3_i.reset();
		ch4_static_reg4_i.reset();
		ch4_restrict_reg_i.reset();
		ch4_read_offset_reg_i.reset();
		ch4_write_offset_reg_i.reset();
		ch4_fifo_fullness_reg_i.reset();
		ch4_cmd_outs_reg_i.reset();
		ch4_ch_enable_reg_i.reset();
		ch4_ch_start_reg_i.reset();
		ch4_ch_active_reg_i.reset();
		ch4_count_reg_i.reset();
		ch4_int_rawstat_reg_i.reset();
		ch4_int_clear_reg_i.reset();
		ch4_int_enable_reg_i.reset();
		ch4_int_status_reg_i.reset();
		ch5_cmd_reg0_i.reset();
		ch5_cmd_reg1_i.reset();
		ch5_cmd_reg2_i.reset();
		ch5_cmd_reg3_i.reset();
		ch5_static_reg0_i.reset();
		ch5_static_reg1_i.reset();
		ch5_static_reg2_i.reset();
		ch5_static_reg3_i.reset();
		ch5_static_reg4_i.reset();
		ch5_restrict_reg_i.reset();
		ch5_read_offset_reg_i.reset();
		ch5_write_offset_reg_i.reset();
		ch5_fifo_fullness_reg_i.reset();
		ch5_cmd_outs_reg_i.reset();
		ch5_ch_enable_reg_i.reset();
		ch5_ch_start_reg_i.reset();
		ch5_ch_active_reg_i.reset();
		ch5_count_reg_i.reset();
		ch5_int_rawstat_reg_i.reset();
		ch5_int_clear_reg_i.reset();
		ch5_int_enable_reg_i.reset();
		ch5_int_status_reg_i.reset();
		ch6_cmd_reg0_i.reset();
		ch6_cmd_reg1_i.reset();
		ch6_cmd_reg2_i.reset();
		ch6_cmd_reg3_i.reset();
		ch6_static_reg0_i.reset();
		ch6_static_reg1_i.reset();
		ch6_static_reg2_i.reset();
		ch6_static_reg3_i.reset();
		ch6_static_reg4_i.reset();
		ch6_restrict_reg_i.reset();
		ch6_read_offset_reg_i.reset();
		ch6_write_offset_reg_i.reset();
		ch6_fifo_fullness_reg_i.reset();
		ch6_cmd_outs_reg_i.reset();
		ch6_ch_enable_reg_i.reset();
		ch6_ch_start_reg_i.reset();
		ch6_ch_active_reg_i.reset();
		ch6_count_reg_i.reset();
		ch6_int_rawstat_reg_i.reset();
		ch6_int_clear_reg_i.reset();
		ch6_int_enable_reg_i.reset();
		ch6_int_status_reg_i.reset();
		ch7_cmd_reg0_i.reset();
		ch7_cmd_reg1_i.reset();
		ch7_cmd_reg2_i.reset();
		ch7_cmd_reg3_i.reset();
		ch7_static_reg0_i.reset();
		ch7_static_reg1_i.reset();
		ch7_static_reg2_i.reset();
		ch7_static_reg3_i.reset();
		ch7_static_reg4_i.reset();
		ch7_restrict_reg_i.reset();
		ch7_read_offset_reg_i.reset();
		ch7_write_offset_reg_i.reset();
		ch7_fifo_fullness_reg_i.reset();
		ch7_cmd_outs_reg_i.reset();
		ch7_ch_enable_reg_i.reset();
		ch7_ch_start_reg_i.reset();
		ch7_ch_active_reg_i.reset();
		ch7_count_reg_i.reset();
		ch7_int_rawstat_reg_i.reset();
		ch7_int_clear_reg_i.reset();
		ch7_int_enable_reg_i.reset();
		ch7_int_status_reg_i.reset();
		int0_status_i.reset();
		core0_joint_mode_i.reset();
		core0_priority_i.reset();
		core0_ch_start_i.reset();
		periph_rx_ctrl_i.reset();
		periph_tx_ctrl_i.reset();
		idle_i.reset();
		user_def_status_i.reset();
		user_core0_def_status0_i.reset();
		user_core0_def_status1_i.reset();
	endfunction

	//Write registers function : write_reg called from reference model
	function void write_reg(reg [31:0] addr, reg[31:0] data);
		case(addr)
		`CH0_CMD_REG0 : ch0_cmd_reg0_i.write(data);
		`CH0_CMD_REG1 : ch0_cmd_reg1_i.write(data);
		`CH0_CMD_REG2 : ch0_cmd_reg2_i.write(data);
		`CH0_CMD_REG3 : ch0_cmd_reg3_i.write(data);
		`CH0_STATIC_REG0 : ch0_static_reg0_i.write(data);
		`CH0_STATIC_REG1 : ch0_static_reg1_i.write(data);
		`CH0_STATIC_REG2 : ch0_static_reg2_i.write(data);
		`CH0_STATIC_REG3 : ch0_static_reg3_i.write(data);
		`CH0_STATIC_REG4 : ch0_static_reg4_i.write(data);
		`CH0_RESTRICT_REG : ch0_restrict_reg_i.write(data);
		`CH0_READ_OFFSET_REG : ch0_read_offset_reg_i.write(data);
		`CH0_WRITE_OFFSET_REG : ch0_write_offset_reg_i.write(data);
		`CH0_FIFO_FULLNESS_REG : ch0_fifo_fullness_reg_i.write(data);
		`CH0_CMD_OUTS_REG : ch0_cmd_outs_reg_i.write(data);
		`CH0_CH_ENABLE_REG : ch0_ch_enable_reg_i.write(data);
		`CH0_CH_START_REG : ch0_ch_start_reg_i.write(data);
		`CH0_CH_ACTIVE_REG : ch0_ch_active_reg_i.write(data);
		`CH0_COUNT_REG : ch0_count_reg_i.write(data);
		`CH0_INT_RAWSTAT_REG : ch0_int_rawstat_reg_i.write(data);
		`CH0_INT_CLEAR_REG : ch0_int_clear_reg_i.write(data);
		`CH0_INT_ENABLE_REG : ch0_int_enable_reg_i.write(data);
		`CH0_INT_STATUS_REG : ch0_int_status_reg_i.write(data);
		`CH1_CMD_REG0 : ch1_cmd_reg0_i.write(data);
		`CH1_CMD_REG1 : ch1_cmd_reg1_i.write(data);
		`CH1_CMD_REG2 : ch1_cmd_reg2_i.write(data);
		`CH1_CMD_REG3 : ch1_cmd_reg3_i.write(data);
		`CH1_STATIC_REG0 : ch1_static_reg0_i.write(data);
		`CH1_STATIC_REG1 : ch1_static_reg1_i.write(data);
		`CH1_STATIC_REG2 : ch1_static_reg2_i.write(data);
		`CH1_STATIC_REG3 : ch1_static_reg3_i.write(data);
		`CH1_STATIC_REG4 : ch1_static_reg4_i.write(data);
		`CH1_RESTRICT_REG : ch1_restrict_reg_i.write(data);
		`CH1_READ_OFFSET_REG : ch1_read_offset_reg_i.write(data);
		`CH1_WRITE_OFFSET_REG : ch1_write_offset_reg_i.write(data);
		`CH1_FIFO_FULLNESS_REG : ch1_fifo_fullness_reg_i.write(data);
		`CH1_CMD_OUTS_REG : ch1_cmd_outs_reg_i.write(data);
		`CH1_CH_ENABLE_REG : ch1_ch_enable_reg_i.write(data);
		`CH1_CH_START_REG : ch1_ch_start_reg_i.write(data);
		`CH1_CH_ACTIVE_REG : ch1_ch_active_reg_i.write(data);
		`CH1_COUNT_REG : ch1_count_reg_i.write(data);
		`CH1_INT_RAWSTAT_REG : ch1_int_rawstat_reg_i.write(data);
		`CH1_INT_CLEAR_REG : ch1_int_clear_reg_i.write(data);
		`CH1_INT_ENABLE_REG : ch1_int_enable_reg_i.write(data);
		`CH1_INT_STATUS_REG : ch1_int_status_reg_i.write(data);
		`CH2_CMD_REG0 : ch2_cmd_reg0_i.write(data);
		`CH2_CMD_REG1 : ch2_cmd_reg1_i.write(data);
		`CH2_CMD_REG2 : ch2_cmd_reg2_i.write(data);
		`CH2_CMD_REG3 : ch2_cmd_reg3_i.write(data);
		`CH2_STATIC_REG0 : ch2_static_reg0_i.write(data);
		`CH2_STATIC_REG1 : ch2_static_reg1_i.write(data);
		`CH2_STATIC_REG2 : ch2_static_reg2_i.write(data);
		`CH2_STATIC_REG3 : ch2_static_reg3_i.write(data);
		`CH2_STATIC_REG4 : ch2_static_reg4_i.write(data);
		`CH2_RESTRICT_REG : ch2_restrict_reg_i.write(data);
		`CH2_READ_OFFSET_REG : ch2_read_offset_reg_i.write(data);
		`CH2_WRITE_OFFSET_REG : ch2_write_offset_reg_i.write(data);
		`CH2_FIFO_FULLNESS_REG : ch2_fifo_fullness_reg_i.write(data);
		`CH2_CMD_OUTS_REG : ch2_cmd_outs_reg_i.write(data);
		`CH2_CH_ENABLE_REG : ch2_ch_enable_reg_i.write(data);
		`CH2_CH_START_REG : ch2_ch_start_reg_i.write(data);
		`CH2_CH_ACTIVE_REG : ch2_ch_active_reg_i.write(data);
		`CH2_COUNT_REG : ch2_count_reg_i.write(data);
		`CH2_INT_RAWSTAT_REG : ch2_int_rawstat_reg_i.write(data);
		`CH2_INT_CLEAR_REG : ch2_int_clear_reg_i.write(data);
		`CH2_INT_ENABLE_REG : ch2_int_enable_reg_i.write(data);
		`CH2_INT_STATUS_REG : ch2_int_status_reg_i.write(data);
		`CH3_CMD_REG0 : ch3_cmd_reg0_i.write(data);
		`CH3_CMD_REG1 : ch3_cmd_reg1_i.write(data);
		`CH3_CMD_REG2 : ch3_cmd_reg2_i.write(data);
		`CH3_CMD_REG3 : ch3_cmd_reg3_i.write(data);
		`CH3_STATIC_REG0 : ch3_static_reg0_i.write(data);
		`CH3_STATIC_REG1 : ch3_static_reg1_i.write(data);
		`CH3_STATIC_REG2 : ch3_static_reg2_i.write(data);
		`CH3_STATIC_REG3 : ch3_static_reg3_i.write(data);
		`CH3_STATIC_REG4 : ch3_static_reg4_i.write(data);
		`CH3_RESTRICT_REG : ch3_restrict_reg_i.write(data);
		`CH3_READ_OFFSET_REG : ch3_read_offset_reg_i.write(data);
		`CH3_WRITE_OFFSET_REG : ch3_write_offset_reg_i.write(data);
		`CH3_FIFO_FULLNESS_REG : ch3_fifo_fullness_reg_i.write(data);
		`CH3_CMD_OUTS_REG : ch3_cmd_outs_reg_i.write(data);
		`CH3_CH_ENABLE_REG : ch3_ch_enable_reg_i.write(data);
		`CH3_CH_START_REG : ch3_ch_start_reg_i.write(data);
		`CH3_CH_ACTIVE_REG : ch3_ch_active_reg_i.write(data);
		`CH3_COUNT_REG : ch3_count_reg_i.write(data);
		`CH3_INT_RAWSTAT_REG : ch3_int_rawstat_reg_i.write(data);
		`CH3_INT_CLEAR_REG : ch3_int_clear_reg_i.write(data);
		`CH3_INT_ENABLE_REG : ch3_int_enable_reg_i.write(data);
		`CH3_INT_STATUS_REG : ch3_int_status_reg_i.write(data);
		`CH4_CMD_REG0 : ch4_cmd_reg0_i.write(data);
		`CH4_CMD_REG1 : ch4_cmd_reg1_i.write(data);
		`CH4_CMD_REG2 : ch4_cmd_reg2_i.write(data);
		`CH4_CMD_REG3 : ch4_cmd_reg3_i.write(data);
		`CH4_STATIC_REG0 : ch4_static_reg0_i.write(data);
		`CH4_STATIC_REG1 : ch4_static_reg1_i.write(data);
		`CH4_STATIC_REG2 : ch4_static_reg2_i.write(data);
		`CH4_STATIC_REG3 : ch4_static_reg3_i.write(data);
		`CH4_STATIC_REG4 : ch4_static_reg4_i.write(data);
		`CH4_RESTRICT_REG : ch4_restrict_reg_i.write(data);
		`CH4_READ_OFFSET_REG : ch4_read_offset_reg_i.write(data);
		`CH4_WRITE_OFFSET_REG : ch4_write_offset_reg_i.write(data);
		`CH4_FIFO_FULLNESS_REG : ch4_fifo_fullness_reg_i.write(data);
		`CH4_CMD_OUTS_REG : ch4_cmd_outs_reg_i.write(data);
		`CH4_CH_ENABLE_REG : ch4_ch_enable_reg_i.write(data);
		`CH4_CH_START_REG : ch4_ch_start_reg_i.write(data);
		`CH4_CH_ACTIVE_REG : ch4_ch_active_reg_i.write(data);
		`CH4_COUNT_REG : ch4_count_reg_i.write(data);
		`CH4_INT_RAWSTAT_REG : ch4_int_rawstat_reg_i.write(data);
		`CH4_INT_CLEAR_REG : ch4_int_clear_reg_i.write(data);
		`CH4_INT_ENABLE_REG : ch4_int_enable_reg_i.write(data);
		`CH4_INT_STATUS_REG : ch4_int_status_reg_i.write(data);
		`CH5_CMD_REG0 : ch5_cmd_reg0_i.write(data);
		`CH5_CMD_REG1 : ch5_cmd_reg1_i.write(data);
		`CH5_CMD_REG2 : ch5_cmd_reg2_i.write(data);
		`CH5_CMD_REG3 : ch5_cmd_reg3_i.write(data);
		`CH5_STATIC_REG0 : ch5_static_reg0_i.write(data);
		`CH5_STATIC_REG1 : ch5_static_reg1_i.write(data);
		`CH5_STATIC_REG2 : ch5_static_reg2_i.write(data);
		`CH5_STATIC_REG3 : ch5_static_reg3_i.write(data);
		`CH5_STATIC_REG4 : ch5_static_reg4_i.write(data);
		`CH5_RESTRICT_REG : ch5_restrict_reg_i.write(data);
		`CH5_READ_OFFSET_REG : ch5_read_offset_reg_i.write(data);
		`CH5_WRITE_OFFSET_REG : ch5_write_offset_reg_i.write(data);
		`CH5_FIFO_FULLNESS_REG : ch5_fifo_fullness_reg_i.write(data);
		`CH5_CMD_OUTS_REG : ch5_cmd_outs_reg_i.write(data);
		`CH5_CH_ENABLE_REG : ch5_ch_enable_reg_i.write(data);
		`CH5_CH_START_REG : ch5_ch_start_reg_i.write(data);
		`CH5_CH_ACTIVE_REG : ch5_ch_active_reg_i.write(data);
		`CH5_COUNT_REG : ch5_count_reg_i.write(data);
		`CH5_INT_RAWSTAT_REG : ch5_int_rawstat_reg_i.write(data);
		`CH5_INT_CLEAR_REG : ch5_int_clear_reg_i.write(data);
		`CH5_INT_ENABLE_REG : ch5_int_enable_reg_i.write(data);
		`CH5_INT_STATUS_REG : ch5_int_status_reg_i.write(data);
		`CH6_CMD_REG0 : ch6_cmd_reg0_i.write(data);
		`CH6_CMD_REG1 : ch6_cmd_reg1_i.write(data);
		`CH6_CMD_REG2 : ch6_cmd_reg2_i.write(data);
		`CH6_CMD_REG3 : ch6_cmd_reg3_i.write(data);
		`CH6_STATIC_REG0 : ch6_static_reg0_i.write(data);
		`CH6_STATIC_REG1 : ch6_static_reg1_i.write(data);
		`CH6_STATIC_REG2 : ch6_static_reg2_i.write(data);
		`CH6_STATIC_REG3 : ch6_static_reg3_i.write(data);
		`CH6_STATIC_REG4 : ch6_static_reg4_i.write(data);
		`CH6_RESTRICT_REG : ch6_restrict_reg_i.write(data);
		`CH6_READ_OFFSET_REG : ch6_read_offset_reg_i.write(data);
		`CH6_WRITE_OFFSET_REG : ch6_write_offset_reg_i.write(data);
		`CH6_FIFO_FULLNESS_REG : ch6_fifo_fullness_reg_i.write(data);
		`CH6_CMD_OUTS_REG : ch6_cmd_outs_reg_i.write(data);
		`CH6_CH_ENABLE_REG : ch6_ch_enable_reg_i.write(data);
		`CH6_CH_START_REG : ch6_ch_start_reg_i.write(data);
		`CH6_CH_ACTIVE_REG : ch6_ch_active_reg_i.write(data);
		`CH6_COUNT_REG : ch6_count_reg_i.write(data);
		`CH6_INT_RAWSTAT_REG : ch6_int_rawstat_reg_i.write(data);
		`CH6_INT_CLEAR_REG : ch6_int_clear_reg_i.write(data);
		`CH6_INT_ENABLE_REG : ch6_int_enable_reg_i.write(data);
		`CH6_INT_STATUS_REG : ch6_int_status_reg_i.write(data);
		`CH7_CMD_REG0 : ch7_cmd_reg0_i.write(data);
		`CH7_CMD_REG1 : ch7_cmd_reg1_i.write(data);
		`CH7_CMD_REG2 : ch7_cmd_reg2_i.write(data);
		`CH7_CMD_REG3 : ch7_cmd_reg3_i.write(data);
		`CH7_STATIC_REG0 : ch7_static_reg0_i.write(data);
		`CH7_STATIC_REG1 : ch7_static_reg1_i.write(data);
		`CH7_STATIC_REG2 : ch7_static_reg2_i.write(data);
		`CH7_STATIC_REG3 : ch7_static_reg3_i.write(data);
		`CH7_STATIC_REG4 : ch7_static_reg4_i.write(data);
		`CH7_RESTRICT_REG : ch7_restrict_reg_i.write(data);
		`CH7_READ_OFFSET_REG : ch7_read_offset_reg_i.write(data);
		`CH7_WRITE_OFFSET_REG : ch7_write_offset_reg_i.write(data);
		`CH7_FIFO_FULLNESS_REG : ch7_fifo_fullness_reg_i.write(data);
		`CH7_CMD_OUTS_REG : ch7_cmd_outs_reg_i.write(data);
		`CH7_CH_ENABLE_REG : ch7_ch_enable_reg_i.write(data);
		`CH7_CH_START_REG : ch7_ch_start_reg_i.write(data);
		`CH7_CH_ACTIVE_REG : ch7_ch_active_reg_i.write(data);
		`CH7_COUNT_REG : ch7_count_reg_i.write(data);
		`CH7_INT_RAWSTAT_REG : ch7_int_rawstat_reg_i.write(data);
		`CH7_INT_CLEAR_REG : ch7_int_clear_reg_i.write(data);
		`CH7_INT_ENABLE_REG : ch7_int_enable_reg_i.write(data);
		`CH7_INT_STATUS_REG : ch7_int_status_reg_i.write(data);
		`INT0_STATUS : int0_status_i.write(data);
		`CORE0_JOINT_MODE : core0_joint_mode_i.write(data);
		`CORE0_PRIORITY : core0_priority_i.write(data);
		`CORE0_CH_START : core0_ch_start_i.write(data);
		`PERIPH_RX_CTRL : periph_rx_ctrl_i.write(data);
		`PERIPH_TX_CTRL : periph_tx_ctrl_i.write(data);
		`IDLE : idle_i.write(data);
		`USER_DEF_STATUS : user_def_status_i.write(data);
		`USER_CORE0_DEF_STATUS0 : user_core0_def_status0_i.write(data);
		`USER_CORE0_DEF_STATUS1 : user_core0_def_status1_i.write(data);
		endcase
	endfunction

	//Read registers function
	function reg [31:0] read_reg(reg [31:0] addr);
		case(addr)
		`CH0_CMD_REG0 : return ch0_cmd_reg0_i.read(); //read will return the register value
		`CH0_CMD_REG1 : return ch0_cmd_reg1_i.read();
		`CH0_CMD_REG2 : return ch0_cmd_reg2_i.read();
		`CH0_CMD_REG3 : return ch0_cmd_reg3_i.read();
		`CH0_STATIC_REG0 : return ch0_static_reg0_i.read();
		`CH0_STATIC_REG1 : return ch0_static_reg1_i.read();
		`CH0_STATIC_REG2 : return ch0_static_reg2_i.read();
		`CH0_STATIC_REG3 : return ch0_static_reg3_i.read();
		`CH0_STATIC_REG4 : return ch0_static_reg4_i.read();
		`CH0_RESTRICT_REG : return ch0_restrict_reg_i.read();
		`CH0_READ_OFFSET_REG : return ch0_read_offset_reg_i.read();
		`CH0_WRITE_OFFSET_REG : return ch0_write_offset_reg_i.read();
		`CH0_FIFO_FULLNESS_REG : return ch0_fifo_fullness_reg_i.read();
		`CH0_CMD_OUTS_REG : return ch0_cmd_outs_reg_i.read();
		`CH0_CH_ENABLE_REG : return ch0_ch_enable_reg_i.read();
		`CH0_CH_START_REG : return ch0_ch_start_reg_i.read();
		`CH0_CH_ACTIVE_REG : return ch0_ch_active_reg_i.read();
		`CH0_COUNT_REG : return ch0_count_reg_i.read();
		`CH0_INT_RAWSTAT_REG : return ch0_int_rawstat_reg_i.read();
		`CH0_INT_CLEAR_REG : return ch0_int_clear_reg_i.read();
		`CH0_INT_ENABLE_REG : return ch0_int_enable_reg_i.read();
		`CH0_INT_STATUS_REG : return ch0_int_status_reg_i.read();
		`CH1_CMD_REG0 : return ch1_cmd_reg0_i.read();
		`CH1_CMD_REG1 : return ch1_cmd_reg1_i.read();
		`CH1_CMD_REG2 : return ch1_cmd_reg2_i.read();
		`CH1_CMD_REG3 : return ch1_cmd_reg3_i.read();
		`CH1_STATIC_REG0 : return ch1_static_reg0_i.read();
		`CH1_STATIC_REG1 : return ch1_static_reg1_i.read();
		`CH1_STATIC_REG2 : return ch1_static_reg2_i.read();
		`CH1_STATIC_REG3 : return ch1_static_reg3_i.read();
		`CH1_STATIC_REG4 : return ch1_static_reg4_i.read();
		`CH1_RESTRICT_REG : return ch1_restrict_reg_i.read();
		`CH1_READ_OFFSET_REG : return ch1_read_offset_reg_i.read();
		`CH1_WRITE_OFFSET_REG : return ch1_write_offset_reg_i.read();
		`CH1_FIFO_FULLNESS_REG : return ch1_fifo_fullness_reg_i.read();
		`CH1_CMD_OUTS_REG : return ch1_cmd_outs_reg_i.read();
		`CH1_CH_ENABLE_REG : return ch1_ch_enable_reg_i.read();
		`CH1_CH_START_REG : return ch1_ch_start_reg_i.read();
		`CH1_CH_ACTIVE_REG : return ch1_ch_active_reg_i.read();
		`CH1_COUNT_REG : return ch1_count_reg_i.read();
		`CH1_INT_RAWSTAT_REG : return ch1_int_rawstat_reg_i.read();
		`CH1_INT_CLEAR_REG : return ch1_int_clear_reg_i.read();
		`CH1_INT_ENABLE_REG : return ch1_int_enable_reg_i.read();
		`CH1_INT_STATUS_REG : return ch1_int_status_reg_i.read();
		`CH2_CMD_REG0 : return ch2_cmd_reg0_i.read();
		`CH2_CMD_REG1 : return ch2_cmd_reg1_i.read();
		`CH2_CMD_REG2 : return ch2_cmd_reg2_i.read();
		`CH2_CMD_REG3 : return ch2_cmd_reg3_i.read();
		`CH2_STATIC_REG0 : return ch2_static_reg0_i.read();
		`CH2_STATIC_REG1 : return ch2_static_reg1_i.read();
		`CH2_STATIC_REG2 : return ch2_static_reg2_i.read();
		`CH2_STATIC_REG3 : return ch2_static_reg3_i.read();
		`CH2_STATIC_REG4 : return ch2_static_reg4_i.read();
		`CH2_RESTRICT_REG : return ch2_restrict_reg_i.read();
		`CH2_READ_OFFSET_REG : return ch2_read_offset_reg_i.read();
		`CH2_WRITE_OFFSET_REG : return ch2_write_offset_reg_i.read();
		`CH2_FIFO_FULLNESS_REG : return ch2_fifo_fullness_reg_i.read();
		`CH2_CMD_OUTS_REG : return ch2_cmd_outs_reg_i.read();
		`CH2_CH_ENABLE_REG : return ch2_ch_enable_reg_i.read();
		`CH2_CH_START_REG : return ch2_ch_start_reg_i.read();
		`CH2_CH_ACTIVE_REG : return ch2_ch_active_reg_i.read();
		`CH2_COUNT_REG : return ch2_count_reg_i.read();
		`CH2_INT_RAWSTAT_REG : return ch2_int_rawstat_reg_i.read();
		`CH2_INT_CLEAR_REG : return ch2_int_clear_reg_i.read();
		`CH2_INT_ENABLE_REG : return ch2_int_enable_reg_i.read();
		`CH2_INT_STATUS_REG : return ch2_int_status_reg_i.read();
		`CH3_CMD_REG0 : return ch3_cmd_reg0_i.read();
		`CH3_CMD_REG1 : return ch3_cmd_reg1_i.read();
		`CH3_CMD_REG2 : return ch3_cmd_reg2_i.read();
		`CH3_CMD_REG3 : return ch3_cmd_reg3_i.read();
		`CH3_STATIC_REG0 : return ch3_static_reg0_i.read();
		`CH3_STATIC_REG1 : return ch3_static_reg1_i.read();
		`CH3_STATIC_REG2 : return ch3_static_reg2_i.read();
		`CH3_STATIC_REG3 : return ch3_static_reg3_i.read();
		`CH3_STATIC_REG4 : return ch3_static_reg4_i.read();
		`CH3_RESTRICT_REG : return ch3_restrict_reg_i.read();
		`CH3_READ_OFFSET_REG : return ch3_read_offset_reg_i.read();
		`CH3_WRITE_OFFSET_REG : return ch3_write_offset_reg_i.read();
		`CH3_FIFO_FULLNESS_REG : return ch3_fifo_fullness_reg_i.read();
		`CH3_CMD_OUTS_REG : return ch3_cmd_outs_reg_i.read();
		`CH3_CH_ENABLE_REG : return ch3_ch_enable_reg_i.read();
		`CH3_CH_START_REG : return ch3_ch_start_reg_i.read();
		`CH3_CH_ACTIVE_REG : return ch3_ch_active_reg_i.read();
		`CH3_COUNT_REG : return ch3_count_reg_i.read();
		`CH3_INT_RAWSTAT_REG : return ch3_int_rawstat_reg_i.read();
		`CH3_INT_CLEAR_REG : return ch3_int_clear_reg_i.read();
		`CH3_INT_ENABLE_REG : return ch3_int_enable_reg_i.read();
		`CH3_INT_STATUS_REG : return ch3_int_status_reg_i.read();
		`CH4_CMD_REG0 : return ch4_cmd_reg0_i.read();
		`CH4_CMD_REG1 : return ch4_cmd_reg1_i.read();
		`CH4_CMD_REG2 : return ch4_cmd_reg2_i.read();
		`CH4_CMD_REG3 : return ch4_cmd_reg3_i.read();
		`CH4_STATIC_REG0 : return ch4_static_reg0_i.read();
		`CH4_STATIC_REG1 : return ch4_static_reg1_i.read();
		`CH4_STATIC_REG2 : return ch4_static_reg2_i.read();
		`CH4_STATIC_REG3 : return ch4_static_reg3_i.read();
		`CH4_STATIC_REG4 : return ch4_static_reg4_i.read();
		`CH4_RESTRICT_REG : return ch4_restrict_reg_i.read();
		`CH4_READ_OFFSET_REG : return ch4_read_offset_reg_i.read();
		`CH4_WRITE_OFFSET_REG : return ch4_write_offset_reg_i.read();
		`CH4_FIFO_FULLNESS_REG : return ch4_fifo_fullness_reg_i.read();
		`CH4_CMD_OUTS_REG : return ch4_cmd_outs_reg_i.read();
		`CH4_CH_ENABLE_REG : return ch4_ch_enable_reg_i.read();
		`CH4_CH_START_REG : return ch4_ch_start_reg_i.read();
		`CH4_CH_ACTIVE_REG : return ch4_ch_active_reg_i.read();
		`CH4_COUNT_REG : return ch4_count_reg_i.read();
		`CH4_INT_RAWSTAT_REG : return ch4_int_rawstat_reg_i.read();
		`CH4_INT_CLEAR_REG : return ch4_int_clear_reg_i.read();
		`CH4_INT_ENABLE_REG : return ch4_int_enable_reg_i.read();
		`CH4_INT_STATUS_REG : return ch4_int_status_reg_i.read();
		`CH5_CMD_REG0 : return ch5_cmd_reg0_i.read();
		`CH5_CMD_REG1 : return ch5_cmd_reg1_i.read();
		`CH5_CMD_REG2 : return ch5_cmd_reg2_i.read();
		`CH5_CMD_REG3 : return ch5_cmd_reg3_i.read();
		`CH5_STATIC_REG0 : return ch5_static_reg0_i.read();
		`CH5_STATIC_REG1 : return ch5_static_reg1_i.read();
		`CH5_STATIC_REG2 : return ch5_static_reg2_i.read();
		`CH5_STATIC_REG3 : return ch5_static_reg3_i.read();
		`CH5_STATIC_REG4 : return ch5_static_reg4_i.read();
		`CH5_RESTRICT_REG : return ch5_restrict_reg_i.read();
		`CH5_READ_OFFSET_REG : return ch5_read_offset_reg_i.read();
		`CH5_WRITE_OFFSET_REG : return ch5_write_offset_reg_i.read();
		`CH5_FIFO_FULLNESS_REG : return ch5_fifo_fullness_reg_i.read();
		`CH5_CMD_OUTS_REG : return ch5_cmd_outs_reg_i.read();
		`CH5_CH_ENABLE_REG : return ch5_ch_enable_reg_i.read();
		`CH5_CH_START_REG : return ch5_ch_start_reg_i.read();
		`CH5_CH_ACTIVE_REG : return ch5_ch_active_reg_i.read();
		`CH5_COUNT_REG : return ch5_count_reg_i.read();
		`CH5_INT_RAWSTAT_REG : return ch5_int_rawstat_reg_i.read();
		`CH5_INT_CLEAR_REG : return ch5_int_clear_reg_i.read();
		`CH5_INT_ENABLE_REG : return ch5_int_enable_reg_i.read();
		`CH5_INT_STATUS_REG : return ch5_int_status_reg_i.read();
		`CH6_CMD_REG0 : return ch6_cmd_reg0_i.read();
		`CH6_CMD_REG1 : return ch6_cmd_reg1_i.read();
		`CH6_CMD_REG2 : return ch6_cmd_reg2_i.read();
		`CH6_CMD_REG3 : return ch6_cmd_reg3_i.read();
		`CH6_STATIC_REG0 : return ch6_static_reg0_i.read();
		`CH6_STATIC_REG1 : return ch6_static_reg1_i.read();
		`CH6_STATIC_REG2 : return ch6_static_reg2_i.read();
		`CH6_STATIC_REG3 : return ch6_static_reg3_i.read();
		`CH6_STATIC_REG4 : return ch6_static_reg4_i.read();
		`CH6_RESTRICT_REG : return ch6_restrict_reg_i.read();
		`CH6_READ_OFFSET_REG : return ch6_read_offset_reg_i.read();
		`CH6_WRITE_OFFSET_REG : return ch6_write_offset_reg_i.read();
		`CH6_FIFO_FULLNESS_REG : return ch6_fifo_fullness_reg_i.read();
		`CH6_CMD_OUTS_REG : return ch6_cmd_outs_reg_i.read();
		`CH6_CH_ENABLE_REG : return ch6_ch_enable_reg_i.read();
		`CH6_CH_START_REG : return ch6_ch_start_reg_i.read();
		`CH6_CH_ACTIVE_REG : return ch6_ch_active_reg_i.read();
		`CH6_COUNT_REG : return ch6_count_reg_i.read();
		`CH6_INT_RAWSTAT_REG : return ch6_int_rawstat_reg_i.read();
		`CH6_INT_CLEAR_REG : return ch6_int_clear_reg_i.read();
		`CH6_INT_ENABLE_REG : return ch6_int_enable_reg_i.read();
		`CH6_INT_STATUS_REG : return ch6_int_status_reg_i.read();
		`CH7_CMD_REG0 : return ch7_cmd_reg0_i.read();
		`CH7_CMD_REG1 : return ch7_cmd_reg1_i.read();
		`CH7_CMD_REG2 : return ch7_cmd_reg2_i.read();
		`CH7_CMD_REG3 : return ch7_cmd_reg3_i.read();
		`CH7_STATIC_REG0 : return ch7_static_reg0_i.read();
		`CH7_STATIC_REG1 : return ch7_static_reg1_i.read();
		`CH7_STATIC_REG2 : return ch7_static_reg2_i.read();
		`CH7_STATIC_REG3 : return ch7_static_reg3_i.read();
		`CH7_STATIC_REG4 : return ch7_static_reg4_i.read();
		`CH7_RESTRICT_REG : return ch7_restrict_reg_i.read();
		`CH7_READ_OFFSET_REG : return ch7_read_offset_reg_i.read();
		`CH7_WRITE_OFFSET_REG : return ch7_write_offset_reg_i.read();
		`CH7_FIFO_FULLNESS_REG : return ch7_fifo_fullness_reg_i.read();
		`CH7_CMD_OUTS_REG : return ch7_cmd_outs_reg_i.read();
		`CH7_CH_ENABLE_REG : return ch7_ch_enable_reg_i.read();
		`CH7_CH_START_REG : return ch7_ch_start_reg_i.read();
		`CH7_CH_ACTIVE_REG : return ch7_ch_active_reg_i.read();
		`CH7_COUNT_REG : return ch7_count_reg_i.read();
		`CH7_INT_RAWSTAT_REG : return ch7_int_rawstat_reg_i.read();
		`CH7_INT_CLEAR_REG : return ch7_int_clear_reg_i.read();
		`CH7_INT_ENABLE_REG : return ch7_int_enable_reg_i.read();
		`CH7_INT_STATUS_REG : return ch7_int_status_reg_i.read();
		`INT0_STATUS : return int0_status_i.read();
		`CORE0_JOINT_MODE : return core0_joint_mode_i.read();
		`CORE0_PRIORITY : return core0_priority_i.read();
		`CORE0_CH_START : return core0_ch_start_i.read();
		`PERIPH_RX_CTRL : return periph_rx_ctrl_i.read();
		`PERIPH_TX_CTRL : return periph_tx_ctrl_i.read();
		`IDLE : return idle_i.read();
		`USER_DEF_STATUS : return user_def_status_i.read();
		`USER_CORE0_DEF_STATUS0 : return user_core0_def_status0_i.read();
		`USER_CORE0_DEF_STATUS1 : return user_core0_def_status1_i.read();
		endcase
	endfunction
endclass
