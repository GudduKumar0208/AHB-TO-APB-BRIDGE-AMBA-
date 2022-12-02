class ahb_driver extends uvm_driver#(ahb_trans);

     `uvm_component_utils(ahb_driver)

	virtual bridge_inf.AHB_DRMP vif;

    function new(string name ="ahb_driver",uvm_component parent =null);
      super.new (name,parent);

    endfunction

	
 
    task run_phase(uvm_phase phase);
	begin @(vif.ahb_driver_cb);
      vif.ahb_driver_cb.HRESET_n<=0;
      @(vif.ahb_driver_cb);
      vif.ahb_driver_cb.HRESET_n<=1;
end

	  forever begin
		seq_item_port.get_next_item(req);
		
		 send_to_dut(req);
		seq_item_port.item_done();
	 end 
	endtask
	
task send_to_dut(ahb_trans req);
 	
                       	@(vif.ahb_driver_cb);	
						vif.ahb_driver_cb.HSIZE    <=req.HSIZE;
						vif.ahb_driver_cb.HWRITE   <=req.temp;
						vif.ahb_driver_cb.HBURST   <=req.HBURST;
						vif.ahb_driver_cb.HTRANS   <=req.HTRANS;
						//vif.ahb_driver_cb.HSEL  <=0;
						vif.ahb_driver_cb.HADDR    <=req.haddr_q.pop_front();
						vif.ahb_driver_cb.HTRANS   <=2;

   repeat(req.burst_len)begin
								 @(vif.ahb_driver_cb);
								 vif.ahb_driver_cb.HTRANS   <=3;
					 if (req.haddr_q.size!=0)
								vif.ahb_driver_cb.HADDR  <=req.haddr_q.pop_front();
					if (req.HWRITE==1) 
								vif.ahb_driver_cb.HWDATA <=req.hwdata_da.pop_front();
                  			/*  
							  $display("HTRANS=%d",vif.ahb_driver_cb.HTRANS);
							  $display("req.start_addr[0]=%d", req.start_addr[0]);
							  $display("req.aligned_addr[0])=%d", req.haddr_q[0]);
								*/					  
								@(vif.ahb_driver_cb);
								wait(vif.ahb_driver_cb.HREADYOUT==1);
					
					end
					
								vif.ahb_driver_cb.HRESET_n<=0;
							//$display("hwdata", vif.ahb_driver_cb.HWDATA);		
							$display("temp", req.temp);		
endtask
	
 endclass
 
 
