module DualPortRam
  import ram_pkg::*;
  (input logic clk,
  input logic [ADDR_WIDTH-1:0] addr,
  input logic [DATA_WIDTH-1:0] data_in,
  input logic cs,
  input logic we,
  input logic oe,
  output logic [DATA_WIDTH-1:0] data_out);

  reg [DATA_WIDTH-1:0] MEM [DEPTH];
  reg [DATA_WIDTH-1:0] temp_data;

  always_ff @(posedge clk) begin
    if(cs & we)
      MEM[addr] <= data_in;
  end

  always_ff @(posedge clk) begin
    if(cs & !we & oe)
      data_out <= MEM[addr];
    else
      data_out <= 'hz;
  end

  //assign data_out = cs & oe & !we ? temp_data : 'hz;

endmodule

