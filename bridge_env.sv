class bridge_env extends uvm_env;

      `uvm_component_utils(bridge_env)
	   ahb_agent hagent_h;
	   apb_agent pagent_p;
	   scoreboard sb_h;
	   bridge_config config_h;
	   
	function new (string name = "bridge_env",uvm_component parent = null);
	  super.new(name,parent);
	endfunction
	
	function void build_phase (uvm_phase phase);
	  super.build_phase(phase);
	  hagent_h=ahb_agent::type_id::create("hagent_h",this);
	  pagent_p=apb_agent::type_id::create("pagent_p",this);
	  sb_h=scoreboard::type_id::create("sb_h",this);
	  config_h=bridge_config::type_id::create("config_h",this);
	 if (!uvm_config_db#(bridge_config)::get(this , "*" , "bridge_config" , config_h))
		`uvm_info("error" , "error in config file" , UVM_NONE)
	endfunction
	
	function void connect_phase(uvm_phase phase);
	  super.connect_phase(phase);
	  
//if (config_h.scoreboard==1)
	  
	begin hagent_h.ahb_monh.h_port.connect(sb_h.fifo_h.analysis_export);
	 pagent_p.apb_monh.p_port.connect(sb_h.fifo_p.analysis_export);
	 end
	endfunction
endclass	