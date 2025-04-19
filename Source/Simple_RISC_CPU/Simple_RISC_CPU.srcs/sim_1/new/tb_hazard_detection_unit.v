`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 08:53:05 AM
// Design Name: 
// Module Name: tb_hazard_detection_unit
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


module tb_hazard_detection_unit;

    // Tín hieu dau vào
    reg [2:0] prev_opcode;
    reg [2:0] curr_opcode;

    // Tín hieu dau ra
    wire stall;

    // Module hazard detection
    hazard_detection_unit uut (
        .prev_opcode(prev_opcode),
        .curr_opcode(curr_opcode),
        .stall(stall)
    );

    initial begin
        // In tiêu de
        prev_opcode = 3'b000;   // NOP
        curr_opcode = 3'b010;   // ADD
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, prev_opcode, curr_opcode, stall);

        // Test 2: Co hazard (LDA -> ADD)
        prev_opcode = 3'b101;   // LDA
        curr_opcode = 3'b010;   // ADD
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, prev_opcode, curr_opcode, stall);

        // Test 3: Co hazard (LDA -> XOR)
        prev_opcode = 3'b101;   // LDA
        curr_opcode = 3'b100;   // XOR
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, prev_opcode, curr_opcode, stall);

        // Test 4: Khong co hazard (LDA -> JMP)
        prev_opcode = 3'b101;   // LDA
        curr_opcode = 3'b001;   // JMP
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, prev_opcode, curr_opcode, stall);

        // Test 5: Khong co hazard (NOP -> NOP)
        prev_opcode = 3'b000;   // NOP
        curr_opcode = 3'b000;   // NOP
        #10;
        $display("%0dns\t%b\t%b\t%b", $time, prev_opcode, curr_opcode, stall);

        $finish;
    end

endmodule

