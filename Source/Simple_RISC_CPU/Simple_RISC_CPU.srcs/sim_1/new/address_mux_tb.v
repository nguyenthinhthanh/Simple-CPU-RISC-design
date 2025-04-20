`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2025 10:49:59 AM
// Design Name: 
// Module Name: address_mux_tb
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


module address_mux_tb(

    );
    parameter WIDTH = 5;
    
    reg [WIDTH-1:0] pc_addr;
    reg [WIDTH-1:0] instr_addr;
    reg sel;                  
    wire [WIDTH-1:0] addr_out;
    
    address_mux mux_inst(.pc_addr(pc_addr),
                        .instr_addr(instr_addr),
                        .sel(sel),
                        .addr_out(addr_out)
                        );
    initial begin
        // Initialize for pc address & instruction address
        pc_addr = 5'b11111;
        instr_addr = 5'b10000;
        
        // Choose addr
        #5 sel = 0;    // Choose pc_addr as addr_out
        #10 sel = 1;    // Chooose instr_addr as addr_out
        
        // Change pc_addr with sel = 1/0
        #20 pc_addr = 5'b10001; 
        #30 sel = 0; 
        
        // Change instr_add with sel = 0/1
        #40 instr_addr = 5'b00001;
        #50 sel = 1;
        
        #60 $stop;
    end                                          
endmodule
