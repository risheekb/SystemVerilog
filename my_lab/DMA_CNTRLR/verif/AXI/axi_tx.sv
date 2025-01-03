typedef enum {
  NO_OP,
  READ,
  WRITE,
  CMD
} wr_rd_t;

class axi_tx;
  rand wr_rd_t wr_rd;
  //WRITE PARAMETERS
  rand bit [31:0] wr_addr;
  rand bit [3:0] wr_len;
  rand bit [2:0] wr_size;
  rand bit [3:0] wr_id;
  rand bit [63:0] wr_data_q[$];
  rand bit [7:0] strb_q[$];
  rand bit [1:0] wr_resp;
  //READ PARAMETERS
  rand bit [31:0] rd_addr;
  rand bit [3:0] rd_len;
  rand bit [2:0] rd_size;
  rand bit [3:0] rd_id;
  rand bit [63:0] rd_data_q[$];
  rand bit [1:0] rd_resp;

  function void print;
    if(wr_rd == WRITE)begin
      $display("######### axi_tx: WRITE TX #########");
      $display("wr_id = %h",wr_id);
      $display("wr_addr = %h",wr_addr);
      foreach(wr_data_q[i])$display("wr_data_q[%0d] = %h",i,wr_data_q[i]);
      $display("strb_q = %p",strb_q);
      $display("wr_len = %h",wr_len);
      $display("wr_size = %h",wr_size);
    end
    if(wr_rd == READ)begin
      $display("######### axi_tx: READ TX #########");
      $display("rd_id = %h",wr_id);
      $display("rd_addr = %h",wr_addr);
      foreach(rd_data_q[i])$display("wr_data_q[%0d] = %h",i,wr_data_q[i]);
      $display("rd_len = %h",wr_len);
      $display("rd_size = %h",wr_size);
    end 
    $display("");
  endfunction

  constraint wr_rd_c{
    wr_rd != NO_OP;
  }
  constraint len_c{
    wr_data_q.size() == wr_len + 1;
    rd_data_q.size() == rd_len + 1;
  }
endclass
