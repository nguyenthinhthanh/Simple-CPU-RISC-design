`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 08:29:30 PM
// Design Name: 
// Module Name: tb_cpu_top
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


module tb_cpu_top;

    // Khai báo tín hi?u ki?m tra
    reg clk;
    reg reset;

    // Kh?i t?o module cpu_top
    cpu_top uut (
        .clk(clk),
        .reset(reset)
    );

    // T?o tín hi?u clock v?i chu k? 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Kh?i t?o reset và ?i?u khi?n th?i gian mô ph?ng
    initial begin
        // Áp ??t reset ban ??u ?? kh?i t?o toàn b? các module
        reset = 1;
        #10;
        reset = 0;
        
        // Cho phép mô ph?ng ch?y trong m?t kho?ng th?i gian nh?t ??nh,
        // ví d?: 200ns, sau ?ó d?ng mô ph?ng.
        #200;
        $finish;
    end

     initial begin
         $monitor("Time=%0t | PC=%b | Instruction=%b | ACC=%b | Halt=%b",
                  $time, uut.pc_inst.pc_out, uut.ir_inst.instr_out, uut.acc_inst.acc_out, uut.ctrl_inst.halt);
     end

endmodule
