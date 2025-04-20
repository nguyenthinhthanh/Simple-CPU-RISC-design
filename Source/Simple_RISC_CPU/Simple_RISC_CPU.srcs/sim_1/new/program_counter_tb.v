`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2025 10:49:21 AM
// Design Name: 
// Module Name: program_counter_tb
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


module program_counter_tb(

    );
    reg clk, rst, inc, load;
    reg [4:0] load_val;
    wire [4:0] pc_out;
    
    program_counter pc_inst(.clk(clk),
                            .rst(rst),
                            .inc(inc),
                            .load(load),
                            .load_val(load_val),
                            .pc_out(pc_out)
                            );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        // Initialize inputs
        rst = 0;
        load = 0;
        inc = 0;
        load_val = 5'b0;

        // Apply reset
        #10 rst = 1; // Assert reset
        #5 rst = 0; // Deassert reset

        // Test load functionality
        #10 load = 1; load_val = 5'b10101;
        #10 load = 0;

        // Test increment functionality
        #10 inc = 1; // Increment PC
        #10 inc = 0;

        // Test continuous increment
        #10 inc = 1;

        // End of test
        #50 $finish;        
    end
endmodule

