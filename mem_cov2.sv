class test2 extends uvm_sequence #(ahb_trans);

`uvm_object_utils (test2)
ahb_trans trans_h;

function new(string name="test_2");
super.new(name);
endfunction


task body();
	repeat(1)
	trans_h=ahb_trans::type_id::create("trans_h");
	start_item(trans_h);
	  assert (trans_h.randomize()with {HADDR>100;HWDATA>100;});
  finish_item(trans_h);
endtask
	endclass