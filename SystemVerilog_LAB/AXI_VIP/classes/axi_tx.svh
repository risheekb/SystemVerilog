class axi_tx;
  rand bit [31:0] addr;
  rand bit [63:0] dataQ[$];
  rand bit [3:0] len;
  rand lock_t lock;
  rand burst_size_t burst_size;
  rand bit [3:0] id;
  rand burst_t burst_type;
  rand bit [2:0] prot;
  rand bit [3:0] cache;
  rand resp_t resp;

  rand wr_rd_t wr_rd;

  constraint c_dataQ{
    dataQ.size() == len+1;
  }

  constraint c_addr_aligned{
    addr % 8 ==0;
  }

  constraint c_data{
    foreach(dataQ[i])
      dataQ[i] <= 64'hFFFF_FFFF_FFFF_FFFF >>(8*(8-2**int'(burst_size)));
  }

  constraint c_rsvd{
    burst_type != BURST_RSVD;
    lock != LOCK_RSVD;
  }

  constraint c_soft{
    soft resp == OKAY;
    soft burst_size <= BURST_SIZE_8_BYTE;
    soft burst_type == INCR;
  }

  function void print(string s="");
    $display("###############################");
    $display("####%s:    axi_tx::print   ####",s);
    $display("###############################");
    $display("addr = %0h",addr);
    $display("dataQ = %p",dataQ);
    $display("len = %0d",len);
    $display("wr_rd = %s",wr_rd);
    $display("lock = %s",lock);
    $display("Burst Size = %s",burst_size);
    $display("id =%h",id);
    $display("Burst Type =%s",burst_type);
    $display("Prot = %h",prot);
    $display("Cache = %h",cache);
    $display("Resp = %s",resp);

  endfunction
endclass
