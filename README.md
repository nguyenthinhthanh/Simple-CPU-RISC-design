# RISC CPU đơn giản

## Giới thiệu
Dự án này là một thiết kế bộ vi xử lý RISC (Reduced Instruction Set Computer) đơn giản, với 3-bit opcode và 5-bit toán hạng. Bộ xử lý có 8 loại câu lệnh và 32 không gian địa chỉ. CPU hoạt động dựa trên tín hiệu clock và reset, chương trình sẽ dừng lại khi có tín hiệu HALT.

## Yêu cầu
Dự án được phát triển bằng cách sử dụng các kiến thức về thiết kế vi mạch và công cụ Cadence để mô phỏng. Hệ thống bao gồm các khối chức năng chính sau:

### Các khối chức năng
- **Program Counter (PC):** Lưu trữ địa chỉ lệnh hiện tại của chương trình.
- **AddressMux:** Chọn giữa địa chỉ của chương trình hoặc địa chỉ của câu lệnh.
- **Memory:** Lưu trữ và cung cấp dữ liệu cho chương trình.
- **Instruction Register:** Giải mã và xử lý dữ liệu lệnh.
- **Accumulator Register:** Lưu trữ kết quả từ ALU.
- **ALU (Arithmetic Logic Unit):** Xử lý các phép toán từ Memory, Accumulator và opcode của Instruction.

Mỗi khối đều có testbench tương ứng để kiểm thử.

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
