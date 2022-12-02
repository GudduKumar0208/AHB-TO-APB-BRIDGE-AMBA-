class  ahb_agent extends uvm_agent;
  
    `uvm_component_utils(ahb_agent)

    virtual bridge_inf vif;
	
	ahb_monitor ahb_monh;
	ahb_driver ahb_drh;
	ahb_seqr ahb_seqrh;
    bridge_config config_h;
   function new(string name = "ahb_agent",uvm_component parent=null);
    super.new(name,parent);
   endfunction
  
   function void build_phase (uvm_phase phase);
     super.build_phase (phase);
	 config_h   = bridge_config::type_id::create("config_h",this);
     ahb_monh = ahb_monitor::type_id::create(" ahb_monh",this);
	  
	 if (!uvm_config_db#(bridge_config)::get(this , "" , "bridge_config" , config_h))
		`uvm_fatal("AHB_AGENT", "The virtual interface get failed");
 	
if (config_h.ahb_is_active == UVM_ACTIVE)

begin
     ahb_drh  = ahb_driver::type_id::create("ahb_drh",this);
	 ahb_seqrh= ahb_seqr::type_id::create("ahb_seqrh",this);
	end
	if(!uvm_config_db#(virtual bridge_inf)::get(this,"","vif",vif))
	   `uvm_fatal("BRIDGE_AHB_AGENT","The virtual interface get failed");
   endfunction
   
   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
	 //connect seq item port of driver with seqr export
if (config_h.ahb_is_active == UVM_ACTIVE)
begin
 ahb_drh.seq_item_port.connect(ahb_seqrh.seq_item_export);
	
ahb_drh.vif=vif;
end
	  ahb_monh.vif=vif;
   endfunction	 
   endclass