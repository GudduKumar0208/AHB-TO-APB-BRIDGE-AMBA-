class hir extends  ahb_seqs;

   `uvm_object_utils(hir)
   
    function new (string name = "hir");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {trans_h.HBURST == 1;trans_h.HWRITE==0;});
			finish_item(trans_h);
	endtask
endclass



class pir extends apb_seqs;

   `uvm_object_utils(pir)
   
    function new (string name = "pir");
       super.new(name);
    endfunction
   
    task body();
  repeat(70) begin
  
   trans_h=apb_trans::type_id::create("trans_h");
   start_item(trans_h);
   assert(trans_h.randomize()with {trans_h.PRDATA <200;});
   finish_item(trans_h);
  end
 endtask
 
endclass


class ir extends bridge_test;
 
  `uvm_component_utils(ir)

  hir hseqs_h;
  pir pseqs_h;
  
  function new (string name = "ir", uvm_component parent=null);
	  super.new(name,parent);
   endfunction
 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hir::type_id::create("hseqs_h");

pseqs_h=pir::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask   
endclass
		