class hiw4 extends  ahb_seqs;

   `uvm_object_utils(hiw4)
   
    function new (string name = "hiw4");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {trans_h.HBURST == 3;trans_h.HWRITE==1;trans_h.HADDR==280;trans_h.HWDATA==250;});
			finish_item(trans_h);
	endtask
endclass



class piw4 extends apb_seqs;

   `uvm_object_utils(piw4)
   
    function new (string name = "piw4");
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


class iw4 extends bridge_test;
 
  `uvm_component_utils(iw4)

  hiw4 hseqs_h;
  piw4 pseqs_h;
  
  function new (string name = "iw4", uvm_component parent=null);
	  super.new(name,parent);
   endfunction

 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hiw4::type_id::create("hseqs_h");

pseqs_h=piw4::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask   
endclass
		