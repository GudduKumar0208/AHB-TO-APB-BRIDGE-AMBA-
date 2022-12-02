class ahb_monitor extends uvm_monitor;

     `uvm_component_utils(ahb_monitor)
     
	 uvm_analysis_port #(ahb_trans) h_port;
	 
     virtual bridge_inf.AHB_MRMP vif;

     ahb_trans trans_h;

    function new(string name = "ahb_monitor",uvm_component parent=null);
      super.new (name,parent);
      h_port=new("h_port",this);
	  	  trans_h=ahb_trans::type_id::create("trans_h");
    endfunction

   task run_phase(uvm_run_phase phase);
      @(vif.ahb_monitor_cb);
	  vif.ahb_monitor_cb.HRESET_n <= 0;
	  @(vif.ahb_monitor_cb);
	  vif.ahb_monitor_cb.HRESET_n <= 1;
    forever begin
	  monitor();
	  h_port.write(trans_h);
	end
	endtask
	
	task monitor();
	  

      @(vif.ahb_monitor_cb);
	  trans_h.HWRITE=vif.ahb_monitor_cb.temp;
	  trans_h.HRESET_n=vif.ahb_monitor_cb.HRESET_n;
	  trans_h.HREADYOUT=vif.ahb_monitor_cb.HREADYOUT;
	  trans_h.HADDR=vif.ahb_monitor_cb.HADDR;
	  trans_h.HWDATA=vif.ahb_monitor_cb.HWDATA;
	  trans_h.HRDATA=vif.ahb_monitor_cb.HRDATA;
	  trans_h.HSIZE=vif.ahb_monitor_cb.HSIZE;
	  trans_h.HBURST=vif.ahb_monitor_cb.HBURST;
	endtask

endclass

