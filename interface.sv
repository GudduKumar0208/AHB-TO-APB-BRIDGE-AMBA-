interface bridge_inf(input bit HCLK);

// reset

logic HRESET_n;
//logic PRESET;

// AHB SIGNALS 

logic HSEL;
//logic HREADY;
logic HWRITE;
logic [1:0]HTRANS;
logic [31:0] HADDR;
logic [31:0] HWDATA;
logic [31:0] HRDATA;
logic [2:0] HBURST;
logic [2:0] HSIZE;
logic [1:0]	HRESP;
logic           HREADYOUT;    
logic           temp;    
logic			HREADYIN;		
// APB SIGNAL
logic PSELx;
logic PWRITE;
logic PENABLE;
logic PREADY;
logic [31:0] PADDR;
logic [31:0] PWDATA;  
logic [31:0] PRDATA;


clocking ahb_driver_cb@(posedge HCLK);
default input#1 output#1;
input HRDATA,HREADYOUT ,temp ;
output HRESET_n;
output HWRITE,HTRANS,HADDR,HWDATA,HBURST,HSIZE;
//output#9 HWDATA;  is tarike se delay de skte h and driver ko skew krne se rtl WALA hwdata delay hoga 
                    // interface vaaaleko delay dene k liye @vif walakrenege only for driver
endclocking

clocking ahb_monitor_cb@(posedge HCLK);
default input#1 output#1;
input HRESET_n,HREADYOUT,temp;   //monitor me skew change krne se vif hidelay hoga rtl wala nai
                            //rtl waalek liye @vif wala delay krne ka monitor kliye  
input HWRITE,HADDR,HTRANS,HRDATA,HWDATA,HSIZE,HBURST;
endclocking

clocking apb_driver_cb@(posedge HCLK);
default input#0 output#1;
input HREADYIN,PWRITE,PADDR,PWDATA,PENABLE,PSELx;
output PRDATA;
input HRESET_n;
endclocking

clocking apb_monitor_cb@(posedge HCLK);

default input#0 output#1;
input HRESET_n,HREADYIN;
input PENABLE,PWRITE,PADDR,PWDATA,PRDATA,PSELx;
endclocking

modport AHB_DRMP (clocking ahb_driver_cb);
modport AHB_MRMP (clocking ahb_monitor_cb);
modport APB_DRMP (clocking apb_driver_cb);
modport APB_MRMP (clocking apb_monitor_cb);


















endinterface