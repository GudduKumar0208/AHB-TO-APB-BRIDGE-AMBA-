class hiw16 extends  ahb_seqs;

   `uvm_object_utils(hiw16)
   
    function new (string name = "hiw16");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {trans_h.HBURST == 7;trans_h.HWRITE==1;});
			finish_item(trans_h);
	endtask
endclass



class piw16 extends apb_seqs;

   `uvm_object_utils(piw16)
   
    function new (string name = "piw16");
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


class iw16 extends bridge_test;
 
  `uvm_component_utils(iw16)

  hiw16 hseqs_h;
  piw16 pseqs_h;
  
  function new (string name = "iw16", uvm_component parent=null);
	  super.new(name,parent);
   endfunction

 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hiw16::type_id::create("hseqs_h");

pseqs_h=piw16::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask   
endclass
		