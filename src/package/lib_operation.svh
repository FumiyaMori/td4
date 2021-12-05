`ifndef LIB_OPERATION_SVH
`define LIB_OPERATION_SVH

`include "lib_cpu.svh"

package lib_operation;
    import lib_cpu :: REGS;

    function automatic REGS nop(REGS current);
        nop    = current;
        nop.cf = 1'b0;
        nop.ip = current.ip + 4'd1;
    endfunction

    function automatic REGS mov_a_b(REGS current);
        mov_a_b = nop(current);
        mov_a_b.a = current.b;
    endfunction

    function automatic REGS mov_b_a(REGS current);
        mov_b_a = nop(current);
        mov_b_a.b = current.a;
    endfunction

    function automatic REGS mov_a_imm(REGS current, logic [3:0] imm);
        mov_a_imm = nop(current);
        mov_a_imm.a = imm;
    endfunction

    function automatic REGS mov_b_imm(REGS current, logic [3:0] imm);
        mov_b_imm = nop(current);
        mov_b_imm.b = imm;
    endfunction

    function automatic REGS in_a(REGS current, logic [3:0] in);
        in_a = nop(current);
        in_a.a = in;
    endfunction

    function automatic REGS in_b(REGS current, logic [3:0] in);
        in_b = nop(current);
        in_b.b = in;
    endfunction

    function automatic REGS out_b(REGS current);
        out_b = nop(current);
        out_b.out = current.b;
    endfunction

    function automatic REGS out_imm(REGS current, logic [3:0] imm);
        out_imm = nop(current);
        out_imm.out = imm;
    endfunction

    function automatic REGS add_a_imm(REGS current, logic [3:0] imm);
        add_a_imm = nop(current);
        {add_a_imm.cf, add_a_imm.a} = current.a + imm;
    endfunction

    function automatic REGS add_b_imm(REGS current, logic [3:0] imm);
        add_b_imm = nop(current);
        {add_b_imm.cf, add_b_imm.b} = current.b + imm;
    endfunction

    function automatic REGS jmp_imm(REGS current, logic [3:0] imm);
        jmp_imm = nop(current);
        jmp_imm.ip = imm;
    endfunction

    function automatic REGS jnc_imm(REGS current, logic [3:0] imm);
        jnc_imm = nop(current);
        jnc_imm.ip = current.cf ? current.ip + 4'd1 : imm;
    endfunction

endpackage
`endif
