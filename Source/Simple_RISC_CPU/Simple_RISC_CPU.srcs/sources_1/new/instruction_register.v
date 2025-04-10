`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 05:04:17 PM
// Design Name: 
// Module Name: instruction_register
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
// Module: Instruction Register (IR)
// Function: Stores commands that have just been loaded from Memory.
// Characteristics: Register synchronizes with clk and reset signals.
// =============================================================
module instruction_register(
    input wire clk,
    input wire reset,
    input wire load,             
    input wire [7:0] data_in,
    output reg [7:0] instr_out   
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            instr_out <= 8'b0;
        else if (load)
            instr_out <= data_in;
    end
endmodule
