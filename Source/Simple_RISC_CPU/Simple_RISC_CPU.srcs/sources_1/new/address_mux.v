`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 04:53:24 PM
// Design Name: 
// Module Name: address_mux
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
// Module: Address Mux
// Function: Choose between address from PC (fetch command) or
// address taken from the operand field in instruction (for jump commands, LDA, STO,...)
// Control: "sel" signal from the Controller.
// Width: default 5-bit (can be parameterized)
// =============================================================
module address_mux #(
    parameter WIDTH = 5
)(
    input wire [WIDTH-1:0] pc_addr,      
    input wire [WIDTH-1:0] instr_addr,   
    input wire sel,                    
    output wire [WIDTH-1:0] addr_out     
);
    assign addr_out = sel ? instr_addr : pc_addr;
endmodule
