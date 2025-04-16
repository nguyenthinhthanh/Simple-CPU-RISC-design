`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 05:10:56 PM
// Design Name: 
// Module Name: controller
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
// Module: Controller
// Function: Control the entire CPU operation through an FSM.
// Inputs:
// - opcode: from the Instruction Register (3-bit)
// - is_zero: signal from ALU (for SKZ processing)
// Output: Control signals for other modules.
// - sel: for Address Mux (0: select PC; 1: select operand from IR)
// - rd: Triggers Memory reading
// - wr: Trigger Memory Write
// - ld_ir: load Instruction Register
// - inc_pc: increase PC (fetch command)
// - ld_pc: load the new value to the PC (for JMP commands)
// - ld_ac: load Accumulator (receive results from ALU)
// - halt: stops CPU when HLT command is encountered
// =============================================================
module controller(
    input wire clk,
    input wire reset,
    input wire [2:0] opcode,
    input wire is_zero,
    output reg sel,      // Address Mux
    output reg rd,       // Memory read
    output reg wr,       // Memory write
    output reg ld_ir,    // Load Instruction Register
    output reg inc_pc,   // Increment PC
    output reg ld_pc,    // Load PC (cho JMP)
    output reg ld_ac,    // Load Accumulator
    output reg data_e,   
    output reg halt      
);
    reg [2:0] state, next_state;

    // FSM Status Definition (8 Statuses)
    localparam INST_ADDR  = 3'd0;  // Get an address from a PC
    localparam INST_FETCH = 3'd1; // Read commands from Memory
    localparam INST_LOAD  = 3'd2;  // Load commands into IR
    localparam IDLE       = 3'd3; // Decipher commands and decide to operate
    localparam OP_ADDR    = 3'd4;  
    localparam OP_FETCH   = 3'd5; // Read the Memory term (for LDA, ADD, AND, XOR,...)
    localparam ALU_OP     = 3'd6; // Perform the ALU and load the results into ACC
    localparam STORE      = 3'd7; // Write data from ACC to Memory (for STO)

    // FSM: status updates
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Default off
            sel <= 0;
            rd <= 0;
            ld_ir <= 0;
            halt <= 0;
            inc_pc <= 0;
            ld_ac <= 0;
            ld_pc <= 0;
            wr <= 0; 
            data_e <= 0;
        
            state <= INST_ADDR;
        end
        else
            state <= next_state;
    end

    // FSM: state transfer logic
    always @(*) begin
        case (state)
            INST_ADDR:  next_state = INST_FETCH;
            INST_FETCH: next_state = INST_LOAD;
            INST_LOAD:  next_state = IDLE;
            IDLE: next_state = OP_ADDR;
            OP_ADDR: begin
                if (opcode == 3'b000)                   // HLT
                    next_state = state;
                else begin  
                    next_state = OP_FETCH;
                end
            end
            OP_FETCH:   next_state = ALU_OP;
            ALU_OP: begin
                if (opcode == 3'b001 && is_zero)   // SKZ & zero
                    next_state = INST_ADDR;
                else begin
                    next_state = STORE;
                end
            end
            STORE:      next_state = INST_ADDR;
            default:    next_state = INST_ADDR;
        endcase
    end
    
    // Control signal generation
    always @(*) begin
        // Default off
        sel = 0;
        rd = 0;
        ld_ir = 0;
        halt = 0;
        inc_pc = 0;
        ld_ac = 0;
        ld_pc = 0;
        wr = 0; 
        data_e = 0;

        case (state)
            INST_ADDR: begin
                sel = 1;
            end
            INST_FETCH: begin
                sel = 1;
                rd = 1;
            end
            INST_LOAD: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end
            IDLE: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end
            OP_ADDR: begin
                if (opcode == 3'b000)                       // HLT
                    halt = 1;
                else begin
                    inc_pc = 1;
                end
            end
            OP_FETCH: begin
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) // ADD, AND, XOR, LDA
                    rd = 1;
            end
            ALU_OP: begin
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) // ADD, AND, XOR, LDA
                    rd = 1;
                else if(opcode == 3'b001 && is_zero)        // SKZ
                    inc_pc = 1;
                else if (opcode == 3'b111)                  // JMP
                    ld_pc = 1;
                else if (opcode == 3'b110)                  // STO
                    data_e = 1;
            end
            STORE: begin
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin// ADD, AND, XOR, LDA
                    rd = 1;
                    ld_ac = 1;
                end
                else if (opcode == 3'b111)                  // JMP
                    ld_pc = 1;
                else if (opcode == 3'b110) begin            // STO
                    data_e = 1;
                    wr = 1;
                end
            end
        endcase
    end

endmodule