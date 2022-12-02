class small_ahb_seqs extends ahb_seqs;

`uvm_object_utils(small_ahb_seqs)

function new(string name="small_ahb_seqs");
super.new(name);
endfunction

task body();
trans_h=ahb_trans::type_id::create("trans_h");
start_item(trans_h);
assert(trans_h.randomize());
finish_item(trans_h);
endtask
endclass

class small_apb_seqs extends apb_seqs;

`uvm_object_utils(small_apb_seqs)


function new (string name="small_apb_seqs");
super.new(name);
endfunction

task body();

trans_h=apb_trans::type_id::create("trans_h");
start_item(trans_h);
assert (trans_h.randomize());
finish_item(trans_h);
endtask
endclass

class small_test extends bridge_test;

`uvm_component_utils( small_test)

//  bridge_env env_h;
  small_ahb_seqs hseqs_h;
  small_apb_seqs pseqs_h;
  	//    bridge_config config_h;

   
function new (string name = "small_test", uvm_component parent=null);
      super.new(name,parent);
	  endfunction 
 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h=small_ahb_seqs::type_id::create("hseqs_h");

pseqs_h=small_apb_seqs::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask

endclass


