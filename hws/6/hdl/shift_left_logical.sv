`timescale 1ns/1ps
`default_nettype none

module shift_left_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;       

mux32 #(.N(N)) mux (
    .in00({in[N-1:0], {0{1'b0}}}),
    .in01({in[N-1:1], {1{1'b0}}}),
    .in02({in[N-1:2], {2{1'b0}}}),
    .in03({in[N-1:3], {3{1'b0}}}),
    .in04({in[N-1:4], {4{1'b0}}}),
    .in05({in[N-1:5], {5{1'b0}}}),
    .in06({in[N-1:6], {6{1'b0}}}),
    .in07({in[N-1:7], {7{1'b0}}}),
    .in08({in[N-1:8], {8{1'b0}}}),
    .in09({in[N-1:9], {9{1'b0}}}),
    .in10({in[N-1:10], {10{1'b0}}}),
    .in11({in[N-1:11], {11{1'b0}}}),
    .in12({in[N-1:12], {12{1'b0}}}),
    .in13({in[N-1:13], {13{1'b0}}}),
    .in14({in[N-1:14], {14{1'b0}}}),
    .in15({in[N-1:15], {15{1'b0}}}),
    .in16({in[N-1:16], {16{1'b0}}}),
    .in17({in[N-1:17], {17{1'b0}}}),
    .in18({in[N-1:18], {18{1'b0}}}),
    .in19({in[N-1:19], {19{1'b0}}}),
    .in20({in[N-1:20], {20{1'b0}}}),
    .in21({in[N-1:21], {21{1'b0}}}),
    .in22({in[N-1:22], {22{1'b0}}}),
    .in23({in[N-1:23], {23{1'b0}}}),
    .in24({in[N-1:24], {24{1'b0}}}),
    .in25({in[N-1:25], {25{1'b0}}}),
    .in26({in[N-1:26], {26{1'b0}}}),
    .in27({in[N-1:27], {27{1'b0}}}),
    .in28({in[N-1:28], {28{1'b0}}}),
    .in29({in[N-1:29], {29{1'b0}}}),
    .in30({in[N-1:30], {30{1'b0}}}),
    .in31({in[N-1:31], {31{1'b0}}}),
    .select(shamt),
    .out(out)
);

endmodule
