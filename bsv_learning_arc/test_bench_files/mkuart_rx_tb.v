// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb_mkuart_rx();
  // Signals
  reg CLK, RST_N;
  reg recieve_rx, EN_recieve, EN_get;
  wire [7:0] get;
  wire RDY_recieve, RDY_get;
  
  // For timing chart visibility
  reg [7:0] expected_byte;
  reg [7:0] received_byte;
  
  // DUT
  mkuart_rx dut(
    .CLK(CLK), .RST_N(RST_N),
    .recieve_rx(recieve_rx), .EN_recieve(EN_recieve), .RDY_recieve(RDY_recieve),
    .EN_get(EN_get), .get(get), .RDY_get(RDY_get)
  );
  
  // Clock generation
  always #5 CLK = ~CLK;
  
  // Store received byte when reading
  always @(posedge CLK)
    if (EN_get && RDY_get)
      received_byte <= get;
  
  initial begin
    // Initialize signals
    CLK = 0;
    RST_N = 0;
    recieve_rx = 0;
    EN_recieve = 0;
    EN_get = 0;
    expected_byte = 8'hA5; // 10100101
    received_byte = 8'h00;
    
    // Dump waveforms
    $dumpfile("uart_rx_waves.vcd");
    $dumpvars(0, tb_mkuart_rx);
    
    // Reset
    #20 RST_N = 1;
    #10;
    
    // Send byte (LSB first)
    $display("Sending byte: 0x%h", expected_byte);
    
    // Bit 0 (LSB)
    #10 recieve_rx = expected_byte[0]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 1
    #10 recieve_rx = expected_byte[1]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 2
    #10 recieve_rx = expected_byte[2]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 3
    #10 recieve_rx = expected_byte[3]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 4
    #10 recieve_rx = expected_byte[4]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 5
    #10 recieve_rx = expected_byte[5]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 6
    #10 recieve_rx = expected_byte[6]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Bit 7 (MSB)
    #10 recieve_rx = expected_byte[7]; EN_recieve = 1;
    #10 EN_recieve = 0;
    
    // Wait for data to be ready
    #20;
    
    // Read received byte
    if (RDY_get) begin
      EN_get = 1;
      #10 EN_get = 0;
      #10; // Allow time for received_byte to update
      
      // Check if received correctly
      if (received_byte == expected_byte)
        $display("SUCCESS: Received 0x%h as expected", received_byte);
      else
        $display("ERROR: Expected 0x%h but got 0x%h", expected_byte, received_byte);
    end else begin
      $display("ERROR: Data not ready to be read!");
    end
    
    // Run a bit longer to see final state
    #50;
    $finish;
  end
endmodule

