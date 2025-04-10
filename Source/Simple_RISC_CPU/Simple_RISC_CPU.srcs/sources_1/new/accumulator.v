`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 05:06:01 PM
// Design Name: 
// Module Name: accumulator
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
// Module: Accumulator Register
// Function: Stores intermediate math and ALU results.
// Characteristics: Register synchronizes with clk and reset signals.
// Data: 8-bit
// =============================================================
module accumulator(
    input wire clk,
    input wire reset,
    input wire load,            
    input wire [7:0] data_in,
    output reg [7:0] acc_out    
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            acc_out <= 8'b0;
        else if (load)
            acc_out <= data_in;
    end
endmodule
