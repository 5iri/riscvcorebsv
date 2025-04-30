// -----------------------------------------------------------------------------
//  ControlUnit.bsv  –  RV32-I/M control unit (single-cycle, flat-port)
// -----------------------------------------------------------------------------
package ControlUnit;

import Prelude::*;
import Clocks::*;

`include "src_bsv/Alu.bsv"
`include "src_bsv/PC.bsv"
`include "src_bsv/Decoder.bsv"
`include "src_bsv/RegisterFile.bsv"

// ───────────────────────── Interface ─────────────────────────
interface ControlUnitIfc;
    method Action setInputs(
        Bit#(32) rs1_input,
        Bit#(32) rs2_input,
        Bit#(32) imm,
        Bit#(32) mem_read,
        Bit#(45) out_signal,
        Bit#(7) opcode,
        Bit#(32) pc_input,
        Bit#(64) aluOutput
    );
    
    method Bit#(13) getInstructions;
    method Bit#(32) getV1;
    method Bit#(32) getV2;
    method Bit#(32) getMemWrite;
    method Bool getWrEn;
    method Bit#(32) getAddr;
    method Bool getJSignal;
    method Bit#(32) getJump;
    method Bit#(32) getFinalOutput;
    method Bool getWrEnRf;
endinterface

(* synthesize *)
module mkControlUnit(ControlUnitIfc);
    // Internal registers
    Reg#(Bit#(13)) r_instructions <- mkReg(0);
    Reg#(Bit#(32)) r_v1 <- mkReg(0);
    Reg#(Bit#(32)) r_v2 <- mkReg(0);
    Reg#(Bit#(32)) r_mem_write <- mkReg(0);
    Reg#(Bool) r_wr_en <- mkReg(False);
    Reg#(Bit#(32)) r_addr <- mkReg(0);
    Reg#(Bool) r_j_signal <- mkReg(False);
    Reg#(Bit#(32)) r_jump <- mkReg(0);
    Reg#(Bit#(32)) r_final_output <- mkReg(0);
    Reg#(Bool) r_wr_en_rf <- mkReg(False);
    Reg#(Bit#(2)) r_mem_count <- mkReg(0);
    Reg#(Bit#(32)) r_simm <- mkReg(0);
    Reg#(Bit#(64)) r_val <- mkReg(0);

    // Method to set inputs and update control signals
    method Action setInputs(
        Bit#(32) rs1_input,
        Bit#(32) rs2_input,
        Bit#(32) imm,
        Bit#(32) mem_read,
        Bit#(45) out_signal,
        Bit#(7) opcode,
        Bit#(32) pc_input,
        Bit#(64) aluOutput
    );
        // Compute all values first
        Bit#(13) new_instructions = 0;
        Bit#(32) new_v1 = 0;
        Bit#(32) new_v2 = 0;
        Bit#(32) new_mem_write = 0;
        Bool new_wr_en = False;
        Bit#(32) new_addr = 0;
        Bool new_j_signal = False;
        Bit#(32) new_jump = 0;
        Bit#(32) new_final_output = 0;
        Bool new_wr_en_rf = False;
        Bit#(2) new_mem_count = 0;

        // Process based on opcode and out_signal
        case (opcode)
            // R-type and I-type instructions
            7'b0110011, 7'b0010011: begin
                case (out_signal)
                    // R-type instructions
                    45'h1: begin  // ADD
                        new_instructions = 13'd1;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h2: begin  // SUB
                        new_instructions = 13'd2;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h4: begin  // SLL
                        new_instructions = 13'd4;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h8: begin  // SLT
                        new_instructions = 13'd8;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h10: begin  // SLTU
                        new_instructions = 13'd16;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h20: begin  // XOR
                        new_instructions = 13'd32;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h40: begin  // SRL
                        new_instructions = 13'd64;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h80: begin  // SRA
                        new_instructions = 13'd128;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h100: begin  // OR
                        new_instructions = 13'd256;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h200: begin  // AND
                        new_instructions = 13'd512;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end

                    // I-type instructions
                    45'h400: begin  // ADDI
                        new_instructions = 13'd1;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h800: begin  // SLTI
                        new_instructions = 13'd8;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h1000: begin  // SLTIU
                        new_instructions = 13'd16;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h2000: begin  // XORI
                        new_instructions = 13'd32;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h4000: begin  // ORI
                        new_instructions = 13'd256;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h8000: begin  // ANDI
                        new_instructions = 13'd512;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h10000: begin  // SLLI
                        new_instructions = 13'd4;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h20000: begin  // SRLI
                        new_instructions = 13'd64;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h40000: begin  // SRAI
                        new_instructions = 13'd128;
                        new_v1 = rs1_input;
                        new_v2 = imm;
                        new_final_output = truncate(aluOutput);
                    end

                    // M extension instructions
                    45'h2000000000: begin  // MUL
                        new_instructions = 13'd1024;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h4000000000: begin  // MULH
                        new_instructions = 13'd1024;
                        if (rs1_input[31] == 1 && rs2_input[31] == 1) 
                            new_final_output = {1'b0, aluOutput[62:32]};
                        if (rs1_input[31] == 1 || rs2_input[31] == 1) 
                            new_final_output = {1'b1, aluOutput[62:32]};
                        if (rs1_input[31] == 1) begin
                            new_v1 = ~rs1_input + 1;
                        end else begin
                            new_v1 = rs1_input;
                        end
                        if (rs2_input[31] == 1) begin
                            new_v2 = ~rs2_input + 1;
                        end else begin
                            new_v2 = rs2_input;
                        end
                    end
                    45'h8000000000: begin  // MULHSU
                        new_instructions = 13'd1024;
                        new_final_output = {rs1_input[31], aluOutput[62:32]};
                        new_v1 = ~rs1_input + 1;
                        new_v2 = rs2_input;
                    end
                    45'h10000000000: begin  // MULHU
                        new_instructions = 13'd1024;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = aluOutput[63:32];
                    end
                    45'h20000000000: begin  // DIV
                        new_instructions = 13'd2048;
                        if (rs1_input[31] == 1 && rs2_input[31] == 1) 
                            new_final_output = {1'b0, aluOutput[30:0]};
                        if (rs1_input[31] == 1 || rs2_input[31] == 1) 
                            new_final_output = {1'b1, aluOutput[30:0]};
                        if (rs1_input[31] == 1) begin
                            new_v1 = ~rs1_input + 1;
                        end else begin
                            new_v1 = rs1_input;
                        end
                        if (rs2_input[31] == 1) begin
                            new_v2 = ~rs2_input + 1;
                        end else begin
                            new_v2 = rs2_input;
                        end
                    end
                    45'h40000000000: begin  // DIVU
                        new_instructions = 13'd2048;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                    45'h80000000000: begin  // REM
                        new_instructions = 13'd4096;
                        if (rs1_input[31] == 1 && rs2_input[31] == 1) 
                            new_final_output = {1'b0, aluOutput[30:0]};
                        if (rs1_input[31] == 1 || rs2_input[31] == 1) 
                            new_final_output = {1'b1, aluOutput[30:0]};
                        if (rs1_input[31] == 1) begin
                            new_v1 = ~rs1_input + 1;
                        end else begin
                            new_v1 = rs1_input;
                        end
                        if (rs2_input[31] == 1) begin
                            new_v2 = ~rs2_input + 1;
                        end else begin
                            new_v2 = rs2_input;
                        end
                    end
                    45'h100000000000: begin  // REMU
                        new_instructions = 13'd4096;
                        new_v1 = rs1_input;
                        new_v2 = rs2_input;
                        new_final_output = truncate(aluOutput);
                    end
                endcase
                new_j_signal = False;
                new_wr_en_rf = True;
            end

            // Load instructions
            7'b0000011: begin
                new_addr = rs1_input + imm;
                new_mem_count = truncate(new_addr % 4);
                new_wr_en = False;
                case (out_signal)
                    45'h80000: begin  // LB
                        case (new_mem_count)
                            2'b00: new_final_output = signExtend(mem_read[7:0]);
                            2'b01: new_final_output = signExtend(mem_read[15:8]);
                            2'b10: new_final_output = signExtend(mem_read[23:16]);
                            2'b11: new_final_output = signExtend(mem_read[31:24]);
                        endcase
                    end
                    45'h100000: begin  // LH
                        case (new_mem_count)
                            2'b00: new_final_output = signExtend(mem_read[15:0]);
                            2'b10: new_final_output = signExtend(mem_read[31:16]);
                        endcase
                    end
                    45'h200000: begin  // LW
                        new_final_output = mem_read;
                    end
                    45'h400000: begin  // LBU
                        case (new_mem_count)
                            2'b00: new_final_output = zeroExtend(mem_read[7:0]);
                            2'b01: new_final_output = zeroExtend(mem_read[15:8]);
                            2'b10: new_final_output = zeroExtend(mem_read[23:16]);
                            2'b11: new_final_output = zeroExtend(mem_read[31:24]);
                        endcase
                    end
                    45'h800000: begin  // LHU
                        case (new_mem_count)
                            2'b00: new_final_output = zeroExtend(mem_read[15:0]);
                            2'b10: new_final_output = zeroExtend(mem_read[31:16]);
                        endcase
                    end
                endcase
                new_j_signal = False;
            end

            // Store instructions
            7'b0100011: begin
                new_addr = rs1_input + imm;
                new_wr_en = True;
                new_mem_count = truncate(new_addr % 4);
                case (out_signal)
                    45'h1000000: begin  // SB
                        case (new_mem_count)
                            2'b00: new_mem_write = {mem_read[31:8], rs2_input[7:0]};
                            2'b01: new_mem_write = {mem_read[31:16], rs2_input[7:0], mem_read[7:0]};
                            2'b10: new_mem_write = {mem_read[31:24], rs2_input[7:0], mem_read[15:0]};
                            2'b11: new_mem_write = {rs2_input[7:0], mem_read[23:0]};
                        endcase
                    end
                    45'h2000000: begin  // SH
                        case (new_mem_count)
                            2'b00: new_mem_write = {mem_read[31:16], rs2_input[15:0]};
                            2'b10: new_mem_write = {rs2_input[15:0], mem_read[15:0]};
                        endcase
                    end
                    45'h4000000: begin  // SW
                        new_mem_write = rs2_input;
                    end
                endcase
                new_j_signal = False;
            end

            // Branch instructions
            7'b1100011: begin
                case (out_signal)
                    45'h8000000: begin  // BEQ
                        if (rs1_input == rs2_input) begin
                            new_jump = pc_input + signExtend({imm[12:1], 1'b0});
                            new_j_signal = True;
                        end else begin
                            new_j_signal = False;
                        end
                    end
                    45'h10000000: begin  // BNE
                        if (rs1_input != rs2_input) begin
                            new_jump = pc_input + signExtend({imm[12:1], 1'b0});
                            new_j_signal = True;
                        end else begin
                            new_j_signal = False;
                        end
                    end
                    45'h20000000: begin  // BLT
                        if (rs1_input < rs2_input) begin
                            new_jump = pc_input + signExtend({imm[12:1], 1'b0});
                            new_j_signal = True;
                        end else begin
                            new_j_signal = False;
                        end
                    end
                    45'h40000000: begin  // BGE
                        if (rs1_input >= rs2_input) begin
                            new_jump = pc_input + signExtend({imm[12:1], 1'b0});
                            new_j_signal = True;
                        end else begin
                            new_j_signal = False;
                        end
                    end
                    45'h80000000: begin  // BLTU
                        if (rs1_input < rs2_input) begin
                            new_jump = pc_input + signExtend({imm[12:1], 1'b0});
                            new_j_signal = True;
                        end else begin
                            new_j_signal = False;
                        end
                    end
                    45'h100000000: begin  // BGEU
                        if (rs1_input >= rs2_input) begin
                            new_jump = pc_input + signExtend({imm[12:1], 1'b0});
                            new_j_signal = True;
                        end else begin
                            new_j_signal = False;
                        end
                    end
                endcase
                new_wr_en = False;
            end

            // JAL instruction
            7'b1101111: begin
                if (out_signal == 45'h200000000) begin
                    new_jump = pc_input + imm;
                    new_j_signal = True;
                    new_final_output = pc_input + 4;
                end
                new_wr_en = False;
            end

            // JALR instruction
            7'b1100111: begin
                if (out_signal == 45'h400000000) begin
                    new_jump = rs1_input + imm;
                    new_j_signal = True;
                    new_final_output = pc_input + 4;
                end
                new_wr_en = False;
            end

            // LUI instruction
            7'b0110111: begin
                new_j_signal = False;
                if (out_signal == 45'h800000000) begin
                    new_final_output = {imm[31:12], 12'b0};
                end
                new_wr_en = False;
            end

            // AUIPC instruction
            7'b0010111: begin
                new_j_signal = False;
                if (out_signal == 45'h1000000000) begin
                    new_final_output = pc_input + {imm[31:12], 12'b0};
                end
                new_wr_en = False;
            end
        endcase

        // Update all registers in one atomic action
        r_instructions <= new_instructions;
        r_v1 <= new_v1;
        r_v2 <= new_v2;
        r_mem_write <= new_mem_write;
        r_wr_en <= new_wr_en;
        r_addr <= new_addr;
        r_j_signal <= new_j_signal;
        r_jump <= new_jump;
        r_final_output <= new_final_output;
        r_wr_en_rf <= new_wr_en_rf;
        r_mem_count <= new_mem_count;
    endmethod

    // Output methods
    method Bit#(13) getInstructions = r_instructions;
    method Bit#(32) getV1 = r_v1;
    method Bit#(32) getV2 = r_v2;
    method Bit#(32) getMemWrite = r_mem_write;
    method Bool getWrEn = r_wr_en;
    method Bit#(32) getAddr = r_addr;
    method Bool getJSignal = r_j_signal;
    method Bit#(32) getJump = r_jump;
    method Bit#(32) getFinalOutput = r_final_output;
    method Bool getWrEnRf = r_wr_en_rf;
endmodule

endpackage
