module mkMultipleRile();
  Reg#(Bit#(8)) count <- mkReg(0);

  // Rule 1: increments count if it's even 
  rule incIfEven (count % 2 == 0);
    count <= count + 1;
    $display("[incIfEven] count => %d", count);
  endrule 
  
  // Rule 2: increments if it's odd and less than 20 
  rule incIfOdd (count % 2 == 1 && count < 20);
    count <= count + 1;
    $display("[incIfOdd] count => %d", count);
    if (count == 19) $finish;
  endrule 
endmodule
