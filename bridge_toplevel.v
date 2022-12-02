module bridge_toplevel(HCLK,
                       HRESETn,
					   HWRITE,
					   HREADYIN,
					   HTRANS,
					   HADDR,
					   HWDATA,
					   HRDATA,
					   HRESP,
					   PWRITE,
					   PSELX,
                       PENABLE,
					   PADDR,
					   PWDATA,
					   PRDATA,
					   HSIZE,
					   HBURST,
					   HREADYOUT,
					   temp);

//input signal
input HCLK;
input HRESETn;
input HWRITE;
input HREADYIN;
input [1:0]HTRANS;
input [31:0]HADDR;
input [31:0]HWDATA;
input [31:0]PRDATA;
input [2:0]HSIZE;
input [2:0]HBURST;

//output signal
output PWRITE;
output [3:0]PSELX;
output PENABLE;
output [31:0]PADDR;
output [31:0]PWDATA;
output [1:0]HRESP;
output [31:0]HRDATA;
output HREADYOUT;
output temp;

wire [31:0]PIPELINE_HADDR_TEMP; 
wire [31:0]PIPELINE_HWDATA;
wire [31:0]PIPELINE_HADDR;
wire [3:0]HSEL;
wire VALID;
wire HWRITEREG;


wire PWRITE_TEMP;
wire PENABLE_TEMP;		
wire [31:0]PADDR_TEMP;
wire [31:0]PWDATA_TEMP;
wire  [3:0]PSELX_TEMP;
wire  [31:0]PRDATA_TEMP;


AHB_slave module1 (HREADYIN,
                 HTRANS,
				 HADDR,
				 HWDATA,
				 HRESP,
				 PIPELINE_HADDR,
                 PIPELINE_HWDATA,
				 VALID,
				 HWRITEREG,
				 HSEL,
				 PIPELINE_HADDR_TEMP,
			     HRESETn,
				 HCLK,
				 HREADYOUT,
				 HSIZE,
				 HWRITE,
				 HBURST);


bridge_fsm module2 (HRESETn,
                  HCLK,
				  PIPELINE_HADDR,
				  PIPELINE_HWDATA,
				  VALID,
				  HWRITE,
				  HSEL,
				  PIPELINE_HADDR_TEMP,
				  HRDATA,
                  PADDR_TEMP,
				  PWDATA_TEMP,
				  PRDATA_TEMP,
				  PWRITE_TEMP,
				  PSELX_TEMP,
				  PENABLE_TEMP,
				  HSIZE,
				  HREADYOUT,
				  HWRITEREG);
/*apb_fsm module2 (	.Hclk(Hclk),.HRESETn(HRESETn),.Hwrite(Hwrite),.Valid(valid),.Hwritereg(Hwritereg),.Hsel(Hsel),
					.PIPELINE_Haddr(pipeline_Haddr),.PIPELINE_Hwdata(pipeline_Hwdata),.PIPELINE_Haddr_temp(pipeline_Haddr_temp),
					.Prdata_temp(Prdata_temp),.Hreadyout(Hreadyout),.Hreadyin_temp(Hreadyin_temp),.Pselx_temp(Pselx_temp),
					.Penable_temp(Penable_temp),.Paddr_temp(Paddr_temp),.Pwdata_temp(Pwdata_temp),.Hrdata(Hrdata),.Hsize(Hsize));*/

APB_interface module3(PADDR_TEMP,
                      PWDATA_TEMP,
					  PRDATA_TEMP,
					  PSELX_TEMP,
					  PENABLE_TEMP,
					  PWRITE_TEMP,
                      PWRITE,
					  PSELX,
					  PENABLE,
					  PADDR,
					  PWDATA,
					  PRDATA,
					  HCLK);
					  
endmodule 