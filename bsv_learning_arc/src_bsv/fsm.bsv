// File: SimpleFSM.bsv 

typedef enum {S0, S1, S2, S3} State deriving (Bits, Eq);

module mkSimpleFSM();
  Reg#(State) currentState <- mkReg(S0);

  rule stepS0 (currentState == S0);
    $display("In S0, going to S1");
    currentState <= S1;
  endrule

  rule stepS1 (currentState == S1);
    $display("In S1, going to S2");
    currentState <= S2;
  endrule

  rule stepS2 (currentState == S2);
    $display("In S2, going to S3");
    currentState <= S3;
  endrule 

  rule stepS3 (currentState == S3);
    $display("In S3, done");
    $finish;
  endrule 
endmodule
