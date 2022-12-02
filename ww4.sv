class hww4 extends  ahb_seqs;

   `uvm_object_utils(hww4)
   
    function new (string name = "hww4");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {HBURST == 2;HWRITE==1;HADDR==20;});
			finish_item(trans_h);
	endtask
endclass



class pww4 extends apb_seqs;

   `uvm_object_utils(pww4)
   
    function new (string name = "pww4");
       super.new(name);
    endfunction
   
    task body();
  repeat(20) begin
  
   trans_h=apb_trans::type_id::create("trans_h");
   start_item(trans_h);
   assert(trans_h.randomize());
   finish_item(trans_h);
  end
 endtask
 
endclass


class ww4 extends bridge_test;
 
  `uvm_component_utils(ww4)

  hww4 hseqs_h;
  pww4 pseqs_h;
  
  function new (string name = "ww4", uvm_component parent=null);
	  super.new(name,parent);
   endfunction

 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hww4::type_id::create("hseqs_h");

pseqs_h=pww4::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask   
endclass
		