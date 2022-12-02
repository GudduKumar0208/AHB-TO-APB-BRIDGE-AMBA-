class scoreboard extends uvm_scoreboard;

      `uvm_component_utils(scoreboard)
	//tempp data part
	  uvm_tlm_analysis_fifo #(ahb_trans) fifo_h;
	  uvm_tlm_analysis_fifo #(apb_trans) fifo_p;
	
      ahb_trans trans_h;
	  apb_trans trans_p;
	  int count;
	  
	  covergroup cvg;
c1:coverpoint trans_h.HWRITE{bins b1={1,0};}
c2:coverpoint trans_h.HWDATA{
							   bins a1={[0:1000]};
							   bins a2={[1500:2500]};
							   bins a3={[3500:5500]};
							   bins a4={[7000:8000]};}
c4:coverpoint trans_h.HBURST{bins b1={[0:7]};}
c5:coverpoint trans_p.PRDATA{bins d1={15};
							   bins d2={[100:150]};
							   bins d3={[200:300]};
							   bins d4={[61:80]};
							   bins d5={[40:60]};}
							
c6:coverpoint trans_h.HADDR{
							   bins a1={[10:30]};
							   bins a2={[40:70]};
							   bins a3={[100:250]};
                               bins a4={[270:300]};	}		
endgroup:cvg
  
  
	function new (string name = "scoreboard",uvm_component parent=null);
	  super.new(name,parent);
      fifo_h=new("fifo_h",this);
	  fifo_p=new("fifo_p",this);
	  cvg= new();
	endfunction

task run_phase(uvm_phase phase);
//repeat(50)
forever begin
fifo_h.get(trans_h);
fifo_p.get(trans_p);
check_data();
cvg.sample();
end


endtask

//task ref_model();

 task check_data();
//$display("Data Mismatch HWDATA= %p",trans_p);

if(trans_h.HWRITE ===1 && trans_h.HWDATA !== 0 && trans_h.HWDATA !== 32'bxx && trans_h.HREADYOUT===1 && trans_h.HRESET_n===1 )

begin

if (trans_h.HWDATA === trans_p.PWDATA)
begin
count=count+1;
$display("Success HWDATA=%d :%d = PWDATA : %d=HADDR : time =%d :count =%d ",trans_h.HWDATA, trans_p.PWDATA,trans_h.HADDR,$time,count);
end
          else
begin
count=count+1;
$display("Data Mismatch HWDATA= %d : %d=PWDATA : time =%d :count =%d",trans_h.HWDATA, trans_p.PWDATA,$time,count);
end       

end

if(trans_h.HWRITE ===0   && trans_h.HRDATA !== 0 && trans_h.HRDATA !== 32'bxx && trans_h.HREADYOUT===1  )
          begin
if (trans_p.PRDATA === trans_h.HRDATA) 
begin
count=count+1;
$display(" Success PRDATA= %d : %d = HRDATA: time =%d :count =%d",trans_p.PRDATA,trans_h.HRDATA,$time,count);	
end
else
begin
count=count+1;
$display(" DATA MISMATCH  PRDATA= %d : %d = HRDATA: time =%d :count =%d",trans_p.PRDATA,trans_h.HRDATA,$time,count);
end
end
endtask





endclass
	
	
	
	
	
	
	
	
	
	
	

	