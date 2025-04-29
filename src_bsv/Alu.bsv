package Alu;
import Prelude::*;   // Bit#, Int#, etc.

/*------------------------------------------------------------------
  Pure combinational ALU
------------------------------------------------------------------*/
interface AluIfc;
  method Bit#(64) exec(Bit#(32) in1, Bit#(32) in2, Bit#(13) instr);
endinterface

(* synthesize, no_default_clock, no_default_reset *)
module mkAlu(AluIfc);

  method Bit#(64) exec(Bit#(32) in1, Bit#(32) in2, Bit#(13) instr);
    Bit#(64) result;

    // signed view of in1 for SRA
    Int#(32) signedIn1 = unpack(in1);

    case (instr)
      13'd1    : result = zeroExtend(in1 + in2);              // add
      13'd2    : result = zeroExtend(in1 - in2);              // sub
      13'd4    : result = zeroExtend(in1 ^ in2);              // xor
      13'd8    : result = zeroExtend(in1 | in2);              // or
      13'd16   : result = zeroExtend(in1 & in2);              // and
      13'd32   : result = zeroExtend(in1 << in2[4:0]);        // sll
      13'd64   : result = zeroExtend(in1 >> in2[4:0]);        // srl
      13'd128  : result = zeroExtend(pack(signedIn1 >> in2[4:0])); // sra
      13'd256  : result = zeroExtend(pack(in1 < in2));        // slt  (unsigned, like orig)
      13'd512  : result = zeroExtend(pack(in1 < in2));        // sltu
      13'd1024 : result = (zeroExtend(in1) * zeroExtend(in2)); // mul (64-bit product)
      13'd2048 : result = zeroExtend(in1 / in2);              // div  (unsigned)
      13'd4096 : result = zeroExtend(in1 % in2);              // rem  (unsigned)
      default  : result = 0;
    endcase

    return result;
  endmethod

endmodule : mkAlu
endpackage
