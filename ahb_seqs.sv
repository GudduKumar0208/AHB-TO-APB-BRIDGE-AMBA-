class ahb_seqs extends uvm_sequence #(ahb_trans);

      `uvm_object_utils(ahb_seqs)
      ahb_trans trans_h;
	  
    function new(string name ="ahb_seqs");
      super.new (name);
    endfunction

task body();
	repeat(1)
	trans_h=ahb_trans::type_id::create("trans_h");
	start_item(trans_h);
	  assert (trans_h.randomize()with{HWDATA==12;});
	  finish_item(trans_h);
//$display("seq %d",trans_h);
endtask
	endclass


































	 
	























