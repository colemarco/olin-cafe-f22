`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_left;
parameter N = 32;
   logic [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
     logic [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
     wire [N-1:0] out;

 shift_left_logical #(.N(N)) SHIFTER_1 (.in(in), .shamt(shamt), .out(out));

  initial begin // In standard programming land (line by line execution)
    // Collect waveforms
    $dumpvars(0, SHIFTER_1);
    
    $display("in shamt | out");
    in = 32'b00001000100010001000100010001000;
    shamt = 5'd31;
    #1 $display("%1b %2b | %3b", in, shamt, out);

        
    $finish;      
	end

endmodule