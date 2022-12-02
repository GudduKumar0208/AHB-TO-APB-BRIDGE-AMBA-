class hwr16 extends  ahb_seqs;

   `uvm_object_utils(hwr16)
   
    function new (string name = "hwr16");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {trans_h.HBURST == 6;trans_h.HWRITE==0;});
			finish_item(trans_h);
	endtask
endclass



class pwr16 extends apb_seqs;

   `uvm_object_utils(pwr16)
   
    function new (string name = "pwr16");
       super.new(name);
    endfunction
   
    task body();
  repeat(50) begin
  
   trans_h=apb_trans::type_id::create("trans_h");
   start_item(trans_h);
   assert(trans_h.randomize());
   finish_item(trans_h);
  end
 endtask
 
endclass


class wr16 extends bridge_test;
 
  `uvm_component_utils(wr16)

  hwr16 hseqs_h;
  pwr16 pseqs_h;
  
  function new (string name = "wr16", uvm_component parent=null);
	  super.new(name,parent);
   endfunction

 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hwr16::type_id::create("hseqs_h");

pseqs_h=pwr16::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask   
endclass
		