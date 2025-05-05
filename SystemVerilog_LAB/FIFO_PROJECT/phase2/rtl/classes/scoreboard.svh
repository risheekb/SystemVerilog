class Scoreboard extends Component;

  mailbox #(Transaction) pred2scbd_h,mon_out_h;

  virtual task check(int n);
    repeat(n) begin
      Transaction expected_h,output_h;
      pred2scbd_h.get(expected_h);
      mon_out_h.get(output_h);
      check_output(expected_h,output_h);
    end
  endtask

  virtual task check_output(Transaction expected_h,output_h);
    if(expected_h.data != output_h.data)
      $display("Data Mismatch ");
  endtask
endclass
