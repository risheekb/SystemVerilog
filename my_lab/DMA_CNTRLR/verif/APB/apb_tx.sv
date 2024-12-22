class apb_tx;
  rand bit [12:0] addr;
  rand bit [31:0] data;
  rand bit wr_rd;
  bit apb_or_periph_f;


  function void print();
    $display("Printing the fields of APB TX");
    $display("addr = %h",addr);
    $display("data = %h",data);
    $display("wr_rd = %b",wr_rd);
  endfunction

  constraint apb_or_periph_c{
    soft apb_or_periph_f == 1; //by default it should be a apb_tx
  }
endclass
