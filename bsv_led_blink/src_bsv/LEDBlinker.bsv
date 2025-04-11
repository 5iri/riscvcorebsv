package LEDBlinker;

import StmtFSM::*;
import Clocks::*;

interface LEDBlinker_IFC;
    method Bit#(8) leds;
    method Action reset();
endinterface

(*synthesize*)
module mkLEDBlinker #(Clock clk, Reset rst) (LEDBlinker_IFC);
    // Parameters for clock division

    Integer clockFreq = 50000000; // 50MHz system clock
    Integer blinkFreq = 1;          // 1Hz Blink rate
    Integer countMax = clockFreq/ (2 * blinkFreq);

    // Registers
    Reg#(Bit#(32)) counter <- mkReg(0, clocked_by clk, reset_by rst);
    Reg#(Bool) patternState <- mkReg(False, clocked_by clk, reset_by rst);
    Reg#(Bit#(8)) ledValue <- mkReg(8'b10101010, clocked_by clk, reset_by rst);

    // Counter Logic

    rule updateCounter;
      if (counter >= fromInteger(countMax - 1))
        counter <= 0;
      else
        counter <= counter + 1;
    endrule

    // Pattern toggle logic
    rule togglePattern (counter == 0);
      patternState <= !patternState;

      if (!patternState)
        ledValue <= 8'b10101010;
      else
        ledValue <= 8'b01010101;
    endrule

    // Interface methods
    method Bit#(8) leds();
      return ledValue;
    endmethod

    method Action reset();
      counter <= 0;
      patternState <= False;
      ledValue <= 8'b10101010;
    endmethod
  endmodule


// Top-level module wrapper with default clock and reset
(* synthesize *)

module mkLEDBlinkerTop (LEDBlinker_IFC);
  Clock clk <- exposeCurrentClock;
  Reset rst <- exposeCurrentReset;

  LEDBlinker_IFC blinker <- mkLEDBlinker(clk, rst);

  method Bit#(8) leds = blinker.leds;
  method Action reset = blinker.reset;
endmodule

endpackage
