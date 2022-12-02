class test3 extends uvm_sequence #(apb_trans);
`uvm_object_utils(test3)
apb_trans trans_h;
function new(string name="test3");
super.new(name);
endfunction


   task body();
repeat(50)
      begin
        trans_h = apb_trans::type_id::create("trans_h");
		start_item(trans_h);
		assert(trans_h.randomize() with {PRDATA>50;});

		finish_item(trans_h);
	  end
	endtask

endclass