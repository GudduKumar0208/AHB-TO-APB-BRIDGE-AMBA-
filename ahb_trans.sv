class ahb_trans   extends uvm_sequence_item    ;

//signals
	  
	  bit              HRESET_n;
      bit              HSEL;     
      bit       [31:0] HRDATA;
rand  bit              HREADYOUT;	 
  bit              temp;	 
	  bit              HWRITE;
rand  bit       [1:0]  HTRANS;
randc bit       [31:0] HADDR;
rand  bit       [31:0] HWDATA ;
rand  bit       [2:0]  HBURST;
rand  bit       [2:0]  HSIZE;



`uvm_object_utils_begin(ahb_trans)
`uvm_field_int (HTRANS,UVM_ALL_ON)
`uvm_field_int (HADDR,UVM_ALL_ON)
`uvm_field_int (HWDATA,UVM_ALL_ON)
`uvm_field_int (HRDATA,UVM_ALL_ON)

`uvm_field_int (HBURST,UVM_ALL_ON)
`uvm_field_int (HSIZE,UVM_ALL_ON)
`uvm_field_int (HSEL,UVM_ALL_ON)

`uvm_field_int (HWRITE,UVM_ALL_ON)
`uvm_field_int (temp,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name ="ahb_trans");
  super.new(name);
  endfunction

	////  array declare ////
	
rand  int unsigned hwdata_da [$];
      int unsigned haddr_q [$] ;
      int unsigned start_addr[$];

/// port declare ///

rand bit [5:0]  burst_len;
     bit [31:0] aligned_addr;
     bit [31:0] lower_wrap_boundary;
     bit [31:0] upper_wrap_boundary;

	constraint EXP  {hwdata_da.size() == burst_len;}
  constraint EXP2  {foreach(hwdata_da[i]) hwdata_da[i] < 8000;}
	constraint EXP3  {HBURST ==3;}
   // constraint EXP6  {HWRITE ==1;}
	constraint EXP4  {HSIZE ==2 ;}
	constraint EXP1 {if (HBURST inside {1}) {burst_len == 31;}
	                 else if (HBURST inside {0}) {burst_len == 1;}
	                 else if (HBURST inside {2,3}) {burst_len == 4;}
	                 else if (HBURST inside {4,5}) {burst_len == 8;}
					 else if (HBURST inside {6,7}) {burst_len == 16;}}
	constraint H_ADDR {HADDR < 1000;}



//POST RANDOMIZATION

function void post_randomize();
     haddr_q = {};
     aligned_addr = (HADDR - (HADDR % (2**HSIZE)));
     lower_wrap_boundary = (aligned_addr/(burst_len*(2**HSIZE)))*(burst_len*(2**HSIZE));
     upper_wrap_boundary = lower_wrap_boundary + (burst_len * (2**HSIZE));
	        
start_addr.push_back(aligned_addr);
//$display("aligned_addr = %0d, lower_wrap_boundary = %0d, upper_wrap_boundary = %0d",aligned_addr,lower_wrap_boundary,upper_wrap_boundary);
     repeat(burst_len) begin
   	 //  hwdata_da.push_back(HWDATA);
	   haddr_q.push_back(aligned_addr);
	   
	   aligned_addr = aligned_addr + (2**HSIZE);
	   if ((HBURST == 2 || HBURST == 4 || HBURST == 6) && aligned_addr == upper_wrap_boundary)
          aligned_addr = lower_wrap_boundary;
	 end
//$display("HADDR = %d, HSIZE = %d, HBURST = %d, burst_len = %d",HADDR,HSIZE,HBURST,burst_len);
     //$display("HADDDR qqqq = %p",haddr_q);
	 //$display("hwdata_da = %p",hwdata_da);
endfunction

endclass







































