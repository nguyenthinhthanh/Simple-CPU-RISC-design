`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2025 10:50:38 AM
// Design Name: 
// Module Name: mem_tb
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


module mem_tb(

    );
    
    reg clk, rst, enable, rw;
    reg [4:0] addr;
    wire [7:0] data;
    
    reg [7:0] data_in;
    reg [7:0] data_driver;
    
    assign data = (data_driver) ? data_in : 8'bz;   // Input value in write case
    
    mem mem_inst(.clk(clk),
                .rst(rst),
                .enable(enable),
                .rw(rw),
                .addr(addr),
                .data(data)
                );
    
    initial begin
        clk = 0;           
        forever #5 clk = ~clk;
    end        
    
    initial begin
//        // Read mem at addr
//        #10 enable = 1; rw = 0; rst = 0;
//        // Prepare new value
//        #10 addr = 5'b00001; data_driver = 8'hA5;
//        // Write new value to mem at addr
//        #10 rw = 1;
//        // Change addr to write
//        #10 addr = 5'b10001;
//        // Read mem at written addr
//        #10 rw = 0;
        // TC1: Reset RAM 
        #10 rst = 1; enable = 0; rw = 0; data_driver = 0;
        #10 rst = 0;
        // TC2: Write multiple values ?
        enable = 1; rw = 1; data_driver = 1;
        addr = 5'd0; data_in = 8'h11;
        #10 addr = 5'd1; data_in = 8'h22;
        #10 addr = 5'd2; data_in = 8'h33;
        #10 addr = 5'd3; data_in = 8'h44;

        // TC3: Disable
        #10 enable = 0;
        // First Step to Test 
        #10 enable = 1; addr = 5'd4; data_in = 8'hFF;

        // TC4: Read value
        #10 rw = 0; enable = 1; data_driver = 0; 
            addr = 5'd0;
        #10 addr = 5'd1;
        #10 addr = 5'd2;
        #10 addr = 5'd3;
        #10 addr = 5'd4;
        
        // TC5: Overwrite data
        #5 data_in = 8'hAB; 
        enable = 1; rw = 1; 
        addr = 5'd4;
        #5 data_driver = 1; 
        
//        rw = 0; 
//        data_driver = 0;
//        addr = 5'd0; #10;
        // TC4: Read value
        #10 rw = 0; enable = 1; data_driver = 0;
            addr = 5'd0;
        #10 addr = 5'd1;
        #10 addr = 5'd2;
        #10 addr = 5'd3;
        #10 addr = 5'd4;
        
        #50 $finish;
    end
endmodule
