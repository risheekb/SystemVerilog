class Coverage extends Component;

  virtual fifo_inf vif;

  covergroup cg1 @(posedge vif.clk);
    cp_full:coverpoint vif.full;
    cp_empty:coverpoint vif.empty;
    cp_reset:coverpoint vif.reset;
    cp_clear:coverpoint vif.clear;
    cp_almost_full:coverpoint vif.almost_full;
    cp_almost_empty:coverpoint vif.almost_empty;
    cp_read:coverpoint vif.read;
    cp_write:coverpoint vif.write;
    
    cp_count:coverpoint vif.cnt{
      bins count[] = {[DEPTH:0]};
    }

    cp_data_in: coverpoint vif.data_in{
      bins low = {0};
      bins mid[10] = {[1:$]};
      bins high = {'1};
    }
    cp_data_out: coverpoint vif.data_out{
      bins low = {0};
      bins mid[10] = {[1:$]};
      bins high = {'1};
    }

    cp_write_full:cross cp_full,cp_write;
    cp_read_empty:cross cp_empty,cp_read;
    cp_read_write:cross cp_read,cp_write;



  endgroup

  function new(virtual fifo_inf vif);
    this.vif = vif;
    cg1 = new();
  endfunction


  virtual task run(int n);
    cg1.sample();
  endtask


endclass
