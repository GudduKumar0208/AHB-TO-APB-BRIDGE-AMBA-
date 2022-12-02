  import bridge_pkg::*;
module bridge_top();
	
	import uvm_pkg::*;
	
	`include "uvm_macros.svh"
	//import bridge_pkg::*;
	//`include "bridge_test.sv"
	bit HCLK;
	bridge_inf inf(HCLK);
	 
	bridge_toplevel DUT(.HCLK(HCLK),
				  
						.HRESETn(inf.HRESET_n),
				  
						.HWRITE(inf.HWRITE),
						.PWRITE(inf.PWRITE),
				  
						.HADDR(inf.HADDR),
						.PADDR(inf.PADDR),
				  
						.HWDATA(inf.HWDATA),
						.PWDATA(inf.PWDATA),
				  
						.HRDATA(inf.HRDATA),
						.PRDATA(inf.PRDATA),
				  
						.HREADYOUT(inf.HREADYOUT),
						.HREADYIN(inf.HREADYIN),
				 
						.PSELX(inf.PSELx),
				  
						.HTRANS(inf.HTRANS),
						.HBURST(inf.HBURST),
						.HSIZE(inf.HSIZE),
						.HRESP(inf.HRESP),
				  
						.PENABLE(inf.PENABLE),
						.temp(inf.temp));
	
	always
		#5 HCLK =~ HCLK;
	
	initial begin
		uvm_config_db #(virtual bridge_inf)::set(null,"*","vif",inf);
	
	//	run_test();
		run_test("bridge_test");
			
	end

endmodule