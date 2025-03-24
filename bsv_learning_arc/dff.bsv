package dff; //Define a package named DFF

import Prelude::*; //Import Register module 

// Define an interface for D Flip-Flop
interface DFFIfc;
  method Action set(Bit#(1) d); // set input D 
  method Bit#(1) get();         // Get output Q
endinterface

//Define the D Flip-Flop module 
module mkDFF(DFFIfc);
  Reg#(Bit#(1)) q <- mkReg(0); // Register to store state

  method Action set(Bit#(1) d);
    q <= d; // Update on clock edge
  endmethod

  method Bit#(1) get();
    return q;
  endmethod

endmodule
endpackage
