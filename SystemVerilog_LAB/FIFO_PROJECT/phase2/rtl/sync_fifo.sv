module fifo #(parameter DEPTH = 8, parameter WIDTH=32)(
  input clk,
  input clear,
  input write,
  input read,
  input reset,
  input [WIDTH-1:0] data_in,
  output full,
  output almost_full,
  output empty,
  output almost_empty,
  output reg [$clog2(DEPTH):0] cnt,
  output reg [WIDTH-1:0] data_out);


  reg [WIDTH-1:0] memory [0:DEPTH-1]; //memory declaration. 
  reg [$clog2(DEPTH)-1:0] write_pointer ; //write_pointer for writing into the memory.
  reg [$clog2(DEPTH)-1:0] read_pointer ; //read_pointer for reading from the memory.
  
  assign full = (cnt == DEPTH); //asserting full flag when count is equal to FIFO DEPTH.
  assign empty = (cnt == 0); //asserting the empty flag when there is no element in the FIFO.
  assign almost_full = (cnt == (DEPTH -1)); //asserting almost_full when count is equal to one less than DEPTH.
  assign almost_empty = (cnt == 1); //asserting almost_empty when there is only one element in the FIFO.


  always @(posedge clk or posedge reset) begin //asynchronous active high reset signal.
    if(reset || clear) begin
      write_pointer <= 0;
      read_pointer <= 0;
      data_out <= 0;
      cnt <= 0;
      //reset memory contents
      for(integer i = 0 ; i < DEPTH;i=i+1) begin
          memory[i] <= '0;
      end
    end
    else begin
      if(write && !read && !full) begin
        cnt <= cnt + 1'b1;
        memory[write_pointer] <= data_in;
        write_pointer <= write_pointer + 1'b1;
      end
      if(read && !write && !empty) begin
        cnt <= cnt - 1'b1;
        data_out <= memory[read_pointer];
        read_pointer <= read_pointer + 1'b1;
      end
    end
  end

endmodule: fifo
