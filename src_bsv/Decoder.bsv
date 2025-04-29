// -----------------------------------------------------------------------------
//  Decoder.bsv – RV32-I/M/A subset instruction decoder (monomorphic build, struct return)
// -----------------------------------------------------------------------------
package Decoder;

import Prelude::*;
import Vector::*;   // replicateN, pack

// ──────────────── Struct to replace tuple8 ─────────────────
typedef struct {
  Bit#(5)  rs2;
  Bit#(5)  rs1;
  Bit#(32) imm;
  Bit#(5)  rd;
  Bool     rs1_valid;
  Bool     rs2_valid;
  Bit#(7)  opcode;
  Bit#(45) sig;
} DecoderOut deriving (Bits, FShow);

// ──────────────── Interface ─────────────────
interface DecoderIfc;
  method DecoderOut decode(Bit#(32) instr);
endinterface

// ──────────────── Implementation ─────────────────
(* synthesize, no_default_clock *)
module mkDecoder(DecoderIfc);

  method DecoderOut decode(Bit#(32) instr);

    // ───────────── Basic fields ─────────────
    Bit#(7) opcode = instr[6:0];
    Bit#(3) func3  = instr[14:12];
    Bit#(7) func7  = instr[31:25];

    // ───────────── Instruction-class preds ─────────────
    Bool is_i = (opcode==7'b0000011) || (opcode==7'b0010011) || (opcode==7'b1100111);
    Bool is_u = (opcode==7'b0010111) || (opcode==7'b0110111);
    Bool is_b = (opcode==7'b1100011);
    Bool is_j = (opcode==7'b1101111);
    Bool is_s = (opcode==7'b0100011);
    Bool is_r = (opcode==7'b0110011) || (opcode==7'b0100111) || (opcode==7'b1010011);
    Bool is_m = (opcode==7'b0110011) && (func7==7'b0000001);
    Bool is_a = (opcode==7'b0101111);

    // ───────────── Register indices ─────────────
    Bit#(5) rs2 = (is_r || is_s || is_b || is_a) ? instr[24:20] : 0;
    Bit#(5) rs1 = (is_r || is_s || is_b || is_i || is_a) ? instr[19:15] : 0;
    Bit#(5) rd  = (is_r || is_u || is_j || is_i || is_a) ? instr[11:7]  : 0;

    Bool rs1_valid = is_r || is_i || is_s || is_b || is_a;
    Bool rs2_valid = is_r || is_s || is_b || is_a;

    // ───────────── Immediate sign-extend precompute ─────────────
    Bit#(21) sx21 = pack(replicate(instr[31]));
    Bit#(20) sx20 = pack(replicate(instr[31]));
    Bit#(12) sx12 = pack(replicate(instr[31]));

    // ───────────── Immediate builds ─────────────
    Bit#(32) imm_i = { sx21, instr[30:20] };
    Bit#(32) imm_s = { sx21, instr[30:25], instr[11:7] };
    Bit#(32) imm_b = { sx20, instr[7], instr[30:25], instr[11:8], 1'b0 };
    Bit#(32) imm_u = { instr[31:12], 12'b0 };
    Bit#(32) imm_j = { sx12, instr[19:12], instr[20], instr[30:21], 1'b0 };

    Bit#(32) imm =
         is_i ? imm_i :
         is_s ? imm_s :
         is_b ? imm_b :
         is_u ? imm_u :
         is_j ? imm_j :
                32'h0;

    // ───────────── One-hot control signals ─────────────
    Bool sig0  = is_r && func3==3'h0 && func7==7'h00;  // add
    Bool sig1  = is_r && func3==3'h0 && func7==7'h20;  // sub
    Bool sig2  = is_r && func3==3'h4;                  // xor
    Bool sig3  = is_r && func3==3'h6;                  // or
    Bool sig4  = is_r && func3==3'h7;                  // and
    Bool sig5  = is_r && func3==3'h1;                  // sll
    Bool sig6  = is_r && func3==3'h5 && func7==7'h00;  // srl
    Bool sig7  = is_r && func3==3'h5 && func7==7'h20;  // sra
    Bool sig8  = is_r && func3==3'h2;                  // slt
    Bool sig9  = is_r && func3==3'h3;                  // sltu

    Bool sig10 = is_i && opcode==7'b0010011 && func3==3'h0;  // addi
    Bool sig11 = is_i && opcode==7'b0010011 && func3==3'h4;  // xori
    Bool sig12 = is_i && opcode==7'b0010011 && func3==3'h6;  // ori
    Bool sig13 = is_i && opcode==7'b0010011 && func3==3'h7;  // andi
    Bool sig14 = is_i && opcode==7'b0010011 && func3==3'h1 && imm[11:5]==7'h00; // slli
    Bool sig15 = is_i && opcode==7'b0010011 && func3==3'h5 && imm[11:5]==7'h00; // srli
    Bool sig16 = is_i && opcode==7'b0010011 && func3==3'h5 && imm[11:5]==7'h20; // srai
    Bool sig17 = is_i && opcode==7'b0010011 && func3==3'h2;  // slti
    Bool sig18 = is_i && opcode==7'b0010011 && func3==3'h3;  // sltiu

    Bool sig19 = opcode==7'b0000011 && func3==3'h0;  // lb
    Bool sig20 = opcode==7'b0000011 && func3==3'h1;  // lh
    Bool sig21 = opcode==7'b0000011 && func3==3'h2;  // lw
    Bool sig22 = opcode==7'b0000011 && func3==3'h4;  // lbu
    Bool sig23 = opcode==7'b0000011 && func3==3'h5;  // lhu

    Bool sig24 = is_s && func3==3'h0; // sb
    Bool sig25 = is_s && func3==3'h1; // sh
    Bool sig26 = is_s && func3==3'h2; // sw

    Bool sig27 = is_b && func3==3'h0; // beq
    Bool sig28 = is_b && func3==3'h1; // bne
    Bool sig29 = is_b && func3==3'h4; // blt
    Bool sig30 = is_b && func3==3'h5; // bge
    Bool sig31 = is_b && func3==3'h6; // bltu
    Bool sig32 = is_b && func3==3'h7; // bgeu

    Bool sig33 = opcode==7'b1101111;                 // jal
    Bool sig34 = opcode==7'b1100111 && func3==3'h0;  // jalr
    Bool sig35 = opcode==7'b0110111;                 // lui
    Bool sig36 = opcode==7'b0010111;                 // auipc

    Bool sig37 = is_m && func3==3'h0; // mul
    Bool sig38 = is_m && func3==3'h1; // mulh
    Bool sig39 = is_m && func3==3'h2; // mulhsu
    Bool sig40 = is_m && func3==3'h3; // mulhu
    Bool sig41 = is_m && func3==3'h4; // div
    Bool sig42 = is_m && func3==3'h5; // divu
    Bool sig43 = is_m && func3==3'h6; // rem
    Bool sig44 = is_m && func3==3'h7; // remu

    // ───────────── Pack all control signals ─────────────
    Bit#(45) sig = {
        pack(sig44), pack(sig43), pack(sig42), pack(sig41), pack(sig40), pack(sig39), pack(sig38), pack(sig37),
        pack(sig36), pack(sig35), pack(sig34), pack(sig33), pack(sig32), pack(sig31), pack(sig30), pack(sig29),
        pack(sig28), pack(sig27), pack(sig26), pack(sig25), pack(sig24), pack(sig23), pack(sig22), pack(sig21),
        pack(sig20), pack(sig19), pack(sig18), pack(sig17), pack(sig16), pack(sig15), pack(sig14), pack(sig13),
        pack(sig12), pack(sig11), pack(sig10), pack(sig9),  pack(sig8),  pack(sig7),  pack(sig6),  pack(sig5),
        pack(sig4),  pack(sig3),  pack(sig2),  pack(sig1),  pack(sig0)
    };

    // ───────────── Return ─────────────
    return DecoderOut { rs2: rs2, rs1: rs1, imm: imm, rd: rd,
                        rs1_valid: rs1_valid, rs2_valid: rs2_valid,
                        opcode: opcode, sig: sig };
  endmethod

endmodule : mkDecoder
endpackage
