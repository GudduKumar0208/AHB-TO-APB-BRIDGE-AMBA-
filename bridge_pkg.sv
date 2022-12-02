package bridge_pkg;

  import uvm_pkg::*;
  
  `include "uvm_macros.svh"
  
  `include "ahb_trans.sv"
  `include "apb_trans.sv"
  
//config
  `include "bridge_config.sv"
//sequencer  
  `include "ahb_seqr.sv"
  `include "apb_seqr.sv"
  
//driver
  `include "ahb_driver.sv"
  `include "apb_driver.sv"

//monitoritor  
  `include "ahb_monitor.sv"
  `include "apb_monitor.sv"

//sequence
  `include "ahb_seqs.sv"
  `include "apb_seqs.sv"

//agent  
  `include "ahb_agent.sv"
  `include "apb_agent.sv"
  
  
//scoreboard
  `include "scoreboard.sv"
 


//environment  
  `include "bridge_env.sv"
  
//test
`include "bridge_test.sv"



endpackage

