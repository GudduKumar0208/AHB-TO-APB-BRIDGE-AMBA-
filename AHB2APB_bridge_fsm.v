module bridge_fsm(HRESETn,
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
				  HWRITEREG,
				  temp);

//port direction

// AHB signal

//
output reg temp;
input HRESETn,HCLK,VALID,HWRITE;
input [2:0]HSIZE;
input [31:0]PIPELINE_HADDR_TEMP; 
input [31:0]PIPELINE_HWDATA;
input [31:0]PIPELINE_HADDR;
input [3:0]HSEL;
input HWRITEREG;
output reg [31:0] HRDATA;

// APB signal
output  reg        PWRITE_TEMP;
output  reg        PENABLE_TEMP;		
output  reg [31:0] PADDR_TEMP;
output  reg [31:0] PWDATA_TEMP;
output  reg [3:0]  PSELX_TEMP;
output  reg        HREADYOUT;
//
//output reg         HWRITE;
input       [31:0] PRDATA_TEMP;

//state
parameter ST_IDLE = 3'b000,
	       ST_WWAIT = 3'b001,
	       ST_WRITE = 3'b010,
	       ST_WENABLE = 3'b011,
	       ST_READ = 3'b100,
	       ST_WRITEP = 3'b101,
	       ST_WENABLEP = 3'b110,
	       ST_RENABLE = 3'b111;

reg [2:0] pr_state,next_state;


////for  other logic


reg FLAG;
    reg [31:0]TEMP_ADDR1;
    wire [31:0]TEMP_ADDR2;
    reg [3:0]HSEL_TEMP,HSEL_TEMP1;

//
//reg temp;
 assign HWRITE=temp;
//Present state

 always@(posedge HCLK or negedge HRESETn)
 if(!HRESETn)
 pr_state <= ST_IDLE;

 else 
 pr_state <=  next_state;
 
