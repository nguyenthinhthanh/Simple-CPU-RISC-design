`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 08:39:53 AM
// Design Name: 
// Module Name: hazard_detection_unit
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
// Module: Data hazard dectection unit
// Function: Detect data hazard.
// =============================================================
module hazard_detection_unit(
    input wire [2:0] prev_opcode,
    input wire [2:0] curr_opcode,
    output wire stall
    );
    assign stall = (prev_opcode == 3'b101) &&	// LDA
                   ((curr_opcode == 3'b010) || 	// ADD
                    (curr_opcode == 3'b011) || 	// AND
                    (curr_opcode == 3'b100));  	// XOR
endmodule
