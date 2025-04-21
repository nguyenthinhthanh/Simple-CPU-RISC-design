`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2025 08:40:16 AM
// Design Name: 
// Module Name: instruction_register_tb
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


module instruction_register_tb;

    reg clk;
    reg reset;
    reg load;
    reg [7:0] data_in;
    wire [7:0] instr_out;

    instruction_register uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .data_in(data_in),
        .instr_out(instr_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        load = 0;
        data_in = 8'd0;

        $dumpfile("instruction_register_tb.vcd");
        $dumpvars(0, instruction_register_tb);

        $display("Time\tTest Case\tReset\tLoad\tData_in\tInstr_out");
		//Test Case 1: Reset
        $display("Reset instruction register -----");
        reset = 1;
        #10;
        reset = 0;
        #10;
        if (instr_out !== 8'd0) begin
            $display("Failed: instr_out should be 0");
            $finish;
        end else $display(" Passed: instr_out = 0");
		//Test Case 2: Load giá tr? m?i 
        $display("Load value 42 -----");
        data_in = 8'd42;
        load = 1;
        #10;
        load = 0;
        #10;
        if (instr_out !== 8'd42) begin
            $display("Failed: instr_out should be 42");
            $finish;
        end else $display("Passed: instr_out = 42");
		//Test Case 3: Load = 0, gi? giá tr? 
        $display("Load = 0, gi? instr_out");
        data_in = 8'd99;
        load = 0;
        #10;
        if (instr_out !== 8'd42) begin
            $display("Failed: instr_out should be 42");
            $finish;
        end else $display("TC3 Passed: instr_out = 42");
		//Test Case 4: Reset l?i sau khi có giá tr? 
        $display("Reset sau khi ?ã có giá tr? ");
        reset = 1;
        #10;
        reset = 0;
        #10;
        if (instr_out !== 8'd0) begin
            $display("Failed: instr_out should be 0");
            $finish;
        end else $display("Passed: instr_out = 0");

        $finish;
    end

    always @(posedge clk) begin
        $display("%0dns\t\t%0d\t\t%b\t%b\t%3d\t%3d", $time, $time/10, reset, load, data_in, instr_out);
    end

endmodule
