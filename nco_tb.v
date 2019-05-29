`include "nco.v"
`timescale 1ns / 1ps

module nco_tb;

reg clk = 0, rst = 0;
reg [7:0] phase = 0;
reg [5:0] freq_res;
wire [7:0] out;

nco nco_inst
	(
	.clk(clk),
	.rst(rst),
	.phase(phase),
	.freq_res(freq_res),
	.out(out)
	);

always
	#2 clk <= ~clk;

initial
	begin
		$dumpfile("out.vcd");
		$dumpvars(0, nco_tb);
		//$monitor("time =%4d   out=%h",$time,out);
		rst = 1'b1;
		freq_res = 1;
		#8
		rst = 1'b0;
		#300
		phase = 8'b00100011;
		#300
		phase = 8'b00001111;
		#1200
		freq_res = 6'b111101;
		#1200
		freq_res = 6'b001111;
		#1200
		freq_res = 6'b011111;
		#400
		phase = 8'b00010011;
		#1200
		$finish;
	end

endmodule