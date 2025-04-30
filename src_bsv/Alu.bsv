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
    Bit#(64) aluOutput;

    // signed view of in1 for SRA
    Int#(32) signedIn1 = unpack(in1);

    case (instr)
      13'd1    : aluOutput = zeroExtend(in1 + in2);              // add
      13'd2    : aluOutput = zeroExtend(in1 - in2);              // sub
      13'd4    : aluOutput = zeroExtend(in1 ^ in2);              // xor
      13'd8    : aluOutput = zeroExtend(in1 | in2);              // or
      13'd16   : aluOutput = zeroExtend(in1 & in2);              // and
      13'd32   : aluOutput = zeroExtend(in1 << in2[4:0]);        // sll
      13'd64   : aluOutput = zeroExtend(in1 >> in2[4:0]);        // srl
      13'd128  : aluOutput = zeroExtend(pack(signedIn1 >> in2[4:0])); // sra
      13'd256  : aluOutput = zeroExtend(pack(in1 < in2));        // slt  (unsigned, like orig)
      13'd512  : aluOutput = zeroExtend(pack(in1 < in2));        // sltu
      13'd1024 : aluOutput = (zeroExtend(in1) * zeroExtend(in2)); // mul (64-bit product)
      13'd2048 : aluOutput = zeroExtend(in1 / in2);              // div  (unsigned)
      13'd4096 : aluOutput = zeroExtend(in1 % in2);              // rem  (unsigned)
      default  : aluOutput = 0;
    endcase

    return aluOutput;
  endmethod

endmodule : mkAlu
