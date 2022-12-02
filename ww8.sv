class hww8 extends  ahb_seqs;

   `uvm_object_utils(hww8)
   
    function new (string name = "hww8");
       super.new(name);
    endfunction
 
task body();
    trans_h = ahb_trans::type_id::create("trans_h");
			start_item(trans_h);
			assert(trans_h.randomize() with {HBURST == 4/*;HWRITE==1*/;HADDR==50;});
			finish_item(trans_h);
			$display("%d addr",trans_h.HADDR);
	endtask
endclass



class pww8 extends apb_seqs;

   `uvm_object_utils(pww8)
   
    function new (string name = "pww8");
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


class ww8 extends bridge_test;
 
  `uvm_component_utils(ww8)

  hww8 hseqs_h;
  pww8 pseqs_h;
  
  function new (string name = "ww8", uvm_component parent=null);
	  super.new(name,parent);
   endfunction

 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h= hww8::type_id::create("hseqs_h");

pseqs_h=pww8::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);

endtask   
endclass
		