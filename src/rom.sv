`default_nettype none

module rom(
    mem_bus_if.slave mem_bus
);
    logic [7:0] rom_array [16];
    initial $readmemh("../data/rom_data.mem", rom_array);
    assign mem_bus.data = rom_array[mem_bus.addr];
endmodule

`default_nettype wire
