interface io_bus_if #(parameter WIDTH) ();
    logic [WIDTH-1:0] in;
    logic [WIDTH-1:0] out;
    modport master(input in, output out);
endinterface
