class tx_sequence extends uvm_sequence #(tx_item);
  `uvm_object_utils(tx_sequence);
  function new(string name="tx_sequence");
    super.new(name);
  endfunction // new

  tx_item m1, m2;

  task body();
    tx_payload h;
    bit eq;
    
    `uvm_info("HERE", $sformatf("%m"), UVM_MEDIUM)

    #100;
    `uvm_info("EX", "Create and print a full tx_item", UVM_LOW);
    m1 = tx_item::type_id::create("m1");
    start_item(m1);
    m1.src = 1;
    m1.dst = 10;
    m1.pay.data = 1;
    finish_item(m1);
    `uvm_info("DBG", "\nPrint m1 and payload", UVM_MEDIUM)
    m1.print();
    h = m1.pay;

    #100;
    `uvm_info("DBG", "\nCreate m2, Copy m1 to m2", UVM_MEDIUM)
    m2 = tx_item::type_id::create("m2");
    start_item(m2);
    m2.copy(m1);
    finish_item(m2);

    #100;
    `uvm_info("DBG", "\nPrint m2 with payload", UVM_MEDIUM)
    m2.print();

    // m1.pay=good, m2.pay=good
    eq = m2.compare(m1);
    `uvm_info("DBG", $sformatf("\nm2.compare(m1)=%0d, should succeed", eq), UVM_MEDIUM)
    if (eq !== 1)
      `uvm_error("MISMATCH", $sformatf("\nm1=%s\nm2=%s", m1.sprint(), m2.sprint()))

    #100;
    `uvm_info("DBG", "\nChanging m1.src", UVM_MEDIUM)
    m1.src = 42;
    `uvm_info("DBG", "\nPrint m1", UVM_MEDIUM)
    m1.print();

    eq = m1.compare(m2);
    `uvm_info("DBG", $sformatf("\nCompare (m1==m2) = %0d, should be 0", eq), UVM_MEDIUM)
    if (eq !== 0)
      `uvm_error("MISMATCH", "eq != 0")

    #100;
    `uvm_info("DBG", "\nSet m1.pay to good & print", UVM_MEDIUM)
    m1.pay = h;
    m1.print();

    // m1.pay=good, m2.pay=null
    eq = m2.compare(m1);
    `uvm_info("DBG", $sformatf("\nCompare (m1==m2) = %0d, should fail", eq), UVM_MEDIUM)
    if (eq !== 0)
      `uvm_error("MISMATCH", "eq != 0")
  endtask

endclass
