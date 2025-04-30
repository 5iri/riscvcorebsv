// src_bsv/RegisterFile.bsv

import Prelude::*;    // Bool, Bit#, etc.
import Clocks::*;     // Clock, Reset, mkReg
import RegFile::*;    // RegFile#, mkRegFile#, upd, sub

// ------------------------------------------------------------------
//
//  - write(wr_en, rd[4:0], data[31:0])
//  - read1(rs1_valid, rs1[4:0]) -> 32-bit or 0
//  - read2(rs2_valid, rs2[4:0]) -> 32-bit or 0
// ------------------------------------------------------------------
interface RegisterFileIfc;
  method Action       write  ( Bool      wr_en
                              , Bit#(5)   rd
                              , Bit#(32)  data
                              );
  method Bit#(32)     read1  ( Bool      valid
                              , Bit#(5)   rs1
                              );
  method Bit#(32)     read2  ( Bool      valid
                              , Bit#(5)   rs2
                              );
endinterface

(* synthesize *)
module mkRegisterFile#(Clock clk, Reset rst)(RegisterFileIfc);

  RegFile#(Bit#(5), Bit#(32)) rf <- mkRegFile(0,31);   // Addr, Data

  // synchronous write port
  method Action write(Bool wr_en, Bit#(5) rd, Bit#(32) data);
    if (wr_en && (rd != 0))            // write real data
        rf.upd(rd, data);              // one call
    else                               // otherwise keep x0 = 0
        rf.upd(0, 0);                  // one call
  endmethod

  method Bit#(32) read1(Bool v, Bit#(5) rs1);
    if (v) return rf.sub(rs1); else return 0;
  endmethod

  method Bit#(32) read2(Bool v, Bit#(5) rs2);
    if (v) return rf.sub(rs2); else return 0;
  endmethod
endmodule
