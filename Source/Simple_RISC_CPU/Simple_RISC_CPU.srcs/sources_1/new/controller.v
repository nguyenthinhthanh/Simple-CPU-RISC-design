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
    output reg halt      
);
    reg [2:0] state, next_state;

    // FSM Status Definition (8 Statuses)
    localparam INST_ADDR = 3'd0;  // Get an address from a PC
    localparam INST_FETCH = 3'd1; // Read commands from Memory
    localparam INST_LOAD = 3'd2;  // Load commands into IR
    localparam IDLE       = 3'd3; // Decipher commands and decide to operate
    localparam OP_FETCH   = 3'd4; // Read the Memory term (for LDA, ADD, AND, XOR,...)
    localparam ALU_OP     = 3'd5; // Perform the ALU and load the results into ACC
    localparam STORE      = 3'd6; // Write data from ACC to Memory (for STO)
    localparam JMP_OP     = 3'd7; // Jump Execution (JMP)

    // FSM: status updates
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= INST_ADDR;
        else
            state <= next_state;
    end

    // FSM: state transfer logic and control signal generation
    always @(*) begin
        // Initialize default control signals: all = 0
        sel     = 0;
        rd      = 0;
        wr      = 0;
        ld_ir   = 0;
        inc_pc  = 0;
        ld_pc   = 0;
        ld_ac   = 0;
        halt    = 0;
        next_state = state;  // Defaults to keep current state

        case (state)
            INST_ADDR: begin
                // Prepare the address from the PC, increase the PC
                inc_pc = 1;
                next_state = INST_FETCH;
            end

            INST_FETCH: begin
                // Read commands from Memory
                rd = 1;
                next_state = INST_LOAD;
            end

            INST_LOAD: begin
                // Load the command into the Instruction Register
                ld_ir = 1;
                next_state = IDLE;
            end

            IDLE: begin
                // Decoding commands based on opcodes
                case (opcode)
                    3'b000: begin // HLT
                        halt = 1;
                        next_state = INST_ADDR; // Can hold halt, depending on design
                    end
                    3'b111: begin // JMP: Jump to address in Operand
                        sel = 1;    // Select operand from IR
                        ld_pc = 1;  // Load PC with operand
                        next_state = INST_ADDR;
                    end
                    3'b101: begin // LDA: loading data from Memory into ACC
                        sel = 1;    // Select the operand address from IR
                        next_state = OP_FETCH;
                    end
                    3'b110: begin // STO: write data from ACC to Memory
                        sel = 1;    // Select the operand address from IR
                        next_state = STORE;
                    end
                    default: begin // Math commands: ADD, AND, XOR, SKZ
                        sel = 1;    // Select operand from IR (if needed)
                        next_state = OP_FETCH;
                    end
                endcase
            end

            OP_FETCH: begin
                // Reading the term Memory (operand)
                rd = 1;
                next_state = ALU_OP;
            end

            ALU_OP: begin
                // Implement ALU; results are loaded into the Accumulator
                ld_ac = 1;
                next_state = INST_ADDR;
            end

            STORE: begin
                // Write data from ACC to Memory
                wr = 1;
                next_state = INST_ADDR;
            end

            default: begin
                next_state = INST_ADDR;
            end
        endcase
    end
endmodule
