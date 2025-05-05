class tx_sequence extends uvm_sequence #(tx_item);

  `uvm_object_utils(tx_sequence)
  function new(string name = "tx_sequence");
    super.new(name);
  endfunction
  tx_item m1,m2;
  tx_payload pay;

  bit eq;

  virtual task body();
    `uvm_info("HERE",$sformatf("In %m"),UVM_MEDIUM)
    #100

    `uvm_info("EX","Create and print full tx_item",UVM_MEDIUM)
    m1 = tx_item::type_id::create("m1");
    start_item(m1);
    m1.src = 10;
    m1.dst = 20;
    m1.pay.data = 1;
    m1.pay.tx = m1;
    finish_item(m1);
    
    pay = m1.pay;

    `uvm_info("DBG","\n print m1 and payload",UVM_MEDIUM)
    m1.print();

    #100;
    //create m2 and copy m1 into m2
    m2 = tx_item::type_id::create("m2");
    start_item(m2);
    m2.copy(m1);
    finish_item(m2);
    
    #100;
    `uvm_info("DBG","\n print m2 and payload",UVM_MEDIUM)
    m2.print();

   eq  = m1.compare(m2);
    `uvm_info("DBG", $sformatf("\nCompare (m1==m2) = %0d, should be 0", eq), UVM_MEDIUM)
  endtask
endclass
