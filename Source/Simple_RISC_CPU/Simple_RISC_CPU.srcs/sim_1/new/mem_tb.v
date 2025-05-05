`timescale 1ns / 1ps

module mem_tb;
    reg clk;
    reg [4:0] addr;
    reg [7:0] data_in;
    reg rd, wr;
    wire [7:0] data_out;

    // Instantiate the memory module
    memory uut (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .rd(rd),
        .wr(wr),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Kh?i t?o t�n hi?u
        clk = 0;
        addr = 5'b00000;
        data_in = 8'b00000000;
        rd = 0;
        wr = 0;

        #10;
        
        // Ki?m tra ghi d? li?u v�o b? nh?
        addr = 5'b00010;  // ??a ch? 2
        data_in = 8'hAA;  // Gi� tr? c?n ghi
        wr = 1;
        #10;
        wr = 0;  // Ng?ng ghi

        // Ki?m tra ??c d? li?u t? b? nh?
        addr = 5'b00010;  // ??c l?i t? ??a ch? 2
        rd = 1;
        #10;
        rd = 0;

        // Ki?m tra t??ng t? v?i � nh? kh�c
        addr = 5'b00011;
        wr = 1;
        data_in = 8'h55;
        #10;
        wr = 0;
        rd = 1;
        #10;
        rd = 0;

        // Ki?m tra n?u ghi v� ??c c�ng l�c (l?nh c?nh b�o)
        addr = 5'b00100;
        wr = 1;
        rd = 1;
        data_in = 8'hFF;
        #10;
        wr = 0;
        rd = 0;
        #10
        rd = 1;
        addr = 5'b00100;
        // K?t th�c m� ph?ng
        #50 $finish;
    end

    initial begin
        $monitor("Time: %0t | Addr: %0d | Data In: %h | Data Out: %h | RD: %b | WR: %b",
                 $time, addr, data_in, data_out, rd, wr);
    end

endmodule