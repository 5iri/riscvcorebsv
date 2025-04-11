package RegisterFile;
  import Vector::*;
  interface RegFileIFC;
    method Bit#(32) rs1(Bit#(5) addr);
    method Bit#(32) rs2(Bit#(5) addr);
    method Action write(Bit#(5) addr, Bit#(32) data);
  endinterface

  module mkRegisterFile(RegFileIFC);
    Vector#(32, Reg#(Bit#(32))) regs <- replicateM(mkReg(0));
    method Bit#(32) rs1(Bit#(5) addr) = regs[addr];
    method Bit#(32) rs2(Bit#(5) addr) = regs[addr];
    method Action write(Bit#(5) addr, Bit#(32) data);
      if (addr != 0) regs[addr] <= data;
    endmethod
  endmodule
endpackage
