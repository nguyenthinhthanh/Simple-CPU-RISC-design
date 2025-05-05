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
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = 8'b0;
        end
        
    // opcode_operand  // addr  assembly code
    //@00   101_01100      // 00  LDA NORM1       ; AC = 0x0A
    //      010_01101      // 01  ADD NORM2       ; AC = 0x0A + 0x05 = 0x0F
    //      110_01110      // 02  STO NORM_RES    ; NORM_RES = 0x0F
    
    //      101_01111      // 03  LDA OV1         ; AC = 0xFF
    //      010_10000      // 04  ADD OV2         ; AC = 0xFF + 0x02 = 0x01 (overflow)
    //      110_10001      // 05  STO OV_RES      ; OV_RES = 0x01
    
    //      101_10010      // 06  LDA HZ1         ; AC = 0x05
    //      010_10011      // 07  ADD HZ2         ; AC = 0x05 + 0x03 = 0x08
    //      110_10100      // 08  STO HZ_RES      ; HZ_RES = 0x08
    
    //      010_10100      // 09  ADD HZ_RES      ; AC = 0x08 + 0x08 = 0x10 (data hazard)
    //      110_10101      // 0A  STO HZ2X       ; HZ2X = 0x10
    
    //      000_00000      // 0B  HLT             ; d?ng ch??ng trình

// Data section (??a ch? 0-31)
    //@12   00001010      // 12  NORM1:   0x0A
    //      00000101      // 13  NORM2:   0x05
    //      00000000      // 14  NORM_RES:init=0x00
    //      11111111      // 15  OV1:     0xFF
    //      00000010      // 16  OV2:     0x02
    //      00000000      // 17  OV_RES:init=0x00
    //      00000101      // 18  HZ1:     0x05
    //      00000011      // 19  HZ2:     0x03
    //      00000000      // 20  HZ_RES:init=0x00
    //      00000000      // 21  HZ2X:init=0x00  
    
        
        // Memory test case
        mem[0] = 8'b101_01100;              
        mem[1] = 8'b010_01101;              
        mem[2] = 8'b110_01110;              
        mem[3] = 8'b101_01111;              
        mem[4] = 8'b010_10000;              
        mem[5] = 8'b110_10001;              
        mem[6] = 8'b101_10010;              
        mem[7] = 8'b010_10011;              
        mem[8] = 8'b110_10100;              
        mem[9] = 8'b010_10100;              
        mem[10] = 8'b110_10101;             
        mem[11] = 8'b000_00000; 
        
        // Data            
        mem[12] = 8'b00001010;             
        mem[13] = 8'b00000101;             
        mem[14] = 8'b00000000;             
        mem[15] = 8'b11111111;             
        mem[16] = 8'b00000010;             
        mem[17] = 8'b00000000;             
        mem[18] = 8'b00000101;             
        mem[19] = 8'b000_00011;             
        mem[20] = 8'b00000000;             
        mem[21] = 8'b00000000;                       
        
    end

    always @(posedge clk) begin
        if (wr)
            mem[addr] <= data_in;
        else if (rd)
            data_out <= mem[addr];
    end
endmodule