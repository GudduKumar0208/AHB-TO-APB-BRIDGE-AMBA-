class bridge_config extends uvm_object;

`uvm_object_utils(bridge_config);

uvm_active_passive_enum ahb_is_active=UVM_ACTIVE;
//uvm_active_passive_enum ahb_is_active=UVM_PASSIVE;


uvm_active_passive_enum apb_is_active=UVM_ACTIVE;
//uvm_active_passive_enum apb_is_active=UVM_PASSIVE;



function new(string name="bridge_config");

super.new(name);
endfunction

bit scoreboard=0;
//bit driver=0;



endclass