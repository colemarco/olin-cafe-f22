`default_nettype none
`timescale 1ns/1ps

module register_file(
  clk, //Note - intentionally does not have a reset! 
  wr_ena, wr_addr, wr_data,
  rd_addr0, rd_data0,
  rd_addr1, rd_data1
);
// Not parametrizing, these widths are defined by the RISC-V Spec!
input wire clk;

// Write channel
input wire wr_ena;
input wire [4:0] wr_addr;
input wire [31:0] wr_data;

// Two read channels
input wire [4:0] rd_addr0, rd_addr1;
output logic [31:0] rd_data0, rd_data1;

logic [31:0] x00; 
always_comb x00 = 32'd0; // ties x00 to ground. 

// DON'T DO THIS:
// logic [31:0] register_file_registers [31:0]
// CAN'T: because that's a RAM. Works in simulation, fails miserably in synthesis.

// Hint - use a scripting language if you get tired of copying and pasting the logic 32 times - e.g. python: print(",".join(["x%02d"%i for i in range(0,32)]))
wire [31:0] x01,x02,x03,x04,x05,x06,x07,x08,x09,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;

mux32 #(.N(32)) addressing1 (x00,x01,x02,x03,x04,x05,x06,x07,x08,x09,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31, rd_addr0, rd_data0);
mux32 #(.N(32)) addressing2 (x00,x01,x02,x03,x04,x05,x06,x07,x08,x09,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31, rd_addr1, rd_data1);

always_comb decoder = wr_ena ? (32'b1 << wr_addr) : 32'b0;

always_ff @(posedge clk) begin
  x00 = decoder[0] ? wr_data:x00;
  x01 = decoder[1] ? wr_data:x01;
  x02 = decoder[2] ? wr_data:x02;
  x03 = decoder[3] ? wr_data:x03;
  x04 = decoder[4] ? wr_data:x04;
  x05 = decoder[5] ? wr_data:x05;
  x06 = decoder[6] ? wr_data:x06;
  x07 = decoder[7] ? wr_data:x07;
  x08 = decoder[8] ? wr_data:x08;
  x09 = decoder[9] ? wr_data:x09;
  x10 = decoder[10] ? wr_data:x10;
  x11 = decoder[11] ? wr_data:x11;
  x12 = decoder[12] ? wr_data:x12;
  x13 = decoder[13] ? wr_data:x13;
  x14 = decoder[14] ? wr_data:x14;
  x15 = decoder[15] ? wr_data:x15;
  x16 = decoder[16] ? wr_data:x16;
  x17 = decoder[17] ? wr_data:x17;
  x18 = decoder[18] ? wr_data:x18;
  x19 = decoder[19] ? wr_data:x19;
  x20 = decoder[20] ? wr_data:x20;
  x21 = decoder[21] ? wr_data:x21;
  x22 = decoder[22] ? wr_data:x22;
  x23 = decoder[23] ? wr_data:x23;
  x24 = decoder[24] ? wr_data:x24;
  x25 = decoder[25] ? wr_data:x25;
  x26 = decoder[26] ? wr_data:x26;
  x27 = decoder[27] ? wr_data:x27;
  x28 = decoder[28] ? wr_data:x28;
  x29 = decoder[29] ? wr_data:x29;
  x30 = decoder[30] ? wr_data:x30;
  x31 = decoder[31] ? wr_data:x31;
end

endmodule