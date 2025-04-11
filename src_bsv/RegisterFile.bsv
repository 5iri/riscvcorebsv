package RegisterFile;
  import Vector::*;
  interface RegFileIFC;
    method Bit#(32) rs1(Bit#(5) addr);
    method Bit#(32) rs2(Bit#(5) addr);
    method Action write(Bit#(5) addr, Bit#(32) data);
  endinterface

  module mkRegisterFile(RegFileIFC);
    Vector#(32, Reg#(Bit#(32))) regs <- replicateM(mkReg(0));

    // Read port 1
    method Bit#(32) rs1(Bit#(5) addr);
      return regs[addr];
    endmethod

    // Read port 2
    method Bit#(32) rs2(Bit#(5) addr);
      return regs[addr];
    endmethod

   method Action write(Bit#(5) addr, Bit#(32) data);
      if (addr != 0) regs[addr] <= data;
    endmethod
  endmodule
endpackage
