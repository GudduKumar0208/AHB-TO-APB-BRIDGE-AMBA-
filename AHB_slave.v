module AHB_slave(HREADYIN,
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
				 HBURST,
				 temp);
                                                   
//input signal
input HREADYIN;
input HRESETn;
input HCLK;
input [2:0]HSIZE;
input [1:0]HTRANS;
input [31:0]HADDR;
input [31:0]HWDATA;
input [2:0]HBURST;
input HWRITE;
input HREADYOUT;
input temp;

//output signal	
output [1:0]HRESP;
output reg [31:0]PIPELINE_HADDR;
output reg[31:0]PIPELINE_HWDATA;
output reg VALID;
output reg HWRITEREG;
output reg [3:0]HSEL;
output reg [31:0]PIPELINE_HADDR_TEMP;


   parameter OKAY = 2'b00,
	     NON_SEQ = 2'b10,
	     SEQ = 2'b11;

//Hresp logic
assign HRESP = OKAY;

always@(posedge HCLK) begin
 //addr pipelining 
   PIPELINE_HADDR_TEMP <= HADDR; 
   PIPELINE_HADDR <= PIPELINE_HADDR_TEMP;
 
 //data pipelining
   PIPELINE_HWDATA <= HWDATA;
	
 //write enable pipelining
   HWRITEREG <= HWRITE;

 //valid
end


  always@*
   begin
    if(!HRESETn)
    	VALID = 1'B0;
    else if((HADDR >= 32'H0000_0000 && HADDR <= 32'H8FFF_FFFF) && (HRESP == OKAY) && (HTRANS == NON_SEQ || HTRANS == SEQ))
	VALID = 1'B1;
    else
	VALID = 1'B0;
  end

//Hsel
always@(posedge HCLK) begin
 if (!HRESETn)
     HSEL = 4'b0000;
 else begin
    if (HADDR >= 32'H0000_0000 && HADDR <= 32'H0000_FFFF)
       HSEL = 4'B0001;
	 
    else if (HADDR >= 32'H0001_FFFF && HADDR <= 32'H000F_FFFF)
       HSEL = 4'B0010;
 
   else if (HADDR >= 32'H001F_FFFF && HADDR <= 32'H00FF_FFFF)
       HSEL = 4'B0100;
	
   else if (HADDR >= 32'H01FF_FFFF && HADDR <= 32'H0FFF_FFFF)
       HSEL = 4'B1000;
  end 

 end
 
 
endmodule
