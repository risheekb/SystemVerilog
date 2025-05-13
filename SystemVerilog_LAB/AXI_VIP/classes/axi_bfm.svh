class axi_bfm;

  axi_tx tx;
  virtual axi_inf vif;

  function new();
  endfunction
  virtual task run();
    $display("axi_bfm::run");
    vif = axi_common::vif;
    forever begin 
      axi_common::gen2bfm.get(tx);
      //tx.print();
      drive_tx(tx);
      axi_common::total_driven_tx_count++;
    end
  endtask

  task drive_tx(axi_tx tx);
    case(tx.wr_rd)
      WRITE: begin
        write_addr_phase(tx);
        write_data_phase(tx);
        write_resp_phase();
      end
      READ:begin
        read_addr_phase(tx);
        read_data_phase(tx);
      end
    endcase
  endtask

  task write_addr_phase(axi_tx tx);
    $display("write_addr_phase");
    @(posedge vif.aclk);
    vif.awvalid = 1'b1;
    vif.awid = tx.id;
    vif.awaddr = tx.addr;
    vif.awlen = tx.len;
    vif.awsize = tx.burst_size;
    vif.awburst = tx.burst_type;
    vif.awlock = tx.lock;
    vif.awcache = tx.cache;
    vif.awprot = tx.prot;
    wait(vif.awready == 1);
    @(posedge vif.aclk);
    vif.awid = 0;
    vif.awaddr = 0;
    vif.awlen = 0;
    vif.awsize = 0;
    vif.awburst = 0;
    vif.awlock = 0;
    vif.awcache = 0;
    vif.awprot = 0;
    vif.awvalid = 0;

  endtask
  task write_data_phase(axi_tx tx);
    $display("write_data_phase");
    for(int i = 0;i<= tx.len;i++) begin
      @(posedge vif.aclk);
      vif.wdata = tx.dataQ.pop_front();
      vif.wid = tx.id;
      vif.wstrb = 4'hf;
      vif.wlast  = (i == tx.len) ? 1'b1 : 1'b0;
      vif.wvalid = 1'b1;
      wait(vif.wready == 1'b1);
    end
    @(posedge vif.aclk);
    vif.wdata = 0;
    vif.wid = 0;
    vif.wstrb = 0;
    vif.wlast = 0;
    vif.wvalid = 0;
  endtask

//  task write_resp_phase();
//    $display("write_resp_phase");
//    while(vif.bvalid == 0) begin
//      @(posedge vif.aclk);
//      vif.bready = 1'b1;
//    end
//    @(posedge vif.aclk);
//    vif.bready = 1'b0;  
//  endtask
        task write_resp_phase();
          $display("write resp phase");
          $display("%m %b",vif.bvalid);
          while (vif.bvalid == 0) begin
	        @(posedge vif.aclk);
          end
  	        vif.bready = 1;
 			@(posedge vif.aclk); begin
              vif.bready = 0;

  end
    endtask

  task read_addr_phase(axi_tx tx);
    $display("read_addr_phase");
    @(posedge vif.aclk);
    vif.arvalid = 1'b1;
    vif.arid = tx.id;
    vif.araddr = tx.addr;
    vif.arlen = tx.len;
    vif.arsize = tx.burst_size;
    vif.arburst = tx.burst_type;
    vif.arlock = tx.lock;
    vif.arcache = tx.cache;
    vif.arprot = tx.prot;
    wait(vif.arready == 1);
    @(posedge vif.aclk);
    vif.arid = 0;
    vif.araddr = 0;
    vif.arlen = 0;
    vif.arsize = 0;
    vif.arburst = 0;
    vif.arlock = 0;
    vif.arcache = 0;
    vif.arprot = 0;
    vif.arvalid = 0;
  endtask
  task read_data_phase(axi_tx tx);
    $display("read_data_phase");
    tx.dataQ.delete();
    for(int i =0;i<=tx.len;i++) begin
   	  while(vif.rvalid == 0) begin
        @(posedge vif.aclk);
      end
      tx.dataQ.push_back(vif.rdata);
      vif.rready = 1'b1;
      @(posedge vif.aclk);
      vif.rready = 1'b0;
    end
  endtask
endclass
