class apb_seqr extends uvm_sequencer #(apb_trans);

`uvm_component_utils(apb_seqr)

function new (string name ="apb_seqr",uvm_component parent=null);
super.new (name,parent); 
endfunction

endclass