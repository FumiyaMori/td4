`default_nettype none

module top(
      input  logic       CLOCK_50,
      input  logic       RESET_N,
      input  logic [3:0] SW,
      output logic [9:0] LEDR,
      output logic [6:0] HEX0,
      output logic [6:0] HEX1,
      output logic [6:0] HEX2,
      output logic [6:0] HEX3,
      output logic [6:0] HEX4
);
      logic clk;
      prescaler #(.RATIO(100_000_000)) prescaler(
            .quick_clock(CLOCK_50),
            .slow_clock(clk)
      );

      ctrl_bus_if ctrl_bus();
      assign ctrl_bus.clk = clk;
      assign ctrl_bus.n_reset = RESET_N;

      io_bus_if #(.WIDTH(4)) io_bus();
      assign io_bus.in = SW;
      assign LEDR[3:0] = io_bus.out;

      logic [3:0] addr;
      logic [7:0] data;
      logic [3:0] reg_a;
      logic [3:0] reg_b;
      mother_board mother_board(.ctrl_bus, .io_bus, .addr, .data, .reg_a, .reg_b);

      assign LEDR[8:4] = '0;
      assign LEDR[9] = ~RESET_N;
      hex_7segled_decorder hex_addr_bus(.in(addr), .out(HEX4));
      hex_7segled_decorder hex_data_bus_h(.in(data[7:4]), .out(HEX3));
      hex_7segled_decorder hex_data_bus_l(.in(data[3:0]), .out(HEX2));
      hex_7segled_decorder hex_reg_a(.in(reg_a), .out(HEX1));
      hex_7segled_decorder hex_reg_b(.in(reg_b), .out(HEX0));
endmodule

`default_nettype wire
