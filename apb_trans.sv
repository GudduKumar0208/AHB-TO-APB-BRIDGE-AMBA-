class apb_trans extends uvm_sequence_item;

//signals

 bit[3:0]  PSELx;
 bit  PWRITE;
 bit  PENABLE; 
  bit  [31:0] PADDR;
 bit  [31:0] PWDATA;
 rand bit  [31:0] PRDATA;



bit  HRESET_n;

 
`uvm_object_utils_begin (apb_trans)
`uvm_field_int (PSELx,UVM_ALL_ON)
`uvm_field_int (PWRITE,UVM_ALL_ON)
`uvm_field_int (PENABLE,UVM_ALL_ON)

`uvm_field_int (PADDR,UVM_ALL_ON)
`uvm_field_int (PWDATA,UVM_ALL_ON)
`uvm_field_int (PRDATA,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name ="apb_trans");
super.new(name);
endfunction

endclass

