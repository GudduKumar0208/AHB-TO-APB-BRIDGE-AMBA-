 
 
class bridge_test extends uvm_test;

   `uvm_component_utils(bridge_test)
   

  
    bridge_env env_h;
    ahb_seqs hseqs_h;
    apb_seqs pseqs_h;
	    bridge_config config_h;
   
   function new (string name = "bridge_test", uvm_component parent=null);
      super.new(name,parent);
	  endfunction 
	  
	function void build_phase (uvm_phase phase);
       super.build_phase(phase);
     env_h = bridge_env::type_id::create("env_h",this);
	  config_h   = bridge_config::type_id::create("config_h",this);
	 	   uvm_config_db#(bridge_config)::set(this , "*" , "bridge_config" , config_h);
    endfunction 

function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
	  uvm_top.print_topology(); // FOR PRINTING TOPOLOGY
      `uvm_info("test","THIS IS END_OF_ELABORATION PHASE IN TEST",UVM_HIGH);
   endfunction
  
 task run_phase (uvm_phase phase);
     phase.raise_objection(this);
//create sequences

hseqs_h=ahb_seqs::type_id::create("hseqs_h");

pseqs_h=apb_seqs::type_id::create("pseqs_h");

fork
if(config_h.ahb_is_active)
hseqs_h.start(env_h.hagent_h.ahb_seqrh);
if (config_h.apb_is_active)
pseqs_h.start(env_h.pagent_p.apb_seqrh);
join


   phase.drop_objection(this);
endtask 

endclass
	 