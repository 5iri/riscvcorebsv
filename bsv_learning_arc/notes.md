# Notes on how bsv works

 - there's a standard library called prelude which needs to be imported. (don't know what it is yet).
 - You create an interface on what are the pins that are going to be accessed from outside the module.
 - Use the interface to set up the "action" of the interfaces.
 - Use another action to return the output of the "action". (which is another action).
 - To just compile it, use
```bash
    bsc -u <package_name>.bsv
```
 - To translate the bsv file to verilog, use
 ```bash
    bsc -u -verilog -g <module_name> <package_name>.bsv
```

# BSV Cheat Sheet

## Basic Structure
- **Package**: Container for modules, interfaces, and types
  ```bsv
  package mypackage;
  // code here
  endpackage
  ```

- **Module**: Implementation of hardware functionality
  ```bsv
  module mkMyModule(MyInterface);
    // Implementation
  endmodule
  ```

- **Interface**: Defines the inputs/outputs of a module
  ```bsv
  interface MyInterface;
    method Action input(Bit#(32) value);
    method Bit#(32) output();
  endinterface
  ```

## Common Libraries
- **Prelude**: Basic types and functions
- **FIFO**: FIFO implementations
- **StmtFSM**: Finite State Machine creation
- **RegFile**: Register file implementations
- **Vector**: For working with arrays/vectors

## Register Creation
```bsv
// Create a 32-bit register initialized to 0
Reg#(Bit#(32)) myReg <- mkReg(0);

// Using it
myReg <= newValue;   // Update value
let x = myReg;       // Read value
```

## Method Types
- **Action**: Does something, returns nothing
  ```bsv
  method Action doSomething(Bit#(32) x);
  ```

- **ActionValue**: Does something and returns a value
  ```bsv
  method ActionValue#(Bit#(32)) getValue();
  ```

- **Value**: Returns a value without side effects
  ```bsv
  method Bit#(32) result();
  ```

## Rules
Rules define concurrent behavior and are automatically scheduled:
```bsv
rule myRule (condition);
  // Actions to perform
endrule
```

## Common Types
- `Bit#(n)`: n-bit value
- `Int#(n)`: n-bit signed integer
- `UInt#(n)`: n-bit unsigned integer
- `Bool`: Boolean value
- `Maybe#(t)`: Optional type (Valid, Invalid)

## Type Conversion
```bsv
pack(x)     // Convert structured data to Bit#(n)
unpack(x)   // Convert Bit#(n) to structured data
zeroExtend  // Extend with zeroes
signExtend  // Extend with sign bit
truncate    // Reduce bits
```

## Control Structures
```bsv
if (condition) begin
  // code
end else begin
  // code
end

case (value)
  option1: // code
  option2: // code
  default: // code
endcase
```

## Pattern Matching
```bsv
case (value) matches
  tagged Valid .x: // code that can use x
  tagged Invalid:  // code
endcase
```

## FSM Creation
```bsv
Stmt fsm = seq
  action1();
  action2();
  while (condition)
    action3();
endseq;

mkFSM(fsm);
```

## Important Concepts
- **Implicit Conditions**: Methods can have implicit conditions
- **Atomicity**: Rules and methods execute atomically
- **Conflict**: Two rules conflict if they access the same resource
- **Scheduling**: The compiler handles scheduling of rules

## What are libraries?

Libraries in BSV are packages that provide reusable functionality. Some key libraries:

- **Prelude**: Basic types, operators, and functions (always needed)
- **FIFO**: Different FIFO implementations (FIFO, FIFO1, FIFO2, etc.)
- **Vector**: Provides operations on fixed-size arrays
- **StmtFSM**: For creating state machines in an imperative style
- **ClientServer**: Interfaces for client-server relationships
- **GetPut**: Generic interfaces for producers and consumers
- **RegFile**: For creating memory arrays and register files
- **ConfigReg**: Registers with special scheduling properties


# BSV by Example Notes

## Fundamental Concepts

### BSV Philosophy
- BSV is a hardware description language focusing on behavior specification rather than structural description
- Based on guarded atomic actions (rules) that execute when their conditions are met
- Compiler handles rule scheduling, conflict resolution, and resource sharing

### BSV vs. Traditional HDLs
- BSV focuses on behavior, not structure (unlike Verilog/VHDL)
- Uses strongly typed functional language concepts
- Abstract interfaces allow module reuse and composition
- Rule-based concurrency model vs explicit clocking

## Type System

### Basic Types
```bsv
Bool        // Boolean values: True, False
Bit#(n)     // n-bit value
Int#(n)     // Signed integer with n bits
UInt#(n)    // Unsigned integer with n bits
```

### Type Variables and Polymorphism
```bsv
// A polymorphic function
function t max(t x, t y) provisos (Ord#(t));
   return x > y ? x : y;
endfunction
```

