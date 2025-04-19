# File saved with Nlview 7.0r6  2020-01-29 bk=1.5227 VDI=41 GEI=36 GUI=JA:10.0 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 15
property maxzoom 6.25
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 15
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new cpu_top work:cpu_top:NOFILE -nosplit
load symbol accumulator work:accumulator:NOFILE HIERBOX pin clk input.left pin load input.left pin reset input.left pinBus acc_out output.right [7:0] pinBus data_in input.left [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol alu work:alu:NOFILE HIERBOX pin is_zero output.right pinBus inA input.left [7:0] pinBus inB input.left [7:0] pinBus opcode input.left [2:0] pinBus result output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol controller work:controller:NOFILE HIERBOX pin clk input.left pin data_e output.right pin halt output.right pin inc_pc output.right pin is_zero input.left pin ld_ac output.right pin ld_ir output.right pin ld_pc output.right pin rd output.right pin reset input.left pin sel output.right pin wr output.right pinBus opcode input.left [2:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol instruction_register work:instruction_register:NOFILE HIERBOX pin clk input.left pin load input.left pin reset input.left pinBus data_in input.left [7:0] pinBus instr_out output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol memory work:memory:NOFILE HIERBOX pin clk input.left pin rd input.left pin wr input.left pinBus addr input.left [4:0] pinBus data_in input.left [7:0] pinBus data_out output.right [7:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol address_mux work:address_mux:NOFILE HIERBOX pin sel input.left pinBus addr_out output.right [4:0] pinBus instr_addr input.left [4:0] pinBus pc_addr input.left [4:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol program_counter work:program_counter:NOFILE HIERBOX pin clk input.left pin inc input.left pin load input.left pin reset input.left pinBus data_in input.left [4:0] pinBus pc_out output.right [4:0] boxcolor 1 fillcolor 2 minwidth 13%
load port clk input -pg 1 -lvl 0 -x 0 -y 210
load port reset input -pg 1 -lvl 0 -x 0 -y 330
load inst acc_inst accumulator work:accumulator:NOFILE -autohide -attr @cell(#000000) accumulator -pinBusAttr acc_out @name acc_out[7:0] -pinBusAttr data_in @name data_in[7:0] -pg 1 -lvl 7 -x 2220 -y 260
load inst alu_inst alu work:alu:NOFILE -autohide -attr @cell(#000000) alu -pinBusAttr inA @name inA[7:0] -pinBusAttr inB @name inB[7:0] -pinBusAttr opcode @name opcode[2:0] -pinBusAttr result @name result[7:0] -pg 1 -lvl 5 -x 1500 -y 460
load inst ctrl_inst controller work:controller:NOFILE -autohide -attr @cell(#000000) controller -pinAttr data_e @attr n/c -pinAttr halt @attr n/c -pinBusAttr opcode @name opcode[2:0] -pg 1 -lvl 6 -x 1870 -y 60
load inst ir_inst instruction_register work:instruction_register:NOFILE -autohide -attr @cell(#000000) instruction_register -pinBusAttr data_in @name data_in[7:0] -pinBusAttr instr_out @name instr_out[7:0] -pg 1 -lvl 1 -x 160 -y 260
load inst mem_inst memory work:memory:NOFILE -autohide -attr @cell(#000000) memory -pinBusAttr addr @name addr[4:0] -pinBusAttr data_in @name data_in[7:0] -pinBusAttr data_out @name data_out[7:0] -pg 1 -lvl 4 -x 1170 -y 180
load inst mux_inst address_mux work:address_mux:NOFILE -autohide -attr @cell(#000000) address_mux -pinBusAttr addr_out @name addr_out[4:0] -pinBusAttr instr_addr @name instr_addr[4:0] -pinBusAttr pc_addr @name pc_addr[4:0] -pg 1 -lvl 3 -x 820 -y 420
load inst pc_inst program_counter work:program_counter:NOFILE -autohide -attr @cell(#000000) program_counter -pinBusAttr data_in @name data_in[4:0] -pinBusAttr pc_out @name pc_out[4:0] -pg 1 -lvl 2 -x 510 -y 380
load net acc[0] -attr @rip acc_out[0] -pin acc_inst acc_out[0] -pin alu_inst inA[0] -pin mem_inst data_in[0]
load net acc[1] -attr @rip acc_out[1] -pin acc_inst acc_out[1] -pin alu_inst inA[1] -pin mem_inst data_in[1]
load net acc[2] -attr @rip acc_out[2] -pin acc_inst acc_out[2] -pin alu_inst inA[2] -pin mem_inst data_in[2]
load net acc[3] -attr @rip acc_out[3] -pin acc_inst acc_out[3] -pin alu_inst inA[3] -pin mem_inst data_in[3]
load net acc[4] -attr @rip acc_out[4] -pin acc_inst acc_out[4] -pin alu_inst inA[4] -pin mem_inst data_in[4]
load net acc[5] -attr @rip acc_out[5] -pin acc_inst acc_out[5] -pin alu_inst inA[5] -pin mem_inst data_in[5]
load net acc[6] -attr @rip acc_out[6] -pin acc_inst acc_out[6] -pin alu_inst inA[6] -pin mem_inst data_in[6]
load net acc[7] -attr @rip acc_out[7] -pin acc_inst acc_out[7] -pin alu_inst inA[7] -pin mem_inst data_in[7]
load net alu_result[0] -attr @rip result[0] -pin acc_inst data_in[0] -pin alu_inst result[0]
load net alu_result[1] -attr @rip result[1] -pin acc_inst data_in[1] -pin alu_inst result[1]
load net alu_result[2] -attr @rip result[2] -pin acc_inst data_in[2] -pin alu_inst result[2]
load net alu_result[3] -attr @rip result[3] -pin acc_inst data_in[3] -pin alu_inst result[3]
load net alu_result[4] -attr @rip result[4] -pin acc_inst data_in[4] -pin alu_inst result[4]
load net alu_result[5] -attr @rip result[5] -pin acc_inst data_in[5] -pin alu_inst result[5]
load net alu_result[6] -attr @rip result[6] -pin acc_inst data_in[6] -pin alu_inst result[6]
load net alu_result[7] -attr @rip result[7] -pin acc_inst data_in[7] -pin alu_inst result[7]
load net alu_zero -pin alu_inst is_zero -pin ctrl_inst is_zero
netloc alu_zero 1 5 1 1670 110n
load net clk -pin acc_inst clk -port clk -pin ctrl_inst clk -pin ir_inst clk -pin mem_inst clk -pin pc_inst clk
netloc clk 1 0 7 60 210 390 210 NJ 210 990 90 NJ 90 1730 270 NJ
load net inc_pc -pin ctrl_inst inc_pc -pin pc_inst inc
netloc inc_pc 1 1 6 410 10 NJ 10 NJ 10 NJ 10 NJ 10 2120
load net instr[0] -attr @rip instr_out[0] -pin ir_inst instr_out[0] -pin mux_inst instr_addr[0] -pin pc_inst data_in[0]
load net instr[1] -attr @rip instr_out[1] -pin ir_inst instr_out[1] -pin mux_inst instr_addr[1] -pin pc_inst data_in[1]
load net instr[2] -attr @rip instr_out[2] -pin ir_inst instr_out[2] -pin mux_inst instr_addr[2] -pin pc_inst data_in[2]
load net instr[3] -attr @rip instr_out[3] -pin ir_inst instr_out[3] -pin mux_inst instr_addr[3] -pin pc_inst data_in[3]
load net instr[4] -attr @rip instr_out[4] -pin ir_inst instr_out[4] -pin mux_inst instr_addr[4] -pin pc_inst data_in[4]
load net instr[5] -attr @rip instr_out[5] -pin alu_inst opcode[0] -pin ctrl_inst opcode[0] -pin ir_inst instr_out[5]
load net instr[6] -attr @rip instr_out[6] -pin alu_inst opcode[1] -pin ctrl_inst opcode[1] -pin ir_inst instr_out[6]
load net instr[7] -attr @rip instr_out[7] -pin alu_inst opcode[2] -pin ctrl_inst opcode[2] -pin ir_inst instr_out[7]
load net ld_ac -pin acc_inst load -pin ctrl_inst ld_ac
netloc ld_ac 1 6 1 2120 90n
load net ld_ir -pin ctrl_inst ld_ir -pin ir_inst load
netloc ld_ir 1 0 7 60 370 370J 330 NJ 330 NJ 330 NJ 330 NJ 330 2080
load net ld_pc -pin ctrl_inst ld_pc -pin pc_inst load
netloc ld_pc 1 1 6 410 510 690J 350 NJ 350 NJ 350 NJ 350 2060
load net mem_data_out[0] -attr @rip data_out[0] -pin alu_inst inB[0] -pin ir_inst data_in[0] -pin mem_inst data_out[0]
load net mem_data_out[1] -attr @rip data_out[1] -pin alu_inst inB[1] -pin ir_inst data_in[1] -pin mem_inst data_out[1]
load net mem_data_out[2] -attr @rip data_out[2] -pin alu_inst inB[2] -pin ir_inst data_in[2] -pin mem_inst data_out[2]
load net mem_data_out[3] -attr @rip data_out[3] -pin alu_inst inB[3] -pin ir_inst data_in[3] -pin mem_inst data_out[3]
load net mem_data_out[4] -attr @rip data_out[4] -pin alu_inst inB[4] -pin ir_inst data_in[4] -pin mem_inst data_out[4]
load net mem_data_out[5] -attr @rip data_out[5] -pin alu_inst inB[5] -pin ir_inst data_in[5] -pin mem_inst data_out[5]
load net mem_data_out[6] -attr @rip data_out[6] -pin alu_inst inB[6] -pin ir_inst data_in[6] -pin mem_inst data_out[6]
load net mem_data_out[7] -attr @rip data_out[7] -pin alu_inst inB[7] -pin ir_inst data_in[7] -pin mem_inst data_out[7]
load net mux_addr[0] -attr @rip addr_out[0] -pin mem_inst addr[0] -pin mux_inst addr_out[0]
load net mux_addr[1] -attr @rip addr_out[1] -pin mem_inst addr[1] -pin mux_inst addr_out[1]
load net mux_addr[2] -attr @rip addr_out[2] -pin mem_inst addr[2] -pin mux_inst addr_out[2]
load net mux_addr[3] -attr @rip addr_out[3] -pin mem_inst addr[3] -pin mux_inst addr_out[3]
load net mux_addr[4] -attr @rip addr_out[4] -pin mem_inst addr[4] -pin mux_inst addr_out[4]
load net pc_out[0] -attr @rip pc_out[0] -pin mux_inst pc_addr[0] -pin pc_inst pc_out[0]
load net pc_out[1] -attr @rip pc_out[1] -pin mux_inst pc_addr[1] -pin pc_inst pc_out[1]
load net pc_out[2] -attr @rip pc_out[2] -pin mux_inst pc_addr[2] -pin pc_inst pc_out[2]
load net pc_out[3] -attr @rip pc_out[3] -pin mux_inst pc_addr[3] -pin pc_inst pc_out[3]
load net pc_out[4] -attr @rip pc_out[4] -pin mux_inst pc_addr[4] -pin pc_inst pc_out[4]
load net rd -pin ctrl_inst rd -pin mem_inst rd
netloc rd 1 3 4 1030 110 NJ 110 1650J 230 2020
load net reset -pin acc_inst reset -pin ctrl_inst reset -pin ir_inst reset -pin pc_inst reset -port reset
netloc reset 1 0 7 20 390 330 550 NJ 550 NJ 550 NJ 550 1750 310 2100J
load net sel -pin ctrl_inst sel -pin mux_inst sel
netloc sel 1 2 5 710 510 NJ 510 1380J 370 NJ 370 2040
load net wr -pin ctrl_inst wr -pin mem_inst wr
netloc wr 1 3 4 1050 130 NJ 130 1690J 250 2000
load netBundle @acc 8 acc[7] acc[6] acc[5] acc[4] acc[3] acc[2] acc[1] acc[0] -autobundled
netbloc @acc 1 3 5 1070 310 1400 390 NJ 390 NJ 390 2380
load netBundle @alu_result 8 alu_result[7] alu_result[6] alu_result[5] alu_result[4] alu_result[3] alu_result[2] alu_result[1] alu_result[0] -autobundled
netbloc @alu_result 1 5 2 1770 290 NJ
load netBundle @instr 8 instr[7] instr[6] instr[5] instr[4] instr[3] instr[2] instr[1] instr[0] -autobundled
netbloc @instr 1 1 5 350 310 710 370 NJ 370 1340 410 1710
load netBundle @mem_data_out 8 mem_data_out[7] mem_data_out[6] mem_data_out[5] mem_data_out[4] mem_data_out[3] mem_data_out[2] mem_data_out[1] mem_data_out[0] -autobundled
netbloc @mem_data_out 1 0 5 40 530 NJ 530 NJ 530 NJ 530 1360
load netBundle @mux_addr 5 mux_addr[4] mux_addr[3] mux_addr[2] mux_addr[1] mux_addr[0] -autobundled
netbloc @mux_addr 1 3 1 1010 190n
load netBundle @pc_out 5 pc_out[4] pc_out[3] pc_out[2] pc_out[1] pc_out[0] -autobundled
netbloc @pc_out 1 2 1 670 430n
levelinfo -pg 1 0 160 510 820 1170 1500 1870 2220 2400
pagesize -pg 1 -db -bbox -sgen -80 0 2400 560
show
fullfit
#
# initialize ictrl to current module cpu_top work:cpu_top:NOFILE
ictrl init topinfo |
