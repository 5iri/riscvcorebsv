package RegisterFile;

  interface RegFileIFC;
    method Bit#(32) rs1(Bit#(5) addr);
    method Bit#(32) rs2(Bit#(5) addr);
    method Action write(Bit#(5) addr, Bit#(32) data);
  endinterface

  module mkRegisterFile(RegFileIFC);
    // Individual registers x1-x31 (x0 is hardwired to 0)
    Reg#(Bit#(32)) x1 <- mkReg(0);
    Reg#(Bit#(32)) x2 <- mkReg(0);
    Reg#(Bit#(32)) x3 <- mkReg(0);
    Reg#(Bit#(32)) x4 <- mkReg(0);
    Reg#(Bit#(32)) x5 <- mkReg(0);
    Reg#(Bit#(32)) x6 <- mkReg(0);
    Reg#(Bit#(32)) x7 <- mkReg(0);
    Reg#(Bit#(32)) x8 <- mkReg(0);
    Reg#(Bit#(32)) x9 <- mkReg(0);
    Reg#(Bit#(32)) x10 <- mkReg(0);
    Reg#(Bit#(32)) x11 <- mkReg(0);
    Reg#(Bit#(32)) x12 <- mkReg(0);
    Reg#(Bit#(32)) x13 <- mkReg(0);
    Reg#(Bit#(32)) x14 <- mkReg(0);
    Reg#(Bit#(32)) x15 <- mkReg(0);
    Reg#(Bit#(32)) x16 <- mkReg(0);
    Reg#(Bit#(32)) x17 <- mkReg(0);
    Reg#(Bit#(32)) x18 <- mkReg(0);
    Reg#(Bit#(32)) x19 <- mkReg(0);
    Reg#(Bit#(32)) x20 <- mkReg(0);
    Reg#(Bit#(32)) x21 <- mkReg(0);
    Reg#(Bit#(32)) x22 <- mkReg(0);
    Reg#(Bit#(32)) x23 <- mkReg(0);
    Reg#(Bit#(32)) x24 <- mkReg(0);
    Reg#(Bit#(32)) x25 <- mkReg(0);
    Reg#(Bit#(32)) x26 <- mkReg(0);
    Reg#(Bit#(32)) x27 <- mkReg(0);
    Reg#(Bit#(32)) x28 <- mkReg(0);
    Reg#(Bit#(32)) x29 <- mkReg(0);
    Reg#(Bit#(32)) x30 <- mkReg(0);
    Reg#(Bit#(32)) x31 <- mkReg(0);

    // Read port 1
    method Bit#(32) rs1(Bit#(5) addr);
      case (addr)
        5'b00000: return 0;      // x0
        5'b00001: return x1;
        5'b00010: return x2;
        5'b00011: return x3;
        5'b00100: return x4;
        5'b00101: return x5;
        5'b00110: return x6;
        5'b00111: return x7;
        5'b01000: return x8;
        5'b01001: return x9;
        5'b01010: return x10;
        5'b01011: return x11;
        5'b01100: return x12;
        5'b01101: return x13;
        5'b01110: return x14;
        5'b01111: return x15;
        5'b10000: return x16;
        5'b10001: return x17;
        5'b10010: return x18;
        5'b10011: return x19;
        5'b10100: return x20;
        5'b10101: return x21;
        5'b10110: return x22;
        5'b10111: return x23;
        5'b11000: return x24;
        5'b11001: return x25;
        5'b11010: return x26;
        5'b11011: return x27;
        5'b11100: return x28;
        5'b11101: return x29;
        5'b11110: return x30;
        5'b11111: return x31;
        default: return 0;
      endcase
    endmethod

    // Read port 2
    method Bit#(32) rs2(Bit#(5) addr);
      case (addr)
        5'b00000: return 0;      // x0
        5'b00001: return x1;
        5'b00010: return x2;
        5'b00011: return x3;
        5'b00100: return x4;
        5'b00101: return x5;
        5'b00110: return x6;
        5'b00111: return x7;
        5'b01000: return x8;
        5'b01001: return x9;
        5'b01010: return x10;
        5'b01011: return x11;
        5'b01100: return x12;
        5'b01101: return x13;
        5'b01110: return x14;
        5'b01111: return x15;
        5'b10000: return x16;
        5'b10001: return x17;
        5'b10010: return x18;
        5'b10011: return x19;
        5'b10100: return x20;
        5'b10101: return x21;
        5'b10110: return x22;
        5'b10111: return x23;
        5'b11000: return x24;
        5'b11001: return x25;
        5'b11010: return x26;
        5'b11011: return x27;
        5'b11100: return x28;
        5'b11101: return x29;
        5'b11110: return x30;
        5'b11111: return x31;
        default: return 0;
      endcase
    endmethod

    // Write port
    method Action write(Bit#(5) addr, Bit#(32) data);
      if (addr != 0) begin  // x0 is hardwired to 0
        case (addr)
          5'b00001: x1 <= data;
          5'b00010: x2 <= data;
          5'b00011: x3 <= data;
          5'b00100: x4 <= data;
          5'b00101: x5 <= data;
          5'b00110: x6 <= data;
          5'b00111: x7 <= data;
          5'b01000: x8 <= data;
          5'b01001: x9 <= data;
          5'b01010: x10 <= data;
          5'b01011: x11 <= data;
          5'b01100: x12 <= data;
          5'b01101: x13 <= data;
          5'b01110: x14 <= data;
          5'b01111: x15 <= data;
          5'b10000: x16 <= data;
          5'b10001: x17 <= data;
          5'b10010: x18 <= data;
          5'b10011: x19 <= data;
          5'b10100: x20 <= data;
          5'b10101: x21 <= data;
          5'b10110: x22 <= data;
          5'b10111: x23 <= data;
          5'b11000: x24 <= data;
          5'b11001: x25 <= data;
          5'b11010: x26 <= data;
          5'b11011: x27 <= data;
          5'b11100: x28 <= data;
          5'b11101: x29 <= data;
          5'b11110: x30 <= data;
          5'b11111: x31 <= data;
          default: noAction;
        endcase
      end
    endmethod
  endmodule
endpackage
