// -----------------------------------------------------------------------------
//  Decoder.bsv  –  RV32-I/M subset, flat-port interface (compile-ready)
// -----------------------------------------------------------------------------

import Prelude::*;
import Vector::*;         // replicate / pack

// ───────────────────────── Interface ─────────────────────────
interface DecoderIfc;
  (* always_ready, always_enabled *) method Action   decode(Bit#(32) instr);
  (* always_ready, always_enabled *) method Bit#(5)  rs2();
  (* always_ready, always_enabled *) method Bit#(5)  rs1();
  (* always_ready, always_enabled *) method Bit#(32) imm();
  (* always_ready, always_enabled *) method Bit#(5)  rd();
  (* always_ready, always_enabled *) method Bool     rs1_valid();
  (* always_ready, always_enabled *) method Bool     rs2_valid();
  (* always_ready, always_enabled *) method Bit#(7)  opcode();
  (* always_ready, always_enabled *) method Bit#(45) out_signal();
endinterface

// ───────────────────── Implementation ───────────────────────
(* synthesize *)
module mkDecoder(DecoderIfc);

  // ── state ─────────────────────────────────────────────────
  Reg#(Bit#(5))  r_rs2        <- mkReg(0);
  Reg#(Bit#(5))  r_rs1        <- mkReg(0);
  Reg#(Bit#(32)) r_imm        <- mkReg(0);
  Reg#(Bit#(5))  r_rd         <- mkReg(0);
  Reg#(Bool)     r_rs1_valid  <- mkReg(False);
  Reg#(Bool)     r_rs2_valid  <- mkReg(False);
  Reg#(Bit#(7))  r_opcode     <- mkReg(0);
  Reg#(Bit#(45)) r_sig        <- mkReg(0);

  // ── helper: sign-extension with replicate/pack ────────────
  function Bit#(n) sx(Bit#(1) s) provisos(Add#(m,0,n));
    return pack(replicate(s));
  endfunction

  // ── setter ────────────────────────────────────────────────
  method Action decode(Bit#(32) instr);
    // basic fields
    Bit#(7) opcode_v = instr[6:0];
    Bit#(3) func3    = instr[14:12];
    Bit#(7) func7    = instr[31:25];

    // major type decodes
    Bool is_i = (opcode_v==7'b0000011) || (opcode_v==7'b0010011) || (opcode_v==7'b1100111);
    Bool is_u = (opcode_v==7'b0010111) || (opcode_v==7'b0110111);
    Bool is_b = (opcode_v==7'b1100011);
    Bool is_j = (opcode_v==7'b1101111);
    Bool is_s = (opcode_v==7'b0100011);
    Bool is_r = (opcode_v==7'b0110011) || (opcode_v==7'b0100111) || (opcode_v==7'b1010011);
    Bool is_m = (opcode_v==7'b0110011) && (func7==7'b0000001);
    Bool is_a = (opcode_v==7'b0101111);

    // register fields
    Bit#(5) rs2_v = (is_r || is_s || is_b || is_a) ? instr[24:20] : 0;
    Bit#(5) rs1_v = (is_r || is_s || is_b || is_i || is_a) ? instr[19:15] : 0;
    Bit#(5) rd_v  = (is_r || is_u || is_j || is_i || is_a) ? instr[11:7]  : 0;

    // sign-extended immediates
    Bit#(32) imm_i = { sx( 1'b1 & instr[31] ) , instr[30:20] };
    Bit#(32) imm_s = { sx( 1'b1 & instr[31] ) , instr[30:25], instr[11:7] };
    Bit#(32) imm_b = { sx( 1'b1 & instr[31] ) , instr[7], instr[30:25], instr[11:8], 1'b0 };
    Bit#(32) imm_u = { instr[31:12], 12'b0 };
    Bit#(32) imm_j = { sx( 1'b1 & instr[31] ) , instr[19:12], instr[20], instr[30:21], 1'b0 };

    Bit#(32) imm_v =
         is_i ? imm_i :
         is_s ? imm_s :
         is_b ? imm_b :
         is_u ? imm_u :
         is_j ? imm_j :
                32'h0;

    // validity
    Bool rs1_val_v = is_r || is_i || is_s || is_b || is_a;
    Bool rs2_val_v = is_r || is_s || is_b || is_a;

    // one-hot micro-op signals  (sig0 … sig44)
    Bool sig0  = is_r && func3==3'h0 && func7==7'h00;   // add
    Bool sig1  = is_r && func3==3'h0 && func7==7'h20;   // sub
    Bool sig2  = is_r && func3==3'h4;                   // xor
    Bool sig3  = is_r && func3==3'h6;                   // or
    Bool sig4  = is_r && func3==3'h7;                   // and
    Bool sig5  = is_r && func3==3'h1;                   // sll
    Bool sig6  = is_r && func3==3'h5 && func7==7'h00;   // srl
    Bool sig7  = is_r && func3==3'h5 && func7==7'h20;   // sra
    Bool sig8  = is_r && func3==3'h2;                   // slt
    Bool sig9  = is_r && func3==3'h3;                   // sltu

    Bool sig10 = is_i && opcode_v==7'b0010011 && func3==3'h0; // addi
    Bool sig11 = is_i && opcode_v==7'b0010011 && func3==3'h4; // xori
    Bool sig12 = is_i && opcode_v==7'b0010011 && func3==3'h6; // ori
    Bool sig13 = is_i && opcode_v==7'b0010011 && func3==3'h7; // andi
    Bool sig14 = is_i && opcode_v==7'b0010011 && func3==3'h1 && imm_v[11:5]==7'h00; // slli
    Bool sig15 = is_i && opcode_v==7'b0010011 && func3==3'h5 && imm_v[11:5]==7'h00; // srli
    Bool sig16 = is_i && opcode_v==7'b0010011 && func3==3'h5 && imm_v[11:5]==7'h20; // srai
    Bool sig17 = is_i && opcode_v==7'b0010011 && func3==3'h2; // slti
    Bool sig18 = is_i && opcode_v==7'b0010011 && func3==3'h3; // sltiu
    Bool sig19 = opcode_v==7'b0000011 && func3==3'h0; // lb
    Bool sig20 = opcode_v==7'b0000011 && func3==3'h1; // lh
    Bool sig21 = opcode_v==7'b0000011 && func3==3'h2; // lw
    Bool sig22 = opcode_v==7'b0000011 && func3==3'h4; // lbu
    Bool sig23 = opcode_v==7'b0000011 && func3==3'h5; // lhu
    Bool sig24 = is_s && func3==3'h0; // sb
    Bool sig25 = is_s && func3==3'h1; // sh
    Bool sig26 = is_s && func3==3'h2; // sw
    Bool sig27 = is_b && func3==3'h0; // beq
    Bool sig28 = is_b && func3==3'h1; // bne
    Bool sig29 = is_b && func3==3'h4; // blt
    Bool sig30 = is_b && func3==3'h5; // bge
    Bool sig31 = is_b && func3==3'h6; // bltu
    Bool sig32 = is_b && func3==3'h7; // bgeu
    Bool sig33 = opcode_v==7'b1101111; // jal
    Bool sig34 = opcode_v==7'b1100111 && func3==3'h0; // jalr
    Bool sig35 = opcode_v==7'b0110111; // lui
    Bool sig36 = opcode_v==7'b0010111; // auipc
    Bool sig37 = is_m && func3==3'h0; // mul
    Bool sig38 = is_m && func3==3'h1; // mulh
    Bool sig39 = is_m && func3==3'h2; // mulhsu
    Bool sig40 = is_m && func3==3'h3; // mulhu
    Bool sig41 = is_m && func3==3'h4; // div
    Bool sig42 = is_m && func3==3'h5; // divu
    Bool sig43 = is_m && func3==3'h6; // rem
    Bool sig44 = is_m && func3==3'h7; // remu

    Bit#(45) sig_v = {
        pack(sig44), pack(sig43), pack(sig42), pack(sig41), pack(sig40),
        pack(sig39), pack(sig38), pack(sig37), pack(sig36), pack(sig35),
        pack(sig34), pack(sig33), pack(sig32), pack(sig31), pack(sig30),
        pack(sig29), pack(sig28), pack(sig27), pack(sig26), pack(sig25),
        pack(sig24), pack(sig23), pack(sig22), pack(sig21), pack(sig20),
        pack(sig19), pack(sig18), pack(sig17), pack(sig16), pack(sig15),
        pack(sig14), pack(sig13), pack(sig12), pack(sig11), pack(sig10),
        pack(sig9),  pack(sig8),  pack(sig7),  pack(sig6),  pack(sig5),
        pack(sig4),  pack(sig3),  pack(sig2),  pack(sig1),  pack(sig0)
    };

    // latch everything
    r_rs2        <= rs2_v;
    r_rs1        <= rs1_v;
    r_rd         <= rd_v;
    r_imm        <= imm_v;
    r_rs1_valid  <= rs1_val_v;
    r_rs2_valid  <= rs2_val_v;
    r_opcode     <= opcode_v;
    r_sig        <= sig_v;
  endmethod

  // ── getters (combinational) ───────────────────────────────
  method Bit#(5)  rs2()        = r_rs2;
  method Bit#(5)  rs1()        = r_rs1;
  method Bit#(32) imm()        = r_imm;
  method Bit#(5)  rd()         = r_rd;
  method Bool     rs1_valid()  = r_rs1_valid;
  method Bool     rs2_valid()  = r_rs2_valid;
  method Bit#(7)  opcode()     = r_opcode;
  method Bit#(45) out_signal() = r_sig;

endmodule : mkDecoder
