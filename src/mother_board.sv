`default_nettype none

module mother_board(
    ctrl_bus_if.master ctrl_bus,
    io_bus_if.master io_bus,
    output logic [3:0] addr,
    output logic [7:0] data,
    output logic [3:0] reg_a,
    output logic [3:0] reg_b
);
    mem_bus_if #(.ADDR_WIDTH(4), .DATA_WIDTH(8)) mem_bus();
    cpu cpu(.ctrl_bus, .io_bus, .mem_bus, .reg_a, .reg_b);
    rom rom(.mem_bus);

    assign addr = mem_bus.addr;
    assign data = mem_bus.data;
endmodule

`default_nettype wire
