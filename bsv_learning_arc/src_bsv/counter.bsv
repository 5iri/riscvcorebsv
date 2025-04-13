
module mkSimpleCounter();
  Reg#(Bit#(8)) count <- mkReg(0);

  rule incrementRule;
    count <= count + 1;
    $display("Counter = %d", count);
    if (count == 10) $finish;
  endrule
endmodule
