`timescale 1ns/1ps
`default_nettype none
module comparator_eq(a, b, out);

parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Using only *structural* combinational logic, make a module that computes if a == b. 
always_comb begin
    out = &(a ~^ b);
end

// Copy any other modules you use into the HDL folder and update the Makefile accordingly.
endmodule
