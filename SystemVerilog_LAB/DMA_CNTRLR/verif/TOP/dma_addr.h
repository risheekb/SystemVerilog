//ADDRESS FOR COMMAND LIST TEST CASE
`define CMD1_ADDR               32'h3000_0000
`define CMD2_ADDR               `CMD1_ADDR +'h10 //total command = 128bits  = 16Bytes = 'h10
`define CMD3_ADDR               `CMD1_ADDR +'h20
`define CMD4_ADDR               `CMD1_ADDR +'h30
`define CMD1_BUFFER_SIZE        256
`define CMD2_BUFFER_SIZE        256
`define CMD3_BUFFER_SIZE        128
`define CMD4_BUFFER_SIZE        128

`define CMD1_RD_START_ADDR      `CH0_RD_START+'h200
`define CMD1_WR_START_ADDR      `CH0_WR_START+'h200
`define CMD2_RD_START_ADDR      `CH0_RD_START+'h400
`define CMD2_WR_START_ADDR      `CH0_WR_START+'h400
`define CMD3_RD_START_ADDR      `CH0_RD_START+'h600
`define CMD3_WR_START_ADDR      `CH0_WR_START+'h600
`define CMD4_RD_START_ADDR      `CH0_RD_START+'h800
`define CMD4_WR_START_ADDR      `CH0_WR_START+'h800
//CHANNEL START AND END ADDRESS
//CHANNEL START AND END ADDRESS
`define CH0_RD_START            32'h1000_0000
`define CH0_RD_END              `CH0_RD_START + 32'hFFFF
`define CH1_RD_START            `CH0_RD_START +32'h1_0000//32'h1001_0000
`define CH1_RD_END              `CH1_RD_START + 32'hFFFF
`define CH2_RD_START            `CH0_RD_START +32'h2_0000//32'h1002_0000
`define CH2_RD_END              `CH2_RD_START + 32'hFFFF
`define CH3_RD_START            `CH0_RD_START +32'h3_0000//32'h1003_0000
`define CH3_RD_END              `CH3_RD_START + 32'hFFFF
`define CH4_RD_START            `CH0_RD_START +32'h4_0000//32'h1004_0000
`define CH4_RD_END              `CH4_RD_START + 32'hFFFF
`define CH5_RD_START            `CH0_RD_START +32'h5_0000//32'h1005_0000
`define CH5_RD_END              `CH5_RD_START + 32'hFFFF
`define CH6_RD_START            `CH0_RD_START +32'h6_0000//32'h1006_0000
`define CH6_RD_END              `CH6_RD_START + 32'hFFFF
`define CH7_RD_START            `CH0_RD_START +32'h7_0000//32'h1007_0000
`define CH7_RD_END              `CH7_RD_START + 32'hFFFF

