`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 10:57:15 AM
// Design Name: 
// Module Name: program_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// =============================================================
// Module: Program Counter (PC)
// Ch?c n?ng: L?u tr? ??a ch? hi?n hành c?a ch??ng trình. 
// Có kh? n?ng reset, load giá tr? m?i (cho jump) và t? t?ng khi hoàn thành câu l?nh (increment).
// ?? r?ng: 5-bit
// =============================================================
module program_counter (
    input wire clk,                 // Clock 
    input wire reset,               // Tín hi?u reset
    input wire load,               	// Khi load = 1, PC s? nh?n giá tr? data_in
	input wire inc,               	// Cho b??c INST_ADDR
    input wire [4:0] data_in,      	// D? li?u n?p vào, ??a ch? t? instruction
    output reg [4:0] pc_out        	// Giá tr? hi?n t?i c?a PC
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 5'd0;
        else if (load)
            pc_out <= data_in;
        else if (inc)
            pc_out <= pc_out + 1;
        // else gi? nguyên (n?u không làm gì)
    end
endmodule
