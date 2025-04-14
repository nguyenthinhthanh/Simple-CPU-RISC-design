`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 04:57:33 PM
// Design Name: 
// Module Name: memory
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
// Module: Memory
// Function: Store programs (commands) and data.
// Number of memory cells: 32 (5-bit address)
// Data Per Cell: 8-bit
// There are control signals: rd (read), wr (write)
// WARNING: Reading and writing are not allowed at the same time.
// =============================================================
module memory (
    input wire clk,
    input wire [4:0] addr,       
    input wire [7:0] data_in,    
    input wire rd,             
    input wire wr,             
    output reg [7:0] data_out  
);
    reg [7:0] mem [0:31];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1)
            mem[i] = 8'b0;
        //  LDA 12: opcode 101, operand = 12  => 8'b10101100
        //mem[0] = 8'b10101100;
        // Memory write
        //mem[12] = 8'b00000011;
        //  ADD 13: opcode 010, operand = 13  => 8'b01001101
        //mem[0] = 8'b01001101;
//        //  JMP 5:  opcode 111, operand = 5   => 8'b11100101
//        mem[2] = 8'b11100101;
        //HLT:    opcode 000, operand = don't care => 8'b00000000
        mem[0] = 8'b00000000;
    end

    always @(posedge clk) begin
        if (wr)
            mem[addr] <= data_in;
        else if (rd)
            data_out <= mem[addr];
    end
endmodule