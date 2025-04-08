package alu;

import Prelude::*;
import StmtFSM::*;

// Define FSM states
typedef enum { IDLE, COMPUTE, DONE } State deriving (Eq, Bits);
typedef enum { ADD, SUB, MUL, DIV } Op deriving (Eq, Bits);

// ALU Interface
interface ALUIfc;
    method Action start(Bit#(32) a, Bit#(32) b, Op op);  // Set operands & operation
    method Bit#(32) getResult();                         // Get output
    method Bool isDone();                                // Indicate completion
endinterface

// FSM-Based ALU
module mkALU_FSM(ALUIfc);
    Reg#(Bit#(32)) result <- mkReg(0);   // Register to store result
    Reg#(Bit#(32)) opA <- mkReg(0);      // Operand A
    Reg#(Bit#(32)) opB <- mkReg(0);      // Operand B
    Reg#(Op) operation <- mkReg(ADD);    // Operation type
    Reg#(State) state <- mkReg(IDLE);    // FSM State

    rule compute if (state == COMPUTE);
        case (operation)
            ADD: result <= opA + opB;
            SUB: result <= opA - opB;
            MUL: result <= opA * opB;
            DIV: result <= (opB == 0) ? 0 : opA / opB;  // Prevent division by zero
        endcase
        state <= DONE;
    endrule

    // Start computation
    method Action start(Bit#(32) a, Bit#(32) b, Op op);
        action
            opA <= a;
            opB <= b;
            operation <= op;
            state <= COMPUTE;
        endaction
    endmethod

    // Return the result
    method Bit#(32) getResult();
        return result;
    endmethod

    // Return if computation is done
    method Bool isDone();
        return (state == DONE);
    endmethod
endmodule

endpackage

