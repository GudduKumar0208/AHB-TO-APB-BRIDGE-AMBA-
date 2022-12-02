class apb_driver extends uvm_driver #(apb_trans);

     `uvm_component_utils(apb_driver)

	 virtual bridge_inf.APB_DRMP vif;
     
	     
    function new(string name ="apb_driver",uvm_component parent=null);
      super.new (name,parent);
    endfunction

    task run_phase(uvm_phase phase);
     @(vif.apb_driver_cb);
	  vif.apb_driver_cb.HRESET_n <=0;
	  @(vif.apb_driver_cb);
	  vif.apb_driver_cb.HRESET_n <=1;
	
	forever begin
	  seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	 end
	endtask
	
task send_to_dut(apb_trans req);
	@(vif.apb_driver_cb);
	
		if(vif.apb_driver_cb.PWRITE == 0 && vif.apb_driver_cb.PENABLE==1)
			begin vif.apb_driver_cb.PRDATA <= req.PRDATA;
			end
	
//$display("PADDR d %d",vif.apb_driver_cb.PRDATA);
//$display("req.PRDATA d %d",req.PRDATA);
		//$display("pwdata%d",req.PWDATA);
	endtask	

endclass