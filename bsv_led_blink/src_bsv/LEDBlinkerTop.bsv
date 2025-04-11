package LEDBlinkerTop;
  import StmtFSM::*;
  import Clocks::*;
  import mkLEDBlinker::*;
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


