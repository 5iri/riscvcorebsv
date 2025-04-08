package uart_rx;

  import Prelude::*;
  import FIFO::*;

  interface Uart_rx;
    method Action recieve(Bit#(1) rx);       // Input Serial Data 
    method ActionValue#(Bit#(8)) get();       // Get received Byte
  endinterface

  module mkuart_rx(Uart_rx);
    Reg#(Bit#(8)) shiftReg <- mkReg(0);       // Shift register for received bits
    Reg#(Bit#(4)) bitCount <- mkReg(0);        // Counter for bits received 
    FIFO#(Bit#(8)) dataFifo <- mkFIFO;         // FIFO to store complete bytes

    // Method to capture each incoming bit, update the shift register and bit counter,
    // and store a complete byte into the FIFO once 8 bits are received.
    method Action recieve(Bit#(1) rx);
      let currentCount = bitCount;                   // Read current count
      let newShift = {rx, shiftReg[7:1]};              // Shift in the new bit
      shiftReg <= newShift;
      if (currentCount == 4'd7) begin                // When this is the 8th bit...
        dataFifo.enq(newShift);                      // Enqueue the complete byte
      end
      let newCount = (currentCount == 4'd7) ? 0 : currentCount + 1;
      bitCount <= newCount;                          // Update the bit counter once
    endmethod

    // Method to read a byte from the FIFO.
    method ActionValue#(Bit#(8)) get();
      let data = dataFifo.first;                     // Read the first element from the FIFO
      dataFifo.deq;                                  // Dequeue it
      return data;
    endmethod

  endmodule

endpackage