//next state
always@(*)begin

 case(pr_state)
 
 ST_IDLE:
         
	if(VALID == 1 && HWRITE == 0)
   next_state = ST_READ;
	
	else if(VALID == 1 && HWRITE == 1)
   next_state = ST_WWAIT;
	
	else 
   next_state = ST_IDLE;

	
 ST_READ:
 
   next_state = ST_RENABLE;
   
	
  
 ST_RENABLE:
 
   if(VALID == 1 && HWRITE == 1)
	next_state = ST_WWAIT;
	
	else if(VALID == 1 && HWRITE == 0)
	next_state = ST_READ;
	
	else 
	next_state = ST_IDLE;
	  
	
 ST_WWAIT:
  
   if(VALID == 1)
	next_state = ST_WRITEP;
	
	
	else
	next_state = ST_WRITE;
	
 ST_WRITE:
 
	
  if(VALID == 1 )
  next_state = ST_WENABLEP;
  
  else
  next_state = ST_WENABLE;
  
 ST_WENABLE:
 
  if(VALID == 1 && HWRITE == 0 )
  next_state = ST_READ;
  
  else if(VALID == 1 && HWRITE == 1 )
  next_state = ST_WWAIT;
  
  else
  next_state = ST_IDLE;
  
 ST_WRITEP:
 
  next_state = ST_WENABLEP;
 
 ST_WENABLEP:
 
   
  if(VALID == 0 && HWRITEREG == 1)
  next_state = ST_WRITE;
  
  else if(VALID == 1 && HWRITEREG == 1)
  next_state = ST_WRITEP;
  
  else
  next_state = ST_READ;
  
 default : next_state = ST_IDLE;
 
  endcase
 end


 
 ///other logic

	always@* begin
	//  if(!HRESETn) begin
    /*if (pr_state == ST_WRITE || pr_state == ST_WRITEP)
        Paddr_temp =  pipeline_Haddr;
	else if (pr_state == ST_READ)
	    Paddr_temp =  pipeline_Haddr_temp;
	//else if(pr_state == ST_RENABLE || pr_state == ST_WENABLE || pr_state == ST_WENABLEP)
	  //        Paddr_temp =  pipeline_Haddr_temp;*/
				
	if (pr_state == ST_READ || pr_state == ST_WRITE || pr_state == ST_WRITEP || pr_state == ST_WENABLE || pr_state == ST_RENABLE || pr_state == ST_WENABLEP )
                        PSELX_TEMP = HSEL;
                   
                   
	if(pr_state == ST_WRITEP)//|| Pwrite_temp == 1'b1 || Penable_temp == 1'b0 )
                     PWDATA_TEMP =  PIPELINE_HWDATA;
                   
	if(pr_state == ST_WRITE || pr_state == ST_WRITEP || pr_state == ST_WENABLE || pr_state == ST_WENABLEP)
                     PWRITE_TEMP = 1'B1;
	else if(pr_state == ST_READ || pr_state == ST_RENABLE)
	      PWRITE_TEMP = 1'B0;
                   
	if(pr_state == ST_RENABLE || pr_state == ST_WENABLE || pr_state == ST_WENABLEP)
		begin
            PENABLE_TEMP = 1'B1;
		end
	else
		begin
			PENABLE_TEMP = 1'B0;
		end
					 
	 if(PENABLE_TEMP ==1'B1)
					 HRDATA = PRDATA_TEMP;
					else 
					 HRDATA ='dx;
					 
	// if (pr_state == S pr_state == ST_RENABLE || pr_state == ST_WRITE || pr_state == ST_WENABLE )
		//				 Hrdata = Prdata_temp;	
					 
					 
	/* if(pr_state == ST_IDLE || pr_state == ST_WWAIT || pr_state == ST_WRITE || pr_state == ST_RENABLE || pr_state == ST_WENABLE || pr_state == ST_WENABLEP)                   
                 Hreadyout = 1'b1;
	 else
			Hreadyout = 1'b0;*/
 	
  end
  
  
  
///output logic  
  always@*
   begin
   case(pr_state)
    ST_IDLE     : begin
		   PADDR_TEMP = PADDR_TEMP;
		   HREADYOUT = 1'b1;
		   //
		   temp=1'b1;
		  end

    ST_WWAIT    : begin
		   TEMP_ADDR1 = PIPELINE_HADDR_TEMP;
		   HREADYOUT = 1'b1;
		  //
		  temp=1'b1;
		  end

    ST_WRITEP   : begin
                  if(FLAG)
                   PADDR_TEMP = TEMP_ADDR1;
                  else
					PADDR_TEMP = PIPELINE_HADDR;
					HREADYOUT = 1'B0;
//
temp=1'b0;
				end

    ST_WENABLEP : 	begin
					FLAG = 1'b1;
					TEMP_ADDR1 = PIPELINE_HADDR;
					//if(next_state == ST_READ)
						//	Hreadyout = 1'b0;
					//else
							HREADYOUT = 1'B1;
//
temp=1'b1;
			end

    ST_READ     : begin
                   if(FLAG)
		    PADDR_TEMP = TEMP_ADDR1;
		   else
		    PADDR_TEMP = PIPELINE_HADDR_TEMP;
		    HREADYOUT = 1'B0;
//
temp=1'b0;
		  end	

    ST_RENABLE  : begin
		   FLAG = 1'b1;
		   TEMP_ADDR1 = PIPELINE_HADDR_TEMP;
		   HREADYOUT = 1'B1;
//
temp=1'b1;
		  end

    ST_WRITE    : begin
		   PADDR_TEMP = TEMP_ADDR1;
		   HREADYOUT = 1'b1;
//
temp=1'b1;
		  end

    ST_WENABLE  : begin
		   PADDR_TEMP = TEMP_ADDR1;
		   HREADYOUT = 1'b1;
//
temp=1'b1;
		 end

    endcase
   end


  /* always@(posedge Hclk)
    begin
     if(Hwrite)
      begin
	Hsel_temp <= Hsel;
      end
     else
      begin
	Hsel_temp <= Hsel;
      end
    end	


  assign temp_addr2 = Prdata_temp;

  assign Hrdata = (Penable_temp) ? Prdata_temp : temp_addr2;
  assign Penable_temp = (pr_state == ST_RENABLE || pr_state == ST_WENABLE || pr_state == ST_WENABLEP)?1'b1:1'b0;
  assign Hreadyin_temp = (pr_state == ST_WRITE || pr_state == ST_WRITEP || pr_state == ST_WENABLE || pr_state == ST_WENABLEP)?1'b1:1'b0;
  assign Pselx_temp = (pr_state == ST_READ || pr_state == ST_WRITE || pr_state == ST_WRITEP || pr_state == ST_RENABLE || pr_state == ST_WENABLE || pr_state == ST_WENABLEP) ? Hsel_temp : 4'b0000;
  */

  
endmodule  
