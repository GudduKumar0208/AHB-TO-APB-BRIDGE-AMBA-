module APB_interface (PADDR_TEMP,
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

//input signal
input PWRITE_TEMP;
input [31:0]PADDR_TEMP;
input [31:0]PWDATA_TEMP;
input [31:0]PRDATA;
input [3:0]PSELX_TEMP;
input PENABLE_TEMP;
input HCLK;

//output signal
output  PWRITE;
output  [3:0]PSELX;
output  PENABLE;
output  [31:0]PADDR;
output [31:0]PWDATA;
output [31:0]PRDATA_TEMP;



  //address signal
  assign PADDR = PADDR_TEMP;

  //select signal
  assign PSELX = PSELX_TEMP;

  //write signal
  assign PWRITE = PWRITE_TEMP;

  //enable signal
  assign PENABLE = PENABLE_TEMP;

  // write signal
  assign PWDATA = PWDATA_TEMP;

  //read data
  assign PRDATA_TEMP = PRDATA;


endmodule
