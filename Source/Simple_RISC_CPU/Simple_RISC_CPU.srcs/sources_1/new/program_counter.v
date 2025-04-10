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
// Function: Stores the current address of the program.
// It has the ability to reset, load new values (for jumping) and increment (increment).
// Width: 5-bit
// =============================================================
module program_counter (
    input wire clk,                 // Clock 
    input wire reset,               // Reset signal
    input wire load,               	
	input wire inc,               	
    input wire [4:0] data_in,      	
    output reg [4:0] pc_out        	
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 5'd0;
        else if (load)
            pc_out <= data_in;
        else if (inc)
            pc_out <= pc_out + 1;
    end
endmodule
