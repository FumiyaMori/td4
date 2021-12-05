`default_nettype none
`include "package/lib_cpu.svh"

module cpu import lib_cpu::*; (
    ctrl_bus_if.master ctrl_bus,
    io_bus_if.master io_bus,
    mem_bus_if.master mem_bus,
    output logic [3:0] reg_a,
    output logic [3:0] reg_b
);
    REGS current;
    REGS next;

    // fetch
    assign mem_bus.addr = current.ip;

    // decode
    OPECODE opecode;
    logic [3:0] imm;
    decoder decoder(.fetch(mem_bus.data), .opecode, .imm);

    // execute
    alu alu(.opecode, .imm, .in(io_bus.in), .current, .next);

    // write_back
    write_reg write_reg(.ctrl_bus, .current, .next);

    assign io_bus.out = current.out;

    assign reg_a = current.a;
    assign reg_b = current.b;
endmodule

`default_nettype wire
