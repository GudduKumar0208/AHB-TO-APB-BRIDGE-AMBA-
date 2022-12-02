class test1 extends uvm_sequence #(ahb_trans);

`uvm_object_utils (test1)
ahb_trans trans_h;

function new(string name="test1");
super.new(name);
endfunction


task body();
	repeat(1)
	trans_h=ahb_trans::type_id::create("trans_h");
	start_item(trans_h);
	assert (trans_h.randomize() with {HADDR==40;HWDATA<=50;});
	finish_item(trans_h);
endtask
	endclass


