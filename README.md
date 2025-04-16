# RISC CPU đơn giản

## Giới thiệu
Dự án này là một thiết kế bộ vi xử lý RISC (Reduced Instruction Set Computer) đơn giản, với 3-bit opcode và 5-bit toán hạng. Bộ xử lý có 8 loại câu lệnh và 32 không gian địa chỉ. CPU hoạt động dựa trên tín hiệu clock và reset, chương trình sẽ dừng lại khi có tín hiệu HALT.

### Table of Contents
- [Giới thiệu](#giới-thiệu)
- [Yêu cầu](#yêu-cầu)
- [Các khối chức năng](#các-khối-chức-năng)
- [Chi tiết các khối chức năng](#chi-tiết-các-khối-chức-năng)
  - [1. Program Counter](#1-program-counter)
  - [2. Address Mux](#2-address-mux)
  - [3. ALU](#3-alu)
  - [4. Controller](#4-controller)
  - [5. Register](#5-register)
  - [6. Memory](#6-memory)
- [Chức năng hệ thống](#chức-năng-hệ-thống)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Cách chạy mô phỏng](#cách-chạy-mô-phỏng)
- [Đóng góp](#đóng-góp)


## Yêu cầu
Dự án được phát triển bằng cách sử dụng các kiến thức về thiết kế vi mạch và công cụ Cadence để mô phỏng. Hệ thống bao gồm các khối chức năng chính sau:

## Các khối chức năng
- **Program Counter (PC):** Lưu trữ địa chỉ lệnh hiện tại của chương trình.
- **AddressMux:** Chọn giữa địa chỉ của chương trình hoặc địa chỉ của câu lệnh.
- **Memory:** Lưu trữ và cung cấp dữ liệu cho chương trình.
- **Instruction Register:** Giải mã và xử lý dữ liệu lệnh.
- **Accumulator Register:** Lưu trữ kết quả từ ALU.
- **ALU (Arithmetic Logic Unit):** Xử lý các phép toán từ Memory, Accumulator và opcode của Instruction.

Mỗi khối đều có testbench tương ứng để kiểm thử.  

## Chi tiết các khối chức năng
### 1. Program Counter
- Counter là bộ đếm quan trọng dùng để đếm câu lệnh của chương trình. Ngoài ra còn có thể
dùng đếm các trạng thái của chương trình.
- Counter phải hoạt động khi có xung lên của clk.
- Reset kích hoạt mức cao, bộ đếm trở về 0.
- Counter với độ rộng số đếm là 5.
- Counter có chức năng load một số bất kì vào bộ đếm. Nếu không, bộ đếm sẽ hoạt động bình
thường.
### 2. Address Mux
- Khối Address Mux với chức năng của Mux sẽ chọn giữa địa chỉ lệnh trong giai đoạn nạp
lệnh và địa chỉa toán hạng trong giai đoạn thực thi lệnh.
- Mux sẽ có độ rộng mặc định là 5.
- Độrộng cần sử dụng parameter để vẫn thay đổi được nếu cần

### 3. ALU
- ALU thực thi những phép toán số học. Phép tính được thực thi sẽ phụ thuộc vào toán tử
 của câu lệnh.
- ALUthực thi 8 phép toán trên số hạng 8-bit (inA và inB). Kết quả sẽ cho ra 8-bit output
 và 1-bit is_zero, is_zero bất đồng bộ nhằm cho biết input inA có bằng 0 hay không.
- Đầu vào opcode 3-bit sẽ quyết định phép toán nào được sử dụng như mô tả trong bảng sau:

| Opcode | Mã  | Hoạt động                                                                                                                                       | Output     |
|--------|-----|--------------------------------------------------------------------------------------------------------------------------------------------------|------------|
| HLT    | 000 | Dừng hoạt động chương trình                                                                                                                    | inA        |
| SKZ    | 001 | Trước tiên sẽ kiểm tra kết quả của ALU có bằng 0 hay không, nếu bằng 0 thì sẽ bỏ qua câu lệnh tiếp theo, ngược lại sẽ tiếp tục thực thi như bình thường | inA        |
| ADD    | 010 | Cộng giá trị trong Accumulator vào giá trị bộ nhớ địa chỉ trong câu lệnh và kết quả được trả về Accumulator.                                   | inA + inB  |
| AND    | 011 | Thực hiện AND giá trị trong Accumulator và giá trị bộ nhớ địa chỉ trong câu lệnh và kết quả được trả về Accumulator.                          | inA and inB|
| XOR    | 100 | Thực hiện XOR giá trị trong Accumulator và giá trị bộ nhớ địa chỉ trong câu lệnh và kết quả được trả về Accumulator.                          | inA or inB |
| LDA    | 101 | Thực hiện đọc giá trị từ địa chỉ trong câu lệnh và đưa vào Accumulator.                                                                        | inB        |
| STO    | 110 | Thực hiện ghi dữ liệu của Accumulator vào địa chỉ trong câu lệnh.                                                                              | inA        |
| JMP    | 111 | Lệnh nhảy không điều kiện, nhảy đến địa chỉ đích trong câu lệnh và tiếp tục thực hiện chương trình                                             | inA        |


### 4. Controller
- Controller quản lý những tín hiệu điều khiển của CPU. Bao gồm nạp và thực thi lệnh.
- Controller phải hoạt động khi có xung lên của clk.
- Tín hiệu rst đồngbộ và kích hoạt mức cao.
- Tín hiệu đầu vào opcode 3-bit tương ứng với ALU
- Controller có 7 output như bảng sau:
  
<div align="center">

| Output   | Function                  |
|----------|---------------------------|
| sel      | select                    |
| rd       | memory read               |
| ld_ir    | load instruction register |
| halt     | halt                      |
| inc_pc   | increment program counter |
| ld_ac    | load accumulator          |
| ld_pc    | load program counter      |
| wr       | memory write              |
| data_e   | data enable               |

</div>


- Controller có 8 trạng thái hoạt động liên tục trong 8 chu kỳ clk theo thứ tự:
 INST_ADDR,INST_FETCH,INST_LOAD,IDLE,OP_ADDR,OP_FETCH,
 ALU_OP,STORE. Trạng thái reset là INST_ADDR.
- Output của Controller dựa theo trạng thái và opcode như bảng sau:

<div align="center">

| Outputs  | INST_ADDR | INST_FETCH | INST_LOAD | IDLE | OP_ADDR | OP_FETCH | ALU_OP        | STORE | Notes                                                           |
|----------|-----------|-------------|------------|------|----------|-----------|----------------|--------|------------------------------------------------------------------|
| sel      | 1         | 1           | 1          | 1    | 0        | 0         | 0              | 0      | ALU OP = 1 if opcode is ADD, AND, XOR or LDA                    |
| rd       | 0         | 1           | 1          | 1    | 0        | ALUOP     | ALUOP          | ALUOP  |                                                                  |
| ld_ir    | 0         | 0           | 1          | 1    | 0        | 0         | 0              | 0      |                                                                  |
| halt     | 0         | 0           | 0          | 0    | HALT     | 0         | 0              | 0      |                                                                  |
| inc_pc   | 0         | 0           | 0          | 0    | 1        | 0         | SKZ && zero    | 0      |                                                                  |
| ld_ac    | 0         | 0           | 0          | 0    | 0        | 0         | 0              | ALUOP  |                                                                  |
| ld_pc    | 0         | 0           | 0          | 0    | 0        | JMP       | JMP            |        |                                                                  |
| wr       | 0         | 0           | 0          | 0    | 0        | 0         | 0              | STO    |                                                                  |
| data_e   | 0         | 0           | 0          | 0    | 0        | STO       | STO            |        |                                                                  |

</div>

### 5. Register
- Tín hiệu đầu vào có độ rộng 8 bits.
- Tín hiệu rst đồng bộ và kích hoạt mức cao.
- Register phải hoạt động khi có xung lên của clk.
- Khi có tín hiệu load, giá trị đầu vào sẽ chuyển đến đầu ra.
- Ngược lại giá trị đầu ra sẽ không đổi

### 6. Memory
- Memory sẽ lưu trữ instruction và data.
- Memory cần được thiết kế tách riêng chức năng đọc/ghi bằng cách sử dụng Single bidirec
tional data port. Không được đọc và ghi cùng lúc.
- 5-bit địa chỉ và 8-bit data.
- 1-bit tín hiệu cho phép đọc/ghi
- Memory phải hoạt động khi có xung lên của clk.

## Chức năng hệ thống
Bộ xử lý thực hiện các bước sau:
1. Nạp lệnh từ bộ nhớ.
2. Giải mã lệnh.
3. Lấy toán hạng từ bộ nhớ (nếu cần).
4. Thực thi câu lệnh, xử lý các phép toán.
5. Lưu kết quả vào bộ nhớ hoặc Accumulator.
6. Lặp lại các bước trên cho đến khi gặp lệnh HALT.

## Công nghệ sử dụng
- **Ngôn ngữ:** Verilog
- **Công cụ mô phỏng:** Cadence
- **Thiết kế số:** FPGA, Digital Design

## Cách chạy mô phỏng
1. Clone repository:
   ```sh
   git clone https://github.com/nguyenthinhthanh/Simple-CPU-RISC-design
   ```
2. Mở dự án trong Cadence.
3. Chạy testbench để kiểm tra từng module.
4. Kiểm tra kết quả đầu ra.

## Đóng góp
Nếu bạn muốn đóng góp vào dự án, vui lòng tạo pull request hoặc mở issue để thảo luận.
