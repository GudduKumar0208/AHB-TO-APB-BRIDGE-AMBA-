class apb_seqs extends uvm_sequence #(apb_trans);

      `uvm_object_utils(apb_seqs)
      apb_trans trans_h;

	function new(string name ="apb_seqs");
      super.new (name);
    endfunction

   task body();
repeat(50)
      begin
        trans_h = apb_trans::type_id::create("trans_h");
		start_item(trans_h);
		assert(trans_h.randomize());

		finish_item(trans_h);
	  end
	endtask

endclass























