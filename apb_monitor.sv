class apb_monitor extends uvm_monitor;

	 `uvm_component_utils(apb_monitor)
	 
	 uvm_analysis_port #(apb_trans) p_port;
	 
	 virtual bridge_inf.APB_MRMP vif;

	 apb_trans trans_h;

    function new(string name = "apb_monitor",uvm_component parent=null);
      super.new (name,parent);
      p_port=new("p_port",this);
	    trans_h=apb_trans::type_id::create("trans_h",this);
    endfunction
 
    task run_phase(uvm_phase phase);
      @(vif.apb_monitor_cb);
	  vif.apb_monitor_cb.HRESET_n <= 0;
	  @(vif.apb_monitor_cb);
	  vif.apb_monitor_cb.HRESET_n <= 1; 
    forever begin	
	  monitor();
      p_port.write(trans_h);
	end
	endtask
	
	task monitor();
	  @(vif.apb_monitor_cb);
	
	
	  
	trans_h.PSELx = vif.apb_monitor_cb.PSELx;
	  trans_h.PENABLE = vif.apb_monitor_cb.PENABLE;
	  trans_h.PWRITE = vif.apb_monitor_cb.PWRITE;
	  trans_h.PADDR  = vif.apb_monitor_cb.PADDR;
	  trans_h.PWDATA = vif.apb_monitor_cb.PWDATA;
	  trans_h.PRDATA = vif.apb_monitor_cb.PRDATA;
	//  $display("prdata m %d",vif.apb_monitor_cb.PRDATA);
	endtask
	  
endclass

