package test;

import Prelude::*;
import Vector::*;

(* synthesize *)
module mkTest();

   // one-bit value to replicate
   Bit#(1) bit1 = 1'b1;

   // replicate bit1 eight times → Bit#(8)
   Bit#(8) replicated = pack(replicate(bit1));


   rule show;
      $display("replicated = %b", replicated);   // expect 11111111
   endrule

endmodule: mkTest
endpackage
