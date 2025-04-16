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
        
    //opcode_operand    // addr  assembly code
    //--------------    // ----  -----------------------------------------------
    //@00 111_11110    //  00   BEGIN:   JMP TST_JMP
    //    000_00000     //  01            HLT        
    //    000_00000     //  02            HLT       
    //    101_11010     //  03   JMP_OK:  LDA DATA_1
    //    001_00000     //  04            SKZ
    //    000_00000     //  05            HLT        
    //    101_11011     //  06            LDA DATA_2
    //    001_00000     //  07            SKZ
    //    111_01010     //  08            JMP SKZ_OK
    //    000_00000     //  09            HLT        
    //    110_11100     //  0A   SKZ_OK:  STO TEMP   
    //    101_11010     //  0B            LDA DATA_1
    //    110_11100     //  0C            STO TEMP   
    //    101_11100     //  0D            LDA TEMP
    //    001_00000     //  0E            SKZ        
    //    000_00000     //  0F            HLT        
    //    100_11011     //  10            XOR DATA_2
    //    001_00000     //  11            SKZ        
    //    111_10100     //  12            JMP XOR_OK
    //    000_00000     //  13            HLT        
    //    100_11011     //  14   XOR_OK:  XOR DATA_2
    //    001_00000     //  15            SKZ
    //    000_00000     //  16            HLT        
    //    000_00000     //  17   END:     HLT        
    //    111_00000     //  18            JMP BEGIN  
    
    //@1A 00000000      //  1A   DATA_1:             (constraint 0x00)
    //    11111111      //  1B   DATA_2:             (constraint 0xFF)
    //    10101010      //  1C   TEMP:               (Variable 0xAA)
    
    //@1E 111_00011     //  1E   TST_JMP: JMP JMP_OK
    //    000_00000     //  1F            HLT  
    
        
        // Memory test case
        mem[0] = 8'b111_11110;              // JMP 30
        mem[1] = 8'b000_00000;              // HALT
        mem[2] = 8'b000_00000;              // HALT
        mem[3] = 8'b101_11010;              // LDA 26
        mem[4] = 8'b001_00000;              // SKZ
        mem[5] = 8'b000_00000;              // HALT
        mem[6] = 8'b101_11011;              // LDA 27
        mem[7] = 8'b001_00000;              // SKZ
        mem[8] = 8'b111_01010;              // JUMP 10
        mem[9] = 8'b000_00000;              // HALT
        
        mem[10] = 8'b110_11100;             // STO 28
        mem[11] = 8'b101_11010;             // LDA 26
        mem[12] = 8'b110_11100;             // STO 28
        mem[13] = 8'b101_11100;             // LDA 28
        mem[14] = 8'b001_00000;             // SKZ
        mem[15] = 8'b000_00000;             // HALT
        mem[16] = 8'b100_11011;             // XOR 27
        mem[17] = 8'b001_00000;             // SKZ
        mem[18] = 8'b111_10100;             // JMP 20
        mem[19] = 8'b000_00000;             // HALT
        
        mem[20] = 8'b100_11011;             // XOR 27
        mem[21] = 8'b001_00000;             // SKZ
        mem[22] = 8'b000_00000;             // HALT
        mem[23] = 8'b000_00000;             // HALT : We end here
        mem[24] = 8'b111_00000;             // JMP 0
        
        mem[26] = 8'b00000000;              // DATA 0x00
        mem[27] = 8'b11111111;              // DATA 0xFF
        mem[28] = 8'b10101010;              // 0xAA
        
        mem[30] = 8'b111_00011;             // JUMP 3
        mem[31] = 8'b000_00000;             // HALT
        
    end

    always @(posedge clk) begin
        if (wr)
            mem[addr] <= data_in;
        else if (rd)
            data_out <= mem[addr];
    end
endmodule