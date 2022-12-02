class hsr extends  ahb_seqs;

   `uvm_object_utils(hsr)
   
    function new (string name = "hsr");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {trans_h.HBURST == 0;trans_h.HWRITE==0;});
			finish_item(trans_h);
	endtask
endclass



class psr extends apb_seqs;

   `uvm_object_utils(psr)
   
    function new (string name = "psr");
       super.new(name);
    endfunction
   
    task body();
  repeat(20) begin
  
   trans_h=apb_trans::type_id::create("trans_h");
   start_item(trans_h);
   assert(trans_h.randomize()with {trans_h.PRDATA ==15;});
   finish_item(trans_h);
  end
 endtask
 
endclass


class sr extends bridge_test;
 
  `uvm_component_utils(sr)

  hsr hseqs_h;
  psr pseqs_h;
  
  function new (string name = "sr", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hsr::type_id::create("hseqs_h");

pseqs_h=psr::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask 
  
endclass
		