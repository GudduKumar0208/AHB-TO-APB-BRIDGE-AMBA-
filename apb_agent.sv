		class apb_agent extends uvm_agent;

`uvm_component_utils(apb_agent)
    
	virtual bridge_inf vif;
    
	apb_monitor apb_monh;
	apb_driver apb_drh;
	apb_seqr apb_seqrh;
    bridge_config config_h;
	function new (string name = "apb_agent",uvm_component parent =null);
      super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
	  super.build_phase (phase);
  config_h   = bridge_config::type_id::create("config_h",this);
	  apb_monh=apb_monitor::type_id::create("apb_monh",this);
	//if(conf_h1.driver==1)	
	 if(!uvm_config_db#(bridge_config)::get(this,"","bridge_config",config_h))
     `uvm_fatal("APB_AGENT","CONFIG_DB");
if(config_h.apb_is_active==UVM_ACTIVE)
begin
	  apb_drh=apb_driver::type_id::create("apb_drh",this);
	  apb_seqrh=apb_seqr::type_id::create("apb_seqrh",this);
	end
	if(!uvm_config_db#(virtual bridge_inf)::get(this,"","vif",vif))
	   `uvm_fatal("BRIDGE_APB_AGENT","The virtual interface get failed");	endfunction
	
	function void connect_phase(uvm_phase phase);
	  super.connect_phase(phase);
	  //connect seq item port of driver with seqr export
if (config_h.apb_is_active == UVM_ACTIVE)
      begin 
	  apb_drh.seq_item_port.connect(apb_seqrh.seq_item_export);
	  apb_drh.vif=vif;
	  end
	  apb_monh.vif=vif;
	endfunction
endclass	  