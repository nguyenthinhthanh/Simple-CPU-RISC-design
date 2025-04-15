`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 05:20:38 PM
// Design Name: 
// Module Name: cpu_top
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
// Module: cpu_top
// Function: Integrated submodules (PC, Address Mux, Memory, IR,
//                          Accumulator, ALU, and Controller) into a complete CPU.
// =============================================================
module cpu_top (
    input wire clk,
    input wire reset
);
    // ---------- Definition of internal connectivity -----------
    wire [4:0] pc_out;          // Output of PC
    wire [4:0] mux_addr;        // Address out from Address Mux for Memory
    wire [7:0] mem_data_out;    // Data Read Out of Memory
    wire [7:0] instr;           // Commands are loaded into the Instruction Register
    wire [7:0] acc;             // The Value of the Accumulator
    wire [7:0] alu_result;      // Results from ALU
    wire alu_zero;              // is_zero signal from ALU
    wire [2:0] opcode;          // Opcode taken from IR
    wire [4:0] instr_addr;      // Operand (address) is in the IR command

    // Control signal from Controller
    wire sel;
    wire rd;
    wire wr;
    wire ld_ir;
    wire inc_pc;
    wire ld_pc;
    wire ld_ac;
    wire halt;
    wire data_e;

    // ---------- Divide the field of Instruction ----------
    // 8-bit command format: [opcode(3-bit) | operand(5-bit)]
    assign opcode     = instr[7:5];
    assign instr_addr = instr[4:0];

    // ---------- Instantiation sub module ----------
    // Program Counter
    program_counter pc_inst (
        .clk(clk),
        .reset(reset),
        .load(ld_pc),
        .inc(inc_pc),
        .data_in(instr_addr),  // When performing a jump, load the operand from IR into the PC
        .pc_out(pc_out)
    );

    // Address Mux: select address for Memory (PC or operand from IR)
    address_mux #(.WIDTH(5)) mux_inst (
        .pc_addr(pc_out),
        .instr_addr(instr_addr),
        .sel(sel),
        .addr_out(mux_addr)
    );

    // Memory: Program and data storage
    memory mem_inst (
        .clk(clk),
        .addr(mux_addr),
        .data_in(acc),      // Recorded data from the Accumulator (for STO commands)
        .rd(rd),
        .wr(wr),
        .data_out(mem_data_out)
    );

    // Instruction Register
    instruction_register ir_inst (
        .clk(clk),
        .reset(reset),
        .load(ld_ir),
        .data_in(mem_data_out),
        .instr_out(instr)
    );

    // Accumulator Register
    accumulator acc_inst (
        .clk(clk),
        .reset(reset),
        .load(ld_ac),
        .data_in(alu_result),  // Get results from ALU
        .acc_out(acc)
    );

    // ALU: Perform opcode-based math
    alu alu_inst (
        .inA(acc),
        .inB(mem_data_out),
        .opcode(opcode),
        .result(alu_result),
        .is_zero(alu_zero)
    );

    // Controller: control of the entire CPU via FSM
    controller ctrl_inst (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .is_zero(alu_zero),
        .sel(sel),
        .rd(rd),
        .wr(wr),
        .ld_ir(ld_ir),
        .inc_pc(inc_pc), // Although this signal is not used directly in a PC (we use self-boosting), it can be used for debugging.
        .ld_pc(ld_pc),
        .ld_ac(ld_ac),
        .data_e(data_e),
        .halt(halt)
    );

    // Note: The halt signal can be used to stop the simulation or perform a special action.
endmodule
