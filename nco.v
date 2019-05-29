module nco(
	clk,
	rst,
	phase,		//Начальная фаза
	freq_res,	//Частота сигнала (инкремент фазового аккумулятора)
	out
	);

input clk, rst;
input [5:0] freq_res;
input [7:0] phase;
reg [7:0] prev_phase = 0;
reg change_phase = 0;
output reg [7:0] out;

reg [5:0] phase_inc = 6'h1;
reg [7:0] phase_acc = 0;

parameter LUT_SIZE = 64;
reg [6:0] lut [0:LUT_SIZE-1];

always @(posedge clk) begin
	if (rst) begin
		prev_phase = 0;
		phase_inc = 6'h1;
		phase_acc = 0;
		change_phase = 0;
		out = 0;
		lut[0] = 7'h00;
		lut[1] = 7'h03;
		lut[2] = 7'h06;
		lut[3] = 7'h09;
		lut[4] = 7'h0C;
		lut[5] = 7'h0F;
		lut[6] = 7'h12;
		lut[7] = 7'h16;
		lut[8] = 7'h19;
		lut[9] = 7'h1C;
		lut[10] = 7'h1F;
		lut[11] = 7'h22;
		lut[12] = 7'h25;
		lut[13] = 7'h28;
		lut[14] = 7'h2B;
		lut[15] = 7'h2E;
		lut[16] = 7'h31;
		lut[17] = 7'h34;
		lut[18] = 7'h37;
		lut[19] = 7'h39;
		lut[20] = 7'h3C;
		lut[21] = 7'h3F;
		lut[22] = 7'h42;
		lut[23] = 7'h44;
		lut[24] = 7'h47;
		lut[25] = 7'h4A;
		lut[26] = 7'h4C;
		lut[27] = 7'h4F;
		lut[28] = 7'h51;
		lut[29] = 7'h54;
		lut[30] = 7'h56;
		lut[31] = 7'h58;
		lut[32] = 7'h5A;
		lut[33] = 7'h5D;
		lut[34] = 7'h5F;
		lut[35] = 7'h61;
		lut[36] = 7'h63;
		lut[37] = 7'h65;
		lut[38] = 7'h67;
		lut[39] = 7'h68;
		lut[40] = 7'h6A;
		lut[41] = 7'h6C;
		lut[42] = 7'h6D;
		lut[43] = 7'h6F;
		lut[44] = 7'h71;
		lut[45] = 7'h72;
		lut[46] = 7'h73;
		lut[47] = 7'h75;
		lut[48] = 7'h76;
		lut[49] = 7'h77;
		lut[50] = 7'h78;
		lut[51] = 7'h79;
		lut[52] = 7'h7A;
		lut[53] = 7'h7B;
		lut[54] = 7'h7B;
		lut[55] = 7'h7C;
		lut[56] = 7'h7D;
		lut[57] = 7'h7D;
		lut[58] = 7'h7E;
		lut[59] = 7'h7E;
		lut[60] = 7'h7E;
		lut[61] = 7'h7E;
		lut[62] = 7'h7E;
		lut[63] = 7'h7F;
	end
	else begin
		// Forming sin with 1 clk latency
		if (phase_acc[7:6] == 2'b00) begin
			out = {1'b1,lut[phase_acc[5:0]]};
		end
		if (phase_acc[7:6] == 2'b01) begin
			out = {1'b1,lut[~phase_acc[5:0]]};
		end
		if (phase_acc[7:6] == 2'b10) begin
			out = {1'b0,~lut[phase_acc[5:0]]};
		end
		if (phase_acc[7:6] == 2'b11) begin
			out = {1'b0,~lut[~phase_acc[5:0]]};
		end
		phase_inc = freq_res;
		// Changing phase event with 3 clk latency 
		prev_phase <= phase;
		if (phase != prev_phase) begin
			change_phase <= 1'b1;
		end
		if (change_phase) begin
			phase_acc <= prev_phase;
			change_phase <= 1'b0;
		end
		else begin
			phase_acc = phase_acc + {2'b0,phase_inc};
		end
	end
end

endmodule