`define CH0_WR_START            32'h2000_0000
`define CH0_WR_END              `CH0_WR_START + 32'hFFFF
`define CH1_WR_START            `CH0_WR_START +32'h1_0000//32'h1001_0000
`define CH1_WR_END              `CH1_WR_START + 32'hFFFF
`define CH2_WR_START            `CH0_WR_START +32'h2_0000//32'h1002_0000
`define CH2_WR_END              `CH2_WR_START + 32'hFFFF
`define CH3_WR_START            `CH0_WR_START +32'h3_0000//32'h1003_0000
`define CH3_WR_END              `CH3_WR_START + 32'hFFFF
`define CH4_WR_START            `CH0_WR_START +32'h4_0000//32'h1004_0000
`define CH4_WR_END              `CH4_WR_START + 32'hFFFF
`define CH5_WR_START            `CH0_WR_START +32'h5_0000//32'h1005_0000
`define CH5_WR_END              `CH5_WR_START + 32'hFFFF
`define CH6_WR_START            `CH0_WR_START +32'h6_0000//32'h1006_0000
`define CH6_WR_END              `CH6_WR_START + 32'hFFFF
`define CH7_WR_START            `CH0_WR_START +32'h7_0000//32'h1007_0000
`define CH7_WR_END              `CH7_WR_START + 32'hFFFF
//CH0 REGISTERS//
`define CH0_CMD_REG0            13'h0
`define CH0_CMD_REG1            13'h4
`define CH0_CMD_REG2            13'h8
`define CH0_CMD_REG3            13'hC
`define CH0_STATIC_REG0         13'h10
`define CH0_STATIC_REG1         13'h14
`define CH0_STATIC_REG2         13'h18
`define CH0_STATIC_REG3         13'h1C
`define CH0_STATIC_REG4         13'h20
`define CH0_RESTRICT_REG        13'h2C
`define CH0_READ_OFFSET_REG     13'h30
`define CH0_WRITE_OFFSET_REG    13'h34
`define CH0_FIFO_FULLNESS_REG   13'h38
`define CH0_CMD_OUTS_REG            13'h3C
`define CH0_CH_ENABLE_REG       13'h40
`define CH0_CH_START_REG        13'h44
`define CH0_CH_ACTIVE_REG       13'h48
`define CH0_COUNT_REG           13'h50
`define CH0_INT_RAWSTAT_REG     13'hA0
`define CH0_INT_CLEAR_REG       13'hA4
`define CH0_INT_ENABLE_REG      13'hA8
`define CH0_INT_STATUS_REG      13'hAC
//CHANNEL 1 REGISTERS
`define CH1_CMD_REG0            13'h100+32'h0
`define CH1_CMD_REG1            13'h100+32'h4
`define CH1_CMD_REG2            13'h100+32'h8
`define CH1_CMD_REG3            13'h100+32'hC
`define CH1_STATIC_REG0         13'h100+32'h10
`define CH1_STATIC_REG1         13'h100+32'h14
`define CH1_STATIC_REG2         13'h100+32'h18
`define CH1_STATIC_REG3         13'h100+32'h1C
`define CH1_STATIC_REG4         13'h100+32'h20
`define CH1_RESTRICT_REG        13'h100+32'h2C
`define CH1_READ_OFFSET_REG     13'h100+32'h30
`define CH1_WRITE_OFFSET_REG    13'h100+32'h34
`define CH1_FIFO_FULLNESS_REG   13'h100+32'h38
`define CH1_CMD_OUTS_REG            13'h100+32'h3C
`define CH1_CH_ENABLE_REG       13'h100+32'h40
`define CH1_CH_START_REG        13'h100+32'h44
`define CH1_CH_ACTIVE_REG       13'h100+32'h48
`define CH1_COUNT_REG           13'h100+32'h50
`define CH1_INT_RAWSTAT_REG     13'h100+32'hA0
`define CH1_INT_CLEAR_REG       13'h100+32'hA4
`define CH1_INT_ENABLE_REG      13'h100+32'hA8
`define CH1_INT_STATUS_REG      13'h100+32'hAC
//CHANNEL 2 REGISTERS
`define CH2_CMD_REG0            13'h200+32'h0
`define CH2_CMD_REG1            13'h200+32'h4
`define CH2_CMD_REG2            13'h200+32'h8
`define CH2_CMD_REG3            13'h200+32'hC
`define CH2_STATIC_REG0         13'h200+32'h10
`define CH2_STATIC_REG1         13'h200+32'h14
`define CH2_STATIC_REG2         13'h200+32'h18
`define CH2_STATIC_REG3         13'h200+32'h1C
`define CH2_STATIC_REG4         13'h200+32'h20
`define CH2_RESTRICT_REG        13'h200+32'h2C
`define CH2_READ_OFFSET_REG     13'h200+32'h30
`define CH2_WRITE_OFFSET_REG    13'h200+32'h34
`define CH2_FIFO_FULLNESS_REG   13'h200+32'h38
`define CH2_CMD_OUTS_REG            13'h200+32'h3C
`define CH2_CH_ENABLE_REG       13'h200+32'h40
`define CH2_CH_START_REG        13'h200+32'h44
`define CH2_CH_ACTIVE_REG       13'h200+32'h48
`define CH2_COUNT_REG           13'h200+32'h50
`define CH2_INT_RAWSTAT_REG     13'h200+32'hA0
`define CH2_INT_CLEAR_REG       13'h200+32'hA4
`define CH2_INT_ENABLE_REG      13'h200+32'hA8
`define CH2_INT_STATUS_REG      13'h200+32'hAC
//CHANNEL 3 REGISTERS
`define CH3_CMD_REG0            13'h300+32'h0
`define CH3_CMD_REG1            13'h300+32'h4
`define CH3_CMD_REG2            13'h300+32'h8
`define CH3_CMD_REG3            13'h300+32'hC
`define CH3_STATIC_REG0         13'h300+32'h10
`define CH3_STATIC_REG1         13'h300+32'h14
`define CH3_STATIC_REG2         13'h300+32'h18
`define CH3_STATIC_REG3         13'h300+32'h1C
`define CH3_STATIC_REG4         13'h300+32'h20
`define CH3_RESTRICT_REG        13'h300+32'h2C
`define CH3_READ_OFFSET_REG     13'h300+32'h30
`define CH3_WRITE_OFFSET_REG    13'h300+32'h34
`define CH3_FIFO_FULLNESS_REG   13'h300+32'h38
`define CH3_CMD_OUTS_REG            13'h300+32'h3C
`define CH3_CH_ENABLE_REG       13'h300+32'h40
`define CH3_CH_START_REG        13'h300+32'h44
`define CH3_CH_ACTIVE_REG       13'h300+32'h48
`define CH3_COUNT_REG           13'h300+32'h50
`define CH3_INT_RAWSTAT_REG     13'h300+32'hA0
`define CH3_INT_CLEAR_REG       13'h300+32'hA4
`define CH3_INT_ENABLE_REG      13'h300+32'hA8
`define CH3_INT_STATUS_REG      13'h300+32'hAC
//CHANNEL 4 REGISTERS
`define CH4_CMD_REG0            13'h400+32'h0
`define CH4_CMD_REG1            13'h400+32'h4
`define CH4_CMD_REG2            13'h400+32'h8
`define CH4_CMD_REG3            13'h400+32'hC
`define CH4_STATIC_REG0         13'h400+32'h10
`define CH4_STATIC_REG1         13'h400+32'h14
`define CH4_STATIC_REG2         13'h400+32'h18
`define CH4_STATIC_REG3         13'h400+32'h1C
`define CH4_STATIC_REG4         13'h400+32'h20
`define CH4_RESTRICT_REG        13'h400+32'h2C
`define CH4_READ_OFFSET_REG     13'h400+32'h30
`define CH4_WRITE_OFFSET_REG    13'h400+32'h34
`define CH4_FIFO_FULLNESS_REG   13'h400+32'h38
`define CH4_CMD_OUTS_REG            13'h400+32'h3C
`define CH4_CH_ENABLE_REG       13'h400+32'h40
`define CH4_CH_START_REG        13'h400+32'h44
`define CH4_CH_ACTIVE_REG       13'h400+32'h48
`define CH4_COUNT_REG           13'h400+32'h50
`define CH4_INT_RAWSTAT_REG     13'h400+32'hA0
`define CH4_INT_CLEAR_REG       13'h400+32'hA4
`define CH4_INT_ENABLE_REG      13'h400+32'hA8
`define CH4_INT_STATUS_REG      13'h400+32'hAC
//CHANNEL 5 REGISTERS
`define CH5_CMD_REG0            13'h500+32'h0
`define CH5_CMD_REG1            13'h500+32'h4
`define CH5_CMD_REG2            13'h500+32'h8
`define CH5_CMD_REG3            13'h500+32'hC
`define CH5_STATIC_REG0         13'h500+32'h10
`define CH5_STATIC_REG1         13'h500+32'h14
`define CH5_STATIC_REG2         13'h500+32'h18
`define CH5_STATIC_REG3         13'h500+32'h1C
`define CH5_STATIC_REG4         13'h500+32'h20
`define CH5_RESTRICT_REG        13'h500+32'h2C
`define CH5_READ_OFFSET_REG     13'h500+32'h30
`define CH5_WRITE_OFFSET_REG    13'h500+32'h34
`define CH5_FIFO_FULLNESS_REG   13'h500+32'h38
`define CH5_CMD_OUTS_REG            13'h500+32'h3C
`define CH5_CH_ENABLE_REG       13'h500+32'h40
`define CH5_CH_START_REG        13'h500+32'h44
`define CH5_CH_ACTIVE_REG       13'h500+32'h48
`define CH5_COUNT_REG           13'h500+32'h50
`define CH5_INT_RAWSTAT_REG     13'h500+32'hA0
`define CH5_INT_CLEAR_REG       13'h500+32'hA4
`define CH5_INT_ENABLE_REG      13'h500+32'hA8
`define CH5_INT_STATUS_REG      13'h500+32'hAC
//CHANNEL 6 REGISTERS
`define CH6_CMD_REG0            13'h600+32'h0
`define CH6_CMD_REG1            13'h600+32'h4
`define CH6_CMD_REG2            13'h600+32'h8
`define CH6_CMD_REG3            13'h600+32'hC
`define CH6_STATIC_REG0         13'h600+32'h10
`define CH6_STATIC_REG1         13'h600+32'h14
`define CH6_STATIC_REG2         13'h600+32'h18
`define CH6_STATIC_REG3         13'h600+32'h1C
`define CH6_STATIC_REG4         13'h600+32'h20
`define CH6_RESTRICT_REG        13'h600+32'h2C
`define CH6_READ_OFFSET_REG     13'h600+32'h30
`define CH6_WRITE_OFFSET_REG    13'h600+32'h34
`define CH6_FIFO_FULLNESS_REG   13'h600+32'h38
`define CH6_CMD_OUTS_REG            13'h600+32'h3C
`define CH6_CH_ENABLE_REG       13'h600+32'h40
`define CH6_CH_START_REG        13'h600+32'h44
`define CH6_CH_ACTIVE_REG       13'h600+32'h48
`define CH6_COUNT_REG           13'h600+32'h50
`define CH6_INT_RAWSTAT_REG     13'h600+32'hA0
`define CH6_INT_CLEAR_REG       13'h600+32'hA4
`define CH6_INT_ENABLE_REG      13'h600+32'hA8
`define CH6_INT_STATUS_REG      13'h600+32'hAC
//CHANNEL 7 REGISTERS
`define CH7_CMD_REG0            13'h700+32'h0
`define CH7_CMD_REG1            13'h700+32'h4
`define CH7_CMD_REG2            13'h700+32'h8
`define CH7_CMD_REG3            13'h700+32'hC
`define CH7_STATIC_REG0         13'h700+32'h10
`define CH7_STATIC_REG1         13'h700+32'h14
`define CH7_STATIC_REG2         13'h700+32'h18
`define CH7_STATIC_REG3         13'h700+32'h1C
`define CH7_STATIC_REG4         13'h700+32'h20
`define CH7_RESTRICT_REG        13'h700+32'h2C
`define CH7_READ_OFFSET_REG     13'h700+32'h30
`define CH7_WRITE_OFFSET_REG    13'h700+32'h34
`define CH7_FIFO_FULLNESS_REG   13'h700+32'h38
`define CH7_CMD_OUTS_REG            13'h700+32'h3C
`define CH7_CH_ENABLE_REG       13'h700+32'h40
`define CH7_CH_START_REG        13'h700+32'h44
`define CH7_CH_ACTIVE_REG       13'h700+32'h48
`define CH7_COUNT_REG           13'h700+32'h50
`define CH7_INT_RAWSTAT_REG     13'h700+32'hA0
`define CH7_INT_CLEAR_REG       13'h700+32'hA4
`define CH7_INT_ENABLE_REG      13'h700+32'hA8
`define CH7_INT_STATUS_REG      13'h700+32'hAC
//SHARED REGISTERS
`define INT0_STATUS             13'h1000
`define INT1_STATUS             13'h1004
`define INT2_STATUS             13'h1008
`define INT3_STATUS             13'h100C
`define INT4_STATUS             13'h1010
`define INT5_STATUS             13'h1014
`define INT6_STATUS             13'h1018
`define INT7_STATUS             13'h101C
`define CORE0_JOINT_MODE        13'h1030
`define CORE1_JOINT_MODE        13'h1034
`define CORE0_PRIORITY          13'h1038
`define CORE1_PRIORITY          13'h103C
`define CORE0_CLKDIV            13'h1040
`define CORE1_CLKDIV            13'h1044
`define CORE0_CH_START          13'h1048
`define PERIPH_RX_CTRL          13'h1050
`define PERIPH_TX_CTRL          13'h1054
`define IDLE                    13'h10D0
`define USER_DEF_STATUS         13'h10E0
`define USER_CORE0_DEF_STATUS0  13'h10F0
`define USER_CORE0_DEF_STATUS1  13'h10F4

