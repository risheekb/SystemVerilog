// This sequence pumps out an item every 13ns, forever
class noise_sequence extends uvm_sequence;
  `uvm_object_utils(noise_sequence)
  function new(string name="noise_sequence");
    super.new(name);
  endfunction

  // Declare a flag to cleanly stop the sequence body()
  bit stop = 0;

  // Set it then wait for the sequence body to reach a clean place to end
  virtual task end_sequence();
    `uvm_info("NOISE", "end_sequence() started", UVM_MEDIUM)
    stop = 0;

    // Handshake with sequence
    wait (stop === 0);
    `uvm_info("NOISE", "end_sequence() done", UVM_MEDIUM)

    // There is some sort of race condition between ending the sequence and starting it again
    // In UVM 1.1d, #0 is not enough - need a #1ns.
    #1ns;
  endtask


  virtual task body();
    int count = 0;

    stop = 0;
    while (!stop) begin
      // The following is sort of like start_item()/finish_item()
      `uvm_info("NOISE", $sformatf("Starting item #%0d", count++), UVM_MEDIUM)
      #13ns;
    end

    `uvm_info("NOISE", "Ending sequence", UVM_MEDIUM)
    stop = 0;


    // There is a race condition between ending the sequence and starting it again
    // In UVM 1.1d, #0 is not enough - need a #1ns.
    `uvm_info("NOISE", "Ended sequence", UVM_MEDIUM)
  endtask : body

endclass : noise_sequence
