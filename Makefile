# Makefile for Memory - Regression Testing 
RTL= ../RTL/*.v
work= work #library name
COVOP= -coveropt 3 +cover=bcft
SVTB1= ../ENV/interface.sv ../TOP/bridge_top.sv
INC = +incdir+../ENV +incdir+../TEST
SVTB2 = ../TEST/bridge_pkg.sv
TOP = bridge_top
TEST = ../TEST/bridge_test.sv
TEST1 = ../test/bridge_test1.sv
TEST2 = ../test/bridge_test2.sv
VSIMOPT= -coverage -novopt -sva -sv_seed random work.top 
VSIMCOV= coverage save -onexit -assert -directive -cvg -codeAll mem_cov
VSIMBATCH0= $(TOP)
VSIMBATCH= $(TOP) -c -do "run -all; exit"
VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll test1;run -all;exit"
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll test2;run -all;exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll test3;run -all;exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov4;run -all;exit"
VSIMBATCH5 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov5;run -all;exit"
VSIMBATCH6 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov6;run -all;exit"
VSIMBATCH7 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov7;run -all;exit"
VSIMBATCH8 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov8;run -all;exit"
VSIMBATCH9 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll mem_cov9;run -all;exit"


html:
	firefox covhtmlreport/pages/__fbridgeetop.htm

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog  $(RTL)  $(SVTB2) $(SVTB1) $(INC) 
	
	vsim -novopt $(VSIMBATCH)   
sv_cmp0:
	vlib $(work)
	vmap work $(work)
	vlog  $(RTL)  $(SVTB2) $(SVTB1) $(INC) 
	vsim -novopt $(VSIMBATCH0)
sv_cmp1:
	vlib $(work)
	vmap work $(work)
	vlog   $(SVTB2) $(SVTB1) $(INC) 
	vsim -novopt $(VSIMBATCH1) $(VSIMBATCH2)   $(VSIMBATCH3)   
run_sim1:	
	vsim -novopt $(VSIMBATCH0)   


run_sim:
	vsim -novopt $(VSIMBATCH)   

run_testg:
	vsim -novopt -sva -sv_seed random work.top 
	vcover report -html mem_cov1   
	clear

clean:
	rm -rf modelsim.* transcript* vlog.* work vsim.wlf mem_cov* fcover* covhtml* vcover* *.log
	clear


TC1:
	vsim  $(VSIMBATCH2) -coverage -novopt -sva -sv_seed 598761566 -l test1_sim.log work.top +TEST1
	vcover report -html test1

TC2:
	vsim  $(VSIMBATCH2) -coverage -novopt -sva -sv_seed 598761566 -l test2_sim.log work.top +TEST2
	vcover report -html test2

TC3:
	vsim  $(VSIMBATCH3) -coverage -novopt -sva -sv_seed 74473697 -l test3_sim.log work.top +TEST3
	vcover report -html test3
TC4:
	vsim  $(VSIMBATCH4) -coverage -novopt -sva -sv_seed 4275076933 -l test4_sim.log work.top +TEST4
	vcover report -html mem_cov4

TC5:
	vsim  $(VSIMBATCH5) -coverage -novopt -sva -sv_seed 3868229417 -l test5_sim.log work.top +TEST5
	vcover report -html mem_cov5

TC6:
	vsim  $(VSIMBATCH6) -coverage -novopt -sva -sv_seed 749764269 -l test6_sim.log work.top +TEST6
	vcover report -html mem_cov6

TC7:
	vsim  $(VSIMBATCH7) -coverage -novopt -sva -sv_seed 1982889551 -l test7_sim.log work.top +TEST7
	vcover report -html mem_cov7

TC8:
	vsim  $(VSIMBATCH8) -coverage -novopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST8
	vcover report -html mem_cov8

TC9:
	vsim  $(VSIMBATCH9) -coverage -novopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST9
	vcover report -html mem_cov9
report:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9
	vcover report -html mem_cov

regress: clean run_test TC2 TC3 TC4 TC5 TC6 TC7 TC8 TC9 report html


gui:
	vsim $(VSIMOPT)

run_test: clean sv_cmp run_sim
	
	vlog  ../RTL/*.v  ../TEST/bridge_pkg.sv ../ENV/interface.sv ../TOP/bridge_top.sv +incdir+../ENV +incdir+../TEST
	vsim -novopt bridge_top -c -do "add wave -r sim:/bridge_top/*;run -all"