//STATIC_REG0 
  static bit [9:0]  rd_burst_max_size_a       [7:0];
  static bit        rd_allow_full_burst_a     [7:0];
  static bit        rd_allow_full_fifo_a      [7:0];
  static bit [5:0]  rd_tokens_a               [7:0];
  static bit [3:0]  rd_outs_max_a             [7:0];
  static bit        rd_outstanding_a          [7:0];
  static bit        rd_incr_a                 [7:0];
  //STATIC_REG1 
  static bit [9:0]  wr_burst_max_size_a       [7:0];
  static bit        wr_allow_full_burst_a     [7:0];
  static bit        wr_allow_full_fifo_a      [7:0];
  static bit [5:0]  wr_tokens_a               [7:0];
  static bit [3:0]  wr_outs_max_a             [7:0];
  static bit        wr_outstanding_a          [7:0];
  static bit        wr_incr_a                 [7:0];
  //STATIC_REG2
  static bit [11:0] frame_width_a             [7:0];
  static bit        block_a                   [7:0];
  static bit        joint_a                   [7:0];
  static bit        auto_retry_a              [7:0];
  static bit        rd_cmd_port_num_a         [7:0];
  static bit        rd_port_num_a             [7:0];
  static bit        wr_port_num_a             [7:0];
  static bit [2:0]  int_num_a                 [7:0];
  static bit [1:0]  end_swap_a                [7:0];
  //STATIC_REG3
  static bit [11:0] rd_wait_limit_a           [7:0];
  static bit [11:0] wr_wait_limit_a           [7:0];
  //STATIC_REG4
  static bit [4:0]  rd_periph_num_a           [7:0];
  static bit [2:0]  rd_periph_delay_a         [7:0];
  static bit        rd_periph_block_a         [7:0];
  static bit [4:0]  wr_periph_num_a           [7:0];
  static bit [2:0]  wr_periph_delay_a         [7:0];
  static bit        wr_periph_block_a         [7:0];
  //CMD_REG2 
  static bit [31:0] rd_addr_a                 [7:0];
  static bit [31:0] wr_addr_a                 [7:0];
  static bit [15:0] buffer_size_a             [7:0];
  static bit [7:0]  x_size_a                  [7:0];
  static bit [7:0]  y_size_a                  [7:0];
  //CMD_REG3
  static bit        cmd_set_int_a             [7:0];
  static bit        cmd_last_a                [7:0];
  static bit [27:0] cmd_next_addr_a           [7:0];
  static bit        int_enable_ch_end_a       [7:0];
  static bit        int_enable_rd_decerr_a    [7:0];
  static bit        int_enable_rd_slverr_a    [7:0];
  static bit        int_enable_wr_decerr_a    [7:0];
  static bit        int_enable_wr_slverr_a    [7:0];
  static bit        int_enable_overflow_a     [7:0];
  static bit        int_enable_underflow_a    [7:0];
  static bit        int_enable_timeout_r_a    [7:0];
  static bit        int_enable_timeout_ar_a   [7:0];
  static bit        int_enable_timeout_b_a    [7:0];
  static bit        int_enable_timeout_w_a    [7:0];
  static bit        int_enable_timeout_aw_a   [7:0];
  static bit        int_enable_wdt_a          [7:0];
  static bit        ch_start_reg_a            [7:0];
  static bit        ch_enable_reg_a           [7:0];
