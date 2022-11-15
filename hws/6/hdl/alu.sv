`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.

// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t.

logic carry_out, sub_out;
logic [N-1:0] sum, difference, sll, srl, sra;
logic slt, sltu, msb_eq, a_sum_msb_eq, a_diff_msb_eq;

  // addition
  adder_n #(.N(N)) adder (
    .a(a), .b(b), .c_in(1'b0), .sum(sum), .c_out(carry_out)
  );
  // subtraction
  adder_n #(.N(N)) subtract (
    .a(a), .b(~b), .c_in(1'b1), .sum(difference), .c_out(sub_out)
  );
  // sll
  shift_left_logical #(.N(N)) shift_left (
    .in(a), .shamt(5'b00001), .out(sll)
  );
  //srl
  shift_right_logical #(.N(N)) shift_right (
    .in(a), .shamt(5'b00001), .out(srl)
  );
  //sra
  shift_right_arithmetic #(.N(N)) shift_right_arithmetic (
    .in(a), .shamt(5'b00001), .out(sra)
  );
  //slt
  slt #(.N(N)) less_than (
    .a(a), .b(b), .out(slt)
  );
  //sltu
  slt #(.N(N)) less_than_unsigned (
    .a(a), .b(b), .out(sltu)
  );
  //equality
  comparator_eq #(.N(N)) equality (
    .a(a), .b(b), .out(equal)
  );
  //zero
  comparator_eq #(.N(N)) zero_equality (
    .a(a), .b({{N{1'b0}}}), .out(zero)
  );

  mux16 #(.N(N)) alu_control (
    .in00({{N{1'b0}}}),
    .in01(a & b),
    .in02(a | b),
    .in03(a ^ b),
    .in04(sll),
    .in05(srl),
    .in06(sra),
    .in07(sum),
    .in08(difference),
    .in09(slt),
    .in10(sltu),
    .in11({{N{1'b0}}}),
    .in12({{N{1'b0}}}),
    .in13({{N{1'b0}}}),
    .in14({{N{1'b0}}}),
    .in15({{N{1'b0}}}),
    .select(control),
    .out(result)
  );

  comparator_eq #(.N(1)) msb_equal (
    .a(a[N-1]), .b(b[N-1]), .out(msb_eq)
  );
  comparator_eq #(.N(1)) msb_sum_equal (
    .a(a[N-1]), .b(sum[N-1]), .out(a_sum_msb_eq)
  );
  comparator_eq #(.N(1)) msb_diff_equal (
    .a(a[N-1]), .b(difference[N-1]), .out(a_diff_msb_eq)
  );

  mux16 #(.N(1)) mux_overflow (
    .in00(1'b0),
    .in01(1'b0),
    .in02(1'b0),
    .in03(1'b0),
    .in04(1'b0),
    .in05(1'b0),
    .in06(msb_eq & a_sum_msb_eq),
    .in07(~msb_eq & a_diff_msb_eq),
    .in08(~msb_eq & a_diff_msb_eq),
    .in09(~msb_eq & a_diff_msb_eq),
    .in10(1'b0),
    .in11(1'b0),
    .in12(1'b0),
    .in13(1'b0),
    .in14(1'b0),
    .in15(1'b0),
    .select(control),
    .out(overflow)
  );

endmodule