### Type Classes
```bsv
// Eq typeclass for equality comparison
typeclass Eq #(type t);
   function Bool \== (t x, t y);
   function Bool \/= (t x, t y);
endtypeclass
```

### Structured Types
```bsv
// Tuple example
Tuple2#(Bit#(8), Bit#(16)) myTuple = tuple2(8'h42, 16'h1234);
match {.x, .y} = myTuple;  // Destructuring

// Struct example
typedef struct {
   Bit#(8) opcode;
   Bit#(5) rs;
   Bit#(5) rt;
} Instruction deriving (Bits, Eq);

// Union/tagged union
typedef union tagged {
   void Invalid;
   t Valid;
} Maybe#(type t) deriving (Bits, Eq);
```

## Interfaces and Modules

### Interface Definition
```bsv
interface Counter#(type t);
   method Action increment();
   method Action decrement();
   method t read();
   method Action load(t newval);
endinterface
```

### Module Implementation
```bsv
module mkCounter(Counter#(Bit#(8)));
   Reg#(Bit#(8)) value <- mkReg(0);

   method Action increment();
      value <= value + 1;
   endmethod

   method Action decrement();
      value <= value - 1;
   endmethod

   method Bit#(8) read();
      return value;
   endmethod

   method Action load(Bit#(8) newval);
      value <= newval;
   endmethod
endmodule
```

### Parameterized Modules
```bsv
module mkParameterizedCounter#(Bit#(8) init_val)(Counter#(Bit#(8)));
   Reg#(Bit#(8)) value <- mkReg(init_val);
   // methods as before
endmodule
```

## Rules and Actions

### Rule Definition
```bsv
rule countUp (counter < 10);
   counter <= counter + 1;
   $display("Counter: %d", counter);
endrule
```

### Multiple Rules
```bsv
rule processEven (counter % 2 == 0);
   $display("Processing even: %d", counter);
endrule

rule processOdd (counter % 2 == 1);
   $display("Processing odd: %d", counter);
endrule
```

### Explicit Rule Scheduling
```bsv
(* descending_urgency = "rule1, rule2, rule3" *)
(* execution_order = "ruleA, ruleB" *)
```

## State Elements

### Register Types
```bsv
// Standard register
Reg#(Bit#(32)) r1 <- mkReg(0);

// Register with reset
Reg#(Bit#(32)) r2 <- mkRegU;  // Uninitialized
Reg#(Bit#(32)) r3 <- mkRegA(0);  // Asynchronous reset
```

### FIFOs
```bsv
// Basic FIFO
FIFO#(Bit#(32)) fifo <- mkFIFO;
fifo.enq(32'h1234);  // Add an element
let x = fifo.first();  // Read first element
fifo.deq();  // Remove first element

// Pipeline FIFO
FIFO#(Bit#(32)) pipelineFifo <- mkPipelineFIFO;

// SizedFIFO
FIFO#(Bit#(32)) sizedFifo <- mkSizedFIFO(16);  // 16 elements
```

### Register Files
```bsv
// 32 registers of 32 bits each
RegFile#(Bit#(5), Bit#(32)) regfile <- mkRegFileFull;
regfile.upd(5'h01, 32'h12345678);  // Write
let val = regfile.sub(5'h01);  // Read
```

## Interfaces and Connections

### Client-Server Pattern
```bsv
interface Client#(type req_t, type resp_t);
   method ActionValue#(req_t) request();
   method Action response(resp_t resp);
endinterface

interface Server#(type req_t, type resp_t);
   method Action request(req_t req);
   method ActionValue#(resp_t) response();
endinterface
```

### Get-Put Pattern
```bsv
interface Get#(type t);
   method ActionValue#(t) get();
endinterface

interface Put#(type t);
   method Action put(t val);
endinterface
```

## Advanced Features

### FSM in BSV
```bsv
// Using StmtFSM library
Stmt test_seq = seq
   // Initialize
   counter <= 0;
   // Loop through values
   while (counter < 10) seq
      action
         $display("Counter value: %0d", counter);
         counter <= counter + 1;
      endaction
   endseq
   // Done
   $display("FSM complete");
endseq;

FSM test_fsm <- mkFSM(test_seq);

rule start_fsm;
   test_fsm.start();
endrule
```

### Modules with Internal State Machines
```bsv
typedef enum {Idle, Running, Done} State deriving (Bits, Eq);

module mkProcessor(Empty);
   Reg#(State) state <- mkReg(Idle);
   Reg#(Bit#(32)) counter <- mkReg(0);

   rule idle_to_running (state == Idle);
      state <= Running;
      counter <= 0;
      $display("Starting processing");
   endrule

   rule running_count (state == Running && counter < 10);
      counter <= counter + 1;
      $display("Processing: %0d", counter);
   endrule

   rule running_done (state == Running && counter >= 10);
      state <= Done;
      $display("Processing complete");
   endrule

   rule done_to_idle (state == Done);
      state <= Idle;
      $display("Returning to idle");
   endrule
endmodule
```
