import Clocks::*;
import Prelude::*;

interface PcIfc;
    method Action       setJumpSignal(Bool      s);
    method Action       setJumpAddr  (Bit#(32)  a);
    method Bit#(32)     out_sign     ();
endinterface

module mkPC#(Clock clk, Reset rst) (PcIfc);
    Reg#(Bit#(32)) next_pc     <- mkReg(0, clocked_by clk, reset_by rst);
    Reg#(Bool)    j_signal_reg <- mkReg(False, clocked_by clk, reset_by rst);
    Reg#(Bit#(32)) jump_reg    <- mkReg(0, clocked_by clk, reset_by rst);

    // Runs on every rising edge of `clk`
    rule advancePC;
        if (j_signal_reg)
            next_pc <= jump_reg;
        else 
            next_pc <= next_pc + 32'd4;
    endrule

    // methods to drive the inputs
    method Action setJumpSignal(Bool s);
        j_signal_reg <= s;
    endmethod

    method Action setJumpAddr(Bit#(32) a);
        jump_reg <= a;
    endmethod

    // read-back
    method Bit#(32) out_sign() = next_pc;
endmodule
