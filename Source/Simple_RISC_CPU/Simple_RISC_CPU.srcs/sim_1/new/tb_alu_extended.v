`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 03:42:02 PM
// Design Name: 
// Module Name: tb_alu_extended
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


module tb_alu_extended;

    reg signed [7:0] inA, inB;
    reg [3:0] opcode;
    reg ext;
    wire signed [7:0] result;
    wire overflow;
    wire is_zero;

    alu_extended uut (
        .inA(inA),
        .inB(inB),
        .opcode(opcode),
        .ext(ext),
        .result(result),
        .overflow(overflow),
        .is_zero(is_zero)
    );

    // Convert from real to fixed-point (Q4.4)
    function signed [7:0] from_real;
        input real val;
        real temp;
        begin
            temp = val * 16.0;
            if (temp > 127.0) temp = 127.0;
            else if (temp < -128.0) temp = -128.0;
            from_real = $rtoi(temp);
        end
    endfunction

    // Convert from fixed-point (Q4.4) to real for printing
    function real to_real;
        input signed [7:0] val;
        begin
            to_real = val / 16.0;
        end
    endfunction

    // Task to test a single case
    task test_case;
        input signed [7:0] a, b;
        input [3:0] op;
        input e;
        begin
            inA = a;
            inB = b;
            opcode = op;
            ext = e;
            #10; // wait for combinational logic to settle

            if (ext)
                $display("ext=%b, opcode=%b, inA=%d (%.2f), inB=%d (%.2f) => result=%d (%.2f), overflow=%b, is_zero=%b",
                         ext, opcode, inA, to_real(inA), inB, to_real(inB), result, to_real(result), overflow, is_zero);
            else
                $display("ext=%b, opcode=%b, inA=%d, inB=%d => result=%d, overflow=%b, is_zero=%b",
                         ext, opcode, inA, inB, result, overflow, is_zero);
        end
    endtask

    initial begin
        $display("=== TEST NORMAL MODE ===");

        // HLT, SKZ
        test_case(8'd5, 8'd0, 4'b0000, 0);  // HLT
        test_case(8'd0, 8'd0, 4'b0001, 0);  // SKZ
        test_case(8'd1, 8'd0, 4'b0001, 0);  // SKZ (non-zero)

        // ADD
        test_case(8'd60, 8'd60, 4'b0010, 0); // overflow
        test_case(-8'd70, -8'd70, 4'b0010, 0); // underflow
        test_case(8'd10, 8'd20, 4'b0010, 0);

        // AND, XOR
        test_case(8'b10101010, 8'b11001100, 4'b0011, 0); // AND
        test_case(8'b10101010, 8'b11001100, 4'b0100, 0); // XOR

        // LDA, STO, JMP
        test_case(8'd77, 8'd0, 4'b0101, 0); // LDA
        test_case(8'd88, 8'd0, 4'b0110, 0); // STO
        test_case(8'd99, 8'd0, 4'b0111, 0); // JMP

        // MUL
        test_case(8'd15, 8'd15, 4'b1000, 0); // normal
        test_case(8'd50, 8'd50, 4'b1000, 0); // overflow

        // DIV
        test_case(8'd100, 8'd5, 4'b1001, 0); // normal
        test_case(8'd100, 8'd0, 4'b1001, 0); // divide by 0
        test_case(-8'd100, 8'd0, 4'b1001, 0); // divide by 0 with negative

        $display("=== TEST EXTENDED MODE (Fixed-Point) ===");

        // ADD
        test_case(from_real(2.1), from_real(2.1), 4'b0000, 1);
        // SUB
        test_case(from_real(2.1), from_real(-2.1), 4'b0001, 1);
        // MUL
        test_case(from_real(2.1), from_real(2.1), 4'b0010, 1);
        // DIV
        test_case(from_real(2.1), from_real(3.7), 4'b0011, 1);
        // Passthrough
        test_case(from_real(3.5), 8'd0, 4'b0100, 1);

        $display("=== TEST DONE ===");
        $finish;
    end

endmodule
