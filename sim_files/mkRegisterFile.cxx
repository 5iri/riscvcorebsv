/*
 * Generated by Bluespec Compiler, version 2025.01.1 (build 65e3a87)
 * 
 * On Mon Apr 14 11:14:53 IST 2025
 * 
 */
#include "bluesim_primitives.h"
#include "mkRegisterFile.h"


/* Constructor */
MOD_mkRegisterFile::MOD_mkRegisterFile(tSimStateHdl simHdl, char const *name, Module *parent)
  : Module(simHdl, name, parent),
    __clk_handle_0(BAD_CLOCK_HANDLE),
    INST_x1(simHdl, "x1", this, 32u, 0u, (tUInt8)0u),
    INST_x10(simHdl, "x10", this, 32u, 0u, (tUInt8)0u),
    INST_x11(simHdl, "x11", this, 32u, 0u, (tUInt8)0u),
    INST_x12(simHdl, "x12", this, 32u, 0u, (tUInt8)0u),
    INST_x13(simHdl, "x13", this, 32u, 0u, (tUInt8)0u),
    INST_x14(simHdl, "x14", this, 32u, 0u, (tUInt8)0u),
    INST_x15(simHdl, "x15", this, 32u, 0u, (tUInt8)0u),
    INST_x16(simHdl, "x16", this, 32u, 0u, (tUInt8)0u),
    INST_x17(simHdl, "x17", this, 32u, 0u, (tUInt8)0u),
    INST_x18(simHdl, "x18", this, 32u, 0u, (tUInt8)0u),
    INST_x19(simHdl, "x19", this, 32u, 0u, (tUInt8)0u),
    INST_x2(simHdl, "x2", this, 32u, 0u, (tUInt8)0u),
    INST_x20(simHdl, "x20", this, 32u, 0u, (tUInt8)0u),
    INST_x21(simHdl, "x21", this, 32u, 0u, (tUInt8)0u),
    INST_x22(simHdl, "x22", this, 32u, 0u, (tUInt8)0u),
    INST_x23(simHdl, "x23", this, 32u, 0u, (tUInt8)0u),
    INST_x24(simHdl, "x24", this, 32u, 0u, (tUInt8)0u),
    INST_x25(simHdl, "x25", this, 32u, 0u, (tUInt8)0u),
    INST_x26(simHdl, "x26", this, 32u, 0u, (tUInt8)0u),
    INST_x27(simHdl, "x27", this, 32u, 0u, (tUInt8)0u),
    INST_x28(simHdl, "x28", this, 32u, 0u, (tUInt8)0u),
    INST_x29(simHdl, "x29", this, 32u, 0u, (tUInt8)0u),
    INST_x3(simHdl, "x3", this, 32u, 0u, (tUInt8)0u),
    INST_x30(simHdl, "x30", this, 32u, 0u, (tUInt8)0u),
    INST_x31(simHdl, "x31", this, 32u, 0u, (tUInt8)0u),
    INST_x4(simHdl, "x4", this, 32u, 0u, (tUInt8)0u),
    INST_x5(simHdl, "x5", this, 32u, 0u, (tUInt8)0u),
    INST_x6(simHdl, "x6", this, 32u, 0u, (tUInt8)0u),
    INST_x7(simHdl, "x7", this, 32u, 0u, (tUInt8)0u),
    INST_x8(simHdl, "x8", this, 32u, 0u, (tUInt8)0u),
    INST_x9(simHdl, "x9", this, 32u, 0u, (tUInt8)0u),
    PORT_RST_N((tUInt8)1u)
{
  PORT_EN_write = false;
  PORT_write_addr = 0u;
  PORT_write_data = 0u;
  symbol_count = 35u;
  symbols = new tSym[symbol_count];
  init_symbols_0();
}


/* Symbol init fns */

void MOD_mkRegisterFile::init_symbols_0()
{
  init_symbol(&symbols[0u], "EN_write", SYM_PORT, &PORT_EN_write, 1u);
  init_symbol(&symbols[1u], "WILL_FIRE_write", SYM_DEF, &DEF_WILL_FIRE_write, 1u);
  init_symbol(&symbols[2u], "write_addr", SYM_PORT, &PORT_write_addr, 5u);
  init_symbol(&symbols[3u], "write_data", SYM_PORT, &PORT_write_data, 32u);
  init_symbol(&symbols[4u], "x1", SYM_MODULE, &INST_x1);
  init_symbol(&symbols[5u], "x10", SYM_MODULE, &INST_x10);
  init_symbol(&symbols[6u], "x11", SYM_MODULE, &INST_x11);
  init_symbol(&symbols[7u], "x12", SYM_MODULE, &INST_x12);
  init_symbol(&symbols[8u], "x13", SYM_MODULE, &INST_x13);
  init_symbol(&symbols[9u], "x14", SYM_MODULE, &INST_x14);
  init_symbol(&symbols[10u], "x15", SYM_MODULE, &INST_x15);
  init_symbol(&symbols[11u], "x16", SYM_MODULE, &INST_x16);
  init_symbol(&symbols[12u], "x17", SYM_MODULE, &INST_x17);
  init_symbol(&symbols[13u], "x18", SYM_MODULE, &INST_x18);
  init_symbol(&symbols[14u], "x19", SYM_MODULE, &INST_x19);
  init_symbol(&symbols[15u], "x2", SYM_MODULE, &INST_x2);
  init_symbol(&symbols[16u], "x20", SYM_MODULE, &INST_x20);
  init_symbol(&symbols[17u], "x21", SYM_MODULE, &INST_x21);
  init_symbol(&symbols[18u], "x22", SYM_MODULE, &INST_x22);
  init_symbol(&symbols[19u], "x23", SYM_MODULE, &INST_x23);
  init_symbol(&symbols[20u], "x24", SYM_MODULE, &INST_x24);
  init_symbol(&symbols[21u], "x25", SYM_MODULE, &INST_x25);
  init_symbol(&symbols[22u], "x26", SYM_MODULE, &INST_x26);
  init_symbol(&symbols[23u], "x27", SYM_MODULE, &INST_x27);
  init_symbol(&symbols[24u], "x28", SYM_MODULE, &INST_x28);
  init_symbol(&symbols[25u], "x29", SYM_MODULE, &INST_x29);
  init_symbol(&symbols[26u], "x3", SYM_MODULE, &INST_x3);
  init_symbol(&symbols[27u], "x30", SYM_MODULE, &INST_x30);
  init_symbol(&symbols[28u], "x31", SYM_MODULE, &INST_x31);
  init_symbol(&symbols[29u], "x4", SYM_MODULE, &INST_x4);
  init_symbol(&symbols[30u], "x5", SYM_MODULE, &INST_x5);
  init_symbol(&symbols[31u], "x6", SYM_MODULE, &INST_x6);
  init_symbol(&symbols[32u], "x7", SYM_MODULE, &INST_x7);
  init_symbol(&symbols[33u], "x8", SYM_MODULE, &INST_x8);
  init_symbol(&symbols[34u], "x9", SYM_MODULE, &INST_x9);
}


/* Rule actions */


/* Methods */

tUInt32 MOD_mkRegisterFile::METH_rs1(tUInt8 ARG_rs1_addr)
{
  tUInt32 PORT_rs1;
  DEF__read__h979 = INST_x31.METH_read();
  DEF__read__h948 = INST_x30.METH_read();
  DEF__read__h917 = INST_x29.METH_read();
  DEF__read__h886 = INST_x28.METH_read();
  DEF__read__h855 = INST_x27.METH_read();
  DEF__read__h824 = INST_x26.METH_read();
  DEF__read__h793 = INST_x25.METH_read();
  DEF__read__h762 = INST_x24.METH_read();
  DEF__read__h731 = INST_x23.METH_read();
  DEF__read__h700 = INST_x22.METH_read();
  DEF__read__h669 = INST_x21.METH_read();
  DEF__read__h638 = INST_x20.METH_read();
  DEF__read__h607 = INST_x19.METH_read();
  DEF__read__h576 = INST_x18.METH_read();
  DEF__read__h545 = INST_x17.METH_read();
  DEF__read__h514 = INST_x16.METH_read();
  DEF__read__h483 = INST_x15.METH_read();
  DEF__read__h452 = INST_x14.METH_read();
  DEF__read__h421 = INST_x13.METH_read();
  DEF__read__h390 = INST_x12.METH_read();
  DEF__read__h359 = INST_x11.METH_read();
  DEF__read__h328 = INST_x10.METH_read();
  DEF__read__h297 = INST_x9.METH_read();
  DEF__read__h266 = INST_x8.METH_read();
  DEF__read__h235 = INST_x7.METH_read();
  DEF__read__h204 = INST_x6.METH_read();
  DEF__read__h173 = INST_x5.METH_read();
  DEF__read__h142 = INST_x4.METH_read();
  DEF__read__h111 = INST_x3.METH_read();
  DEF__read__h80 = INST_x2.METH_read();
  DEF__read__h49 = INST_x1.METH_read();
  switch (ARG_rs1_addr) {
  case (tUInt8)1u:
    PORT_rs1 = DEF__read__h49;
    break;
  case (tUInt8)2u:
    PORT_rs1 = DEF__read__h80;
    break;
  case (tUInt8)3u:
    PORT_rs1 = DEF__read__h111;
    break;
  case (tUInt8)4u:
    PORT_rs1 = DEF__read__h142;
    break;
  case (tUInt8)5u:
    PORT_rs1 = DEF__read__h173;
    break;
  case (tUInt8)6u:
    PORT_rs1 = DEF__read__h204;
    break;
  case (tUInt8)7u:
    PORT_rs1 = DEF__read__h235;
    break;
  case (tUInt8)8u:
    PORT_rs1 = DEF__read__h266;
    break;
  case (tUInt8)9u:
    PORT_rs1 = DEF__read__h297;
    break;
  case (tUInt8)10u:
    PORT_rs1 = DEF__read__h328;
    break;
  case (tUInt8)11u:
    PORT_rs1 = DEF__read__h359;
    break;
  case (tUInt8)12u:
    PORT_rs1 = DEF__read__h390;
    break;
  case (tUInt8)13u:
    PORT_rs1 = DEF__read__h421;
    break;
  case (tUInt8)14u:
    PORT_rs1 = DEF__read__h452;
    break;
  case (tUInt8)15u:
    PORT_rs1 = DEF__read__h483;
    break;
  case (tUInt8)16u:
    PORT_rs1 = DEF__read__h514;
    break;
  case (tUInt8)17u:
    PORT_rs1 = DEF__read__h545;
    break;
  case (tUInt8)18u:
    PORT_rs1 = DEF__read__h576;
    break;
  case (tUInt8)19u:
    PORT_rs1 = DEF__read__h607;
    break;
  case (tUInt8)20u:
    PORT_rs1 = DEF__read__h638;
    break;
  case (tUInt8)21u:
    PORT_rs1 = DEF__read__h669;
    break;
  case (tUInt8)22u:
    PORT_rs1 = DEF__read__h700;
    break;
  case (tUInt8)23u:
    PORT_rs1 = DEF__read__h731;
    break;
  case (tUInt8)24u:
    PORT_rs1 = DEF__read__h762;
    break;
  case (tUInt8)25u:
    PORT_rs1 = DEF__read__h793;
    break;
  case (tUInt8)26u:
    PORT_rs1 = DEF__read__h824;
    break;
  case (tUInt8)27u:
    PORT_rs1 = DEF__read__h855;
    break;
  case (tUInt8)28u:
    PORT_rs1 = DEF__read__h886;
    break;
  case (tUInt8)29u:
    PORT_rs1 = DEF__read__h917;
    break;
  case (tUInt8)30u:
    PORT_rs1 = DEF__read__h948;
    break;
  case (tUInt8)31u:
    PORT_rs1 = DEF__read__h979;
    break;
  default:
    PORT_rs1 = 0u;
  }
  return PORT_rs1;
}

tUInt8 MOD_mkRegisterFile::METH_RDY_rs1()
{
  tUInt8 PORT_RDY_rs1;
  tUInt8 DEF_CAN_FIRE_rs1;
  DEF_CAN_FIRE_rs1 = (tUInt8)1u;
  PORT_RDY_rs1 = DEF_CAN_FIRE_rs1;
  return PORT_RDY_rs1;
}

tUInt32 MOD_mkRegisterFile::METH_rs2(tUInt8 ARG_rs2_addr)
{
  tUInt32 PORT_rs2;
  DEF__read__h979 = INST_x31.METH_read();
  DEF__read__h948 = INST_x30.METH_read();
  DEF__read__h917 = INST_x29.METH_read();
  DEF__read__h886 = INST_x28.METH_read();
  DEF__read__h855 = INST_x27.METH_read();
  DEF__read__h824 = INST_x26.METH_read();
  DEF__read__h793 = INST_x25.METH_read();
  DEF__read__h762 = INST_x24.METH_read();
  DEF__read__h731 = INST_x23.METH_read();
  DEF__read__h700 = INST_x22.METH_read();
  DEF__read__h669 = INST_x21.METH_read();
  DEF__read__h638 = INST_x20.METH_read();
  DEF__read__h607 = INST_x19.METH_read();
  DEF__read__h576 = INST_x18.METH_read();
  DEF__read__h545 = INST_x17.METH_read();
  DEF__read__h514 = INST_x16.METH_read();
  DEF__read__h483 = INST_x15.METH_read();
  DEF__read__h452 = INST_x14.METH_read();
  DEF__read__h421 = INST_x13.METH_read();
  DEF__read__h390 = INST_x12.METH_read();
  DEF__read__h359 = INST_x11.METH_read();
  DEF__read__h328 = INST_x10.METH_read();
  DEF__read__h297 = INST_x9.METH_read();
  DEF__read__h266 = INST_x8.METH_read();
  DEF__read__h235 = INST_x7.METH_read();
  DEF__read__h204 = INST_x6.METH_read();
  DEF__read__h173 = INST_x5.METH_read();
  DEF__read__h142 = INST_x4.METH_read();
  DEF__read__h111 = INST_x3.METH_read();
  DEF__read__h80 = INST_x2.METH_read();
  DEF__read__h49 = INST_x1.METH_read();
  switch (ARG_rs2_addr) {
  case (tUInt8)1u:
    PORT_rs2 = DEF__read__h49;
    break;
  case (tUInt8)2u:
    PORT_rs2 = DEF__read__h80;
    break;
  case (tUInt8)3u:
    PORT_rs2 = DEF__read__h111;
    break;
  case (tUInt8)4u:
    PORT_rs2 = DEF__read__h142;
    break;
  case (tUInt8)5u:
    PORT_rs2 = DEF__read__h173;
    break;
  case (tUInt8)6u:
    PORT_rs2 = DEF__read__h204;
    break;
  case (tUInt8)7u:
    PORT_rs2 = DEF__read__h235;
    break;
  case (tUInt8)8u:
    PORT_rs2 = DEF__read__h266;
    break;
  case (tUInt8)9u:
    PORT_rs2 = DEF__read__h297;
    break;
  case (tUInt8)10u:
    PORT_rs2 = DEF__read__h328;
    break;
  case (tUInt8)11u:
    PORT_rs2 = DEF__read__h359;
    break;
  case (tUInt8)12u:
    PORT_rs2 = DEF__read__h390;
    break;
  case (tUInt8)13u:
    PORT_rs2 = DEF__read__h421;
    break;
  case (tUInt8)14u:
    PORT_rs2 = DEF__read__h452;
    break;
  case (tUInt8)15u:
    PORT_rs2 = DEF__read__h483;
    break;
  case (tUInt8)16u:
    PORT_rs2 = DEF__read__h514;
    break;
  case (tUInt8)17u:
    PORT_rs2 = DEF__read__h545;
    break;
  case (tUInt8)18u:
    PORT_rs2 = DEF__read__h576;
    break;
  case (tUInt8)19u:
    PORT_rs2 = DEF__read__h607;
    break;
  case (tUInt8)20u:
    PORT_rs2 = DEF__read__h638;
    break;
  case (tUInt8)21u:
    PORT_rs2 = DEF__read__h669;
    break;
  case (tUInt8)22u:
    PORT_rs2 = DEF__read__h700;
    break;
  case (tUInt8)23u:
    PORT_rs2 = DEF__read__h731;
    break;
  case (tUInt8)24u:
    PORT_rs2 = DEF__read__h762;
    break;
  case (tUInt8)25u:
    PORT_rs2 = DEF__read__h793;
    break;
  case (tUInt8)26u:
    PORT_rs2 = DEF__read__h824;
    break;
  case (tUInt8)27u:
    PORT_rs2 = DEF__read__h855;
    break;
  case (tUInt8)28u:
    PORT_rs2 = DEF__read__h886;
    break;
  case (tUInt8)29u:
    PORT_rs2 = DEF__read__h917;
    break;
  case (tUInt8)30u:
    PORT_rs2 = DEF__read__h948;
    break;
  case (tUInt8)31u:
    PORT_rs2 = DEF__read__h979;
    break;
  default:
    PORT_rs2 = 0u;
  }
  return PORT_rs2;
}

tUInt8 MOD_mkRegisterFile::METH_RDY_rs2()
{
  tUInt8 PORT_RDY_rs2;
  tUInt8 DEF_CAN_FIRE_rs2;
  DEF_CAN_FIRE_rs2 = (tUInt8)1u;
  PORT_RDY_rs2 = DEF_CAN_FIRE_rs2;
  return PORT_RDY_rs2;
}

void MOD_mkRegisterFile::METH_write(tUInt8 ARG_write_addr, tUInt32 ARG_write_data)
{
  tUInt8 DEF_write_addr_EQ_0b1___d158;
  tUInt8 DEF_write_addr_EQ_0b10___d159;
  tUInt8 DEF_write_addr_EQ_0b11___d160;
  tUInt8 DEF_write_addr_EQ_0b100___d161;
  tUInt8 DEF_write_addr_EQ_0b101___d162;
  tUInt8 DEF_write_addr_EQ_0b110___d163;
  tUInt8 DEF_write_addr_EQ_0b111___d164;
  tUInt8 DEF_write_addr_EQ_0b1000___d165;
  tUInt8 DEF_write_addr_EQ_0b1001___d166;
  tUInt8 DEF_write_addr_EQ_0b1010___d167;
  tUInt8 DEF_write_addr_EQ_0b1011___d168;
  tUInt8 DEF_write_addr_EQ_0b1100___d169;
  tUInt8 DEF_write_addr_EQ_0b1101___d170;
  tUInt8 DEF_write_addr_EQ_0b1110___d171;
  tUInt8 DEF_write_addr_EQ_0b1111___d172;
  tUInt8 DEF_write_addr_EQ_0b10000___d173;
  tUInt8 DEF_write_addr_EQ_0b10001___d174;
  tUInt8 DEF_write_addr_EQ_0b10010___d175;
  tUInt8 DEF_write_addr_EQ_0b10011___d176;
  tUInt8 DEF_write_addr_EQ_0b10100___d177;
  tUInt8 DEF_write_addr_EQ_0b10101___d178;
  tUInt8 DEF_write_addr_EQ_0b10110___d179;
  tUInt8 DEF_write_addr_EQ_0b10111___d180;
  tUInt8 DEF_write_addr_EQ_0b11000___d181;
  tUInt8 DEF_write_addr_EQ_0b11001___d182;
  tUInt8 DEF_write_addr_EQ_0b11010___d183;
  tUInt8 DEF_write_addr_EQ_0b11011___d184;
  tUInt8 DEF_write_addr_EQ_0b11100___d185;
  tUInt8 DEF_write_addr_EQ_0b11101___d186;
  tUInt8 DEF_write_addr_EQ_0b11110___d187;
  tUInt8 DEF_write_addr_EQ_0b11111___d188;
  PORT_EN_write = (tUInt8)1u;
  DEF_WILL_FIRE_write = (tUInt8)1u;
  PORT_write_addr = ARG_write_addr;
  PORT_write_data = ARG_write_data;
  DEF_write_addr_EQ_0b11111___d188 = ARG_write_addr == (tUInt8)31u;
  DEF_write_addr_EQ_0b11110___d187 = ARG_write_addr == (tUInt8)30u;
  DEF_write_addr_EQ_0b11101___d186 = ARG_write_addr == (tUInt8)29u;
  DEF_write_addr_EQ_0b11100___d185 = ARG_write_addr == (tUInt8)28u;
  DEF_write_addr_EQ_0b11011___d184 = ARG_write_addr == (tUInt8)27u;
  DEF_write_addr_EQ_0b11010___d183 = ARG_write_addr == (tUInt8)26u;
  DEF_write_addr_EQ_0b11001___d182 = ARG_write_addr == (tUInt8)25u;
  DEF_write_addr_EQ_0b11000___d181 = ARG_write_addr == (tUInt8)24u;
  DEF_write_addr_EQ_0b10111___d180 = ARG_write_addr == (tUInt8)23u;
  DEF_write_addr_EQ_0b10110___d179 = ARG_write_addr == (tUInt8)22u;
  DEF_write_addr_EQ_0b10101___d178 = ARG_write_addr == (tUInt8)21u;
  DEF_write_addr_EQ_0b10100___d177 = ARG_write_addr == (tUInt8)20u;
  DEF_write_addr_EQ_0b10011___d176 = ARG_write_addr == (tUInt8)19u;
  DEF_write_addr_EQ_0b10010___d175 = ARG_write_addr == (tUInt8)18u;
  DEF_write_addr_EQ_0b10001___d174 = ARG_write_addr == (tUInt8)17u;
  DEF_write_addr_EQ_0b10000___d173 = ARG_write_addr == (tUInt8)16u;
  DEF_write_addr_EQ_0b1111___d172 = ARG_write_addr == (tUInt8)15u;
  DEF_write_addr_EQ_0b1110___d171 = ARG_write_addr == (tUInt8)14u;
  DEF_write_addr_EQ_0b1101___d170 = ARG_write_addr == (tUInt8)13u;
  DEF_write_addr_EQ_0b1100___d169 = ARG_write_addr == (tUInt8)12u;
  DEF_write_addr_EQ_0b1011___d168 = ARG_write_addr == (tUInt8)11u;
  DEF_write_addr_EQ_0b1010___d167 = ARG_write_addr == (tUInt8)10u;
  DEF_write_addr_EQ_0b1001___d166 = ARG_write_addr == (tUInt8)9u;
  DEF_write_addr_EQ_0b1000___d165 = ARG_write_addr == (tUInt8)8u;
  DEF_write_addr_EQ_0b111___d164 = ARG_write_addr == (tUInt8)7u;
  DEF_write_addr_EQ_0b110___d163 = ARG_write_addr == (tUInt8)6u;
  DEF_write_addr_EQ_0b101___d162 = ARG_write_addr == (tUInt8)5u;
  DEF_write_addr_EQ_0b100___d161 = ARG_write_addr == (tUInt8)4u;
  DEF_write_addr_EQ_0b11___d160 = ARG_write_addr == (tUInt8)3u;
  DEF_write_addr_EQ_0b1___d158 = ARG_write_addr == (tUInt8)1u;
  DEF_write_addr_EQ_0b10___d159 = ARG_write_addr == (tUInt8)2u;
  if (DEF_write_addr_EQ_0b1___d158)
    INST_x1.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10___d159)
    INST_x2.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11___d160)
    INST_x3.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b100___d161)
    INST_x4.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b101___d162)
    INST_x5.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b110___d163)
    INST_x6.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b111___d164)
    INST_x7.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1000___d165)
    INST_x8.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1001___d166)
    INST_x9.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1010___d167)
    INST_x10.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1011___d168)
    INST_x11.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1100___d169)
    INST_x12.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1101___d170)
    INST_x13.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1110___d171)
    INST_x14.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b1111___d172)
    INST_x15.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10000___d173)
    INST_x16.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10001___d174)
    INST_x17.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10010___d175)
    INST_x18.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10011___d176)
    INST_x19.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10100___d177)
    INST_x20.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10101___d178)
    INST_x21.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10110___d179)
    INST_x22.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b10111___d180)
    INST_x23.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11000___d181)
    INST_x24.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11001___d182)
    INST_x25.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11010___d183)
    INST_x26.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11011___d184)
    INST_x27.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11100___d185)
    INST_x28.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11101___d186)
    INST_x29.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11111___d188)
    INST_x31.METH_write(ARG_write_data);
  if (DEF_write_addr_EQ_0b11110___d187)
    INST_x30.METH_write(ARG_write_data);
}

tUInt8 MOD_mkRegisterFile::METH_RDY_write()
{
  tUInt8 PORT_RDY_write;
  tUInt8 DEF_CAN_FIRE_write;
  DEF_CAN_FIRE_write = (tUInt8)1u;
  PORT_RDY_write = DEF_CAN_FIRE_write;
  return PORT_RDY_write;
}


/* Reset routines */

void MOD_mkRegisterFile::reset_RST_N(tUInt8 ARG_rst_in)
{
  PORT_RST_N = ARG_rst_in;
  INST_x9.reset_RST(ARG_rst_in);
  INST_x8.reset_RST(ARG_rst_in);
  INST_x7.reset_RST(ARG_rst_in);
  INST_x6.reset_RST(ARG_rst_in);
  INST_x5.reset_RST(ARG_rst_in);
  INST_x4.reset_RST(ARG_rst_in);
  INST_x31.reset_RST(ARG_rst_in);
  INST_x30.reset_RST(ARG_rst_in);
  INST_x3.reset_RST(ARG_rst_in);
  INST_x29.reset_RST(ARG_rst_in);
  INST_x28.reset_RST(ARG_rst_in);
  INST_x27.reset_RST(ARG_rst_in);
  INST_x26.reset_RST(ARG_rst_in);
  INST_x25.reset_RST(ARG_rst_in);
  INST_x24.reset_RST(ARG_rst_in);
  INST_x23.reset_RST(ARG_rst_in);
  INST_x22.reset_RST(ARG_rst_in);
  INST_x21.reset_RST(ARG_rst_in);
  INST_x20.reset_RST(ARG_rst_in);
  INST_x2.reset_RST(ARG_rst_in);
  INST_x19.reset_RST(ARG_rst_in);
  INST_x18.reset_RST(ARG_rst_in);
  INST_x17.reset_RST(ARG_rst_in);
  INST_x16.reset_RST(ARG_rst_in);
  INST_x15.reset_RST(ARG_rst_in);
  INST_x14.reset_RST(ARG_rst_in);
  INST_x13.reset_RST(ARG_rst_in);
  INST_x12.reset_RST(ARG_rst_in);
  INST_x11.reset_RST(ARG_rst_in);
  INST_x10.reset_RST(ARG_rst_in);
  INST_x1.reset_RST(ARG_rst_in);
}


/* Static handles to reset routines */


/* Functions for the parent module to register its reset fns */


/* Functions to set the elaborated clock id */

void MOD_mkRegisterFile::set_clk_0(char const *s)
{
  __clk_handle_0 = bk_get_or_define_clock(sim_hdl, s);
}


/* State dumping routine */
void MOD_mkRegisterFile::dump_state(unsigned int indent)
{
  printf("%*s%s:\n", indent, "", inst_name);
  INST_x1.dump_state(indent + 2u);
  INST_x10.dump_state(indent + 2u);
  INST_x11.dump_state(indent + 2u);
  INST_x12.dump_state(indent + 2u);
  INST_x13.dump_state(indent + 2u);
  INST_x14.dump_state(indent + 2u);
  INST_x15.dump_state(indent + 2u);
  INST_x16.dump_state(indent + 2u);
  INST_x17.dump_state(indent + 2u);
  INST_x18.dump_state(indent + 2u);
  INST_x19.dump_state(indent + 2u);
  INST_x2.dump_state(indent + 2u);
  INST_x20.dump_state(indent + 2u);
  INST_x21.dump_state(indent + 2u);
  INST_x22.dump_state(indent + 2u);
  INST_x23.dump_state(indent + 2u);
  INST_x24.dump_state(indent + 2u);
  INST_x25.dump_state(indent + 2u);
  INST_x26.dump_state(indent + 2u);
  INST_x27.dump_state(indent + 2u);
  INST_x28.dump_state(indent + 2u);
  INST_x29.dump_state(indent + 2u);
  INST_x3.dump_state(indent + 2u);
  INST_x30.dump_state(indent + 2u);
  INST_x31.dump_state(indent + 2u);
  INST_x4.dump_state(indent + 2u);
  INST_x5.dump_state(indent + 2u);
  INST_x6.dump_state(indent + 2u);
  INST_x7.dump_state(indent + 2u);
  INST_x8.dump_state(indent + 2u);
  INST_x9.dump_state(indent + 2u);
}


/* VCD dumping routines */

unsigned int MOD_mkRegisterFile::dump_VCD_defs(unsigned int levels)
{
  vcd_write_scope_start(sim_hdl, inst_name);
  vcd_num = vcd_reserve_ids(sim_hdl, 67u);
  unsigned int num = vcd_num;
  for (unsigned int clk = 0u; clk < bk_num_clocks(sim_hdl); ++clk)
    vcd_add_clock_def(sim_hdl, this, bk_clock_name(sim_hdl, clk), bk_clock_vcd_num(sim_hdl, clk));
  vcd_write_def(sim_hdl, bk_clock_vcd_num(sim_hdl, __clk_handle_0), "CLK", 1u);
  vcd_write_def(sim_hdl, num++, "RST_N", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "WILL_FIRE_write", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h111", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h142", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h173", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h204", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h235", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h266", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h297", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h328", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h359", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h390", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h421", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h452", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h483", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h49", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h514", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h545", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h576", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h607", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h638", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h669", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h700", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h731", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h762", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h793", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h80", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h824", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h855", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h886", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h917", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h948", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "_read__h979", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "EN_write", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "write_addr", 5u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "write_data", 32u);
  num = INST_x1.dump_VCD_defs(num);
  num = INST_x10.dump_VCD_defs(num);
  num = INST_x11.dump_VCD_defs(num);
  num = INST_x12.dump_VCD_defs(num);
  num = INST_x13.dump_VCD_defs(num);
  num = INST_x14.dump_VCD_defs(num);
  num = INST_x15.dump_VCD_defs(num);
  num = INST_x16.dump_VCD_defs(num);
  num = INST_x17.dump_VCD_defs(num);
  num = INST_x18.dump_VCD_defs(num);
  num = INST_x19.dump_VCD_defs(num);
  num = INST_x2.dump_VCD_defs(num);
  num = INST_x20.dump_VCD_defs(num);
  num = INST_x21.dump_VCD_defs(num);
  num = INST_x22.dump_VCD_defs(num);
  num = INST_x23.dump_VCD_defs(num);
  num = INST_x24.dump_VCD_defs(num);
  num = INST_x25.dump_VCD_defs(num);
  num = INST_x26.dump_VCD_defs(num);
  num = INST_x27.dump_VCD_defs(num);
  num = INST_x28.dump_VCD_defs(num);
  num = INST_x29.dump_VCD_defs(num);
  num = INST_x3.dump_VCD_defs(num);
  num = INST_x30.dump_VCD_defs(num);
  num = INST_x31.dump_VCD_defs(num);
  num = INST_x4.dump_VCD_defs(num);
  num = INST_x5.dump_VCD_defs(num);
  num = INST_x6.dump_VCD_defs(num);
  num = INST_x7.dump_VCD_defs(num);
  num = INST_x8.dump_VCD_defs(num);
  num = INST_x9.dump_VCD_defs(num);
  vcd_write_scope_end(sim_hdl);
  return num;
}

void MOD_mkRegisterFile::dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkRegisterFile &backing)
{
  vcd_defs(dt, backing);
  vcd_prims(dt, backing);
}

void MOD_mkRegisterFile::vcd_defs(tVCDDumpType dt, MOD_mkRegisterFile &backing)
{
  unsigned int num = vcd_num;
  if (dt == VCD_DUMP_XS)
  {
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 5u);
    vcd_write_x(sim_hdl, num++, 32u);
  }
  else
    if (dt == VCD_DUMP_CHANGES)
    {
      if ((backing.PORT_RST_N) != PORT_RST_N)
      {
	vcd_write_val(sim_hdl, num, PORT_RST_N, 1u);
	backing.PORT_RST_N = PORT_RST_N;
      }
      ++num;
      if ((backing.DEF_WILL_FIRE_write) != DEF_WILL_FIRE_write)
      {
	vcd_write_val(sim_hdl, num, DEF_WILL_FIRE_write, 1u);
	backing.DEF_WILL_FIRE_write = DEF_WILL_FIRE_write;
      }
      ++num;
      if ((backing.DEF__read__h111) != DEF__read__h111)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h111, 32u);
	backing.DEF__read__h111 = DEF__read__h111;
      }
      ++num;
      if ((backing.DEF__read__h142) != DEF__read__h142)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h142, 32u);
	backing.DEF__read__h142 = DEF__read__h142;
      }
      ++num;
      if ((backing.DEF__read__h173) != DEF__read__h173)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h173, 32u);
	backing.DEF__read__h173 = DEF__read__h173;
      }
      ++num;
      if ((backing.DEF__read__h204) != DEF__read__h204)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h204, 32u);
	backing.DEF__read__h204 = DEF__read__h204;
      }
      ++num;
      if ((backing.DEF__read__h235) != DEF__read__h235)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h235, 32u);
	backing.DEF__read__h235 = DEF__read__h235;
      }
      ++num;
      if ((backing.DEF__read__h266) != DEF__read__h266)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h266, 32u);
	backing.DEF__read__h266 = DEF__read__h266;
      }
      ++num;
      if ((backing.DEF__read__h297) != DEF__read__h297)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h297, 32u);
	backing.DEF__read__h297 = DEF__read__h297;
      }
      ++num;
      if ((backing.DEF__read__h328) != DEF__read__h328)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h328, 32u);
	backing.DEF__read__h328 = DEF__read__h328;
      }
      ++num;
      if ((backing.DEF__read__h359) != DEF__read__h359)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h359, 32u);
	backing.DEF__read__h359 = DEF__read__h359;
      }
      ++num;
      if ((backing.DEF__read__h390) != DEF__read__h390)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h390, 32u);
	backing.DEF__read__h390 = DEF__read__h390;
      }
      ++num;
      if ((backing.DEF__read__h421) != DEF__read__h421)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h421, 32u);
	backing.DEF__read__h421 = DEF__read__h421;
      }
      ++num;
      if ((backing.DEF__read__h452) != DEF__read__h452)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h452, 32u);
	backing.DEF__read__h452 = DEF__read__h452;
      }
      ++num;
      if ((backing.DEF__read__h483) != DEF__read__h483)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h483, 32u);
	backing.DEF__read__h483 = DEF__read__h483;
      }
      ++num;
      if ((backing.DEF__read__h49) != DEF__read__h49)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h49, 32u);
	backing.DEF__read__h49 = DEF__read__h49;
      }
      ++num;
      if ((backing.DEF__read__h514) != DEF__read__h514)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h514, 32u);
	backing.DEF__read__h514 = DEF__read__h514;
      }
      ++num;
      if ((backing.DEF__read__h545) != DEF__read__h545)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h545, 32u);
	backing.DEF__read__h545 = DEF__read__h545;
      }
      ++num;
      if ((backing.DEF__read__h576) != DEF__read__h576)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h576, 32u);
	backing.DEF__read__h576 = DEF__read__h576;
      }
      ++num;
      if ((backing.DEF__read__h607) != DEF__read__h607)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h607, 32u);
	backing.DEF__read__h607 = DEF__read__h607;
      }
      ++num;
      if ((backing.DEF__read__h638) != DEF__read__h638)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h638, 32u);
	backing.DEF__read__h638 = DEF__read__h638;
      }
      ++num;
      if ((backing.DEF__read__h669) != DEF__read__h669)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h669, 32u);
	backing.DEF__read__h669 = DEF__read__h669;
      }
      ++num;
      if ((backing.DEF__read__h700) != DEF__read__h700)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h700, 32u);
	backing.DEF__read__h700 = DEF__read__h700;
      }
      ++num;
      if ((backing.DEF__read__h731) != DEF__read__h731)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h731, 32u);
	backing.DEF__read__h731 = DEF__read__h731;
      }
      ++num;
      if ((backing.DEF__read__h762) != DEF__read__h762)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h762, 32u);
	backing.DEF__read__h762 = DEF__read__h762;
      }
      ++num;
      if ((backing.DEF__read__h793) != DEF__read__h793)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h793, 32u);
	backing.DEF__read__h793 = DEF__read__h793;
      }
      ++num;
      if ((backing.DEF__read__h80) != DEF__read__h80)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h80, 32u);
	backing.DEF__read__h80 = DEF__read__h80;
      }
      ++num;
      if ((backing.DEF__read__h824) != DEF__read__h824)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h824, 32u);
	backing.DEF__read__h824 = DEF__read__h824;
      }
      ++num;
      if ((backing.DEF__read__h855) != DEF__read__h855)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h855, 32u);
	backing.DEF__read__h855 = DEF__read__h855;
      }
      ++num;
      if ((backing.DEF__read__h886) != DEF__read__h886)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h886, 32u);
	backing.DEF__read__h886 = DEF__read__h886;
      }
      ++num;
      if ((backing.DEF__read__h917) != DEF__read__h917)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h917, 32u);
	backing.DEF__read__h917 = DEF__read__h917;
      }
      ++num;
      if ((backing.DEF__read__h948) != DEF__read__h948)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h948, 32u);
	backing.DEF__read__h948 = DEF__read__h948;
      }
      ++num;
      if ((backing.DEF__read__h979) != DEF__read__h979)
      {
	vcd_write_val(sim_hdl, num, DEF__read__h979, 32u);
	backing.DEF__read__h979 = DEF__read__h979;
      }
      ++num;
      if ((backing.PORT_EN_write) != PORT_EN_write)
      {
	vcd_write_val(sim_hdl, num, PORT_EN_write, 1u);
	backing.PORT_EN_write = PORT_EN_write;
      }
      ++num;
      if ((backing.PORT_write_addr) != PORT_write_addr)
      {
	vcd_write_val(sim_hdl, num, PORT_write_addr, 5u);
	backing.PORT_write_addr = PORT_write_addr;
      }
      ++num;
      if ((backing.PORT_write_data) != PORT_write_data)
      {
	vcd_write_val(sim_hdl, num, PORT_write_data, 32u);
	backing.PORT_write_data = PORT_write_data;
      }
      ++num;
    }
    else
    {
      vcd_write_val(sim_hdl, num++, PORT_RST_N, 1u);
      backing.PORT_RST_N = PORT_RST_N;
      vcd_write_val(sim_hdl, num++, DEF_WILL_FIRE_write, 1u);
      backing.DEF_WILL_FIRE_write = DEF_WILL_FIRE_write;
      vcd_write_val(sim_hdl, num++, DEF__read__h111, 32u);
      backing.DEF__read__h111 = DEF__read__h111;
      vcd_write_val(sim_hdl, num++, DEF__read__h142, 32u);
      backing.DEF__read__h142 = DEF__read__h142;
      vcd_write_val(sim_hdl, num++, DEF__read__h173, 32u);
      backing.DEF__read__h173 = DEF__read__h173;
      vcd_write_val(sim_hdl, num++, DEF__read__h204, 32u);
      backing.DEF__read__h204 = DEF__read__h204;
      vcd_write_val(sim_hdl, num++, DEF__read__h235, 32u);
      backing.DEF__read__h235 = DEF__read__h235;
      vcd_write_val(sim_hdl, num++, DEF__read__h266, 32u);
      backing.DEF__read__h266 = DEF__read__h266;
      vcd_write_val(sim_hdl, num++, DEF__read__h297, 32u);
      backing.DEF__read__h297 = DEF__read__h297;
      vcd_write_val(sim_hdl, num++, DEF__read__h328, 32u);
      backing.DEF__read__h328 = DEF__read__h328;
      vcd_write_val(sim_hdl, num++, DEF__read__h359, 32u);
      backing.DEF__read__h359 = DEF__read__h359;
      vcd_write_val(sim_hdl, num++, DEF__read__h390, 32u);
      backing.DEF__read__h390 = DEF__read__h390;
      vcd_write_val(sim_hdl, num++, DEF__read__h421, 32u);
      backing.DEF__read__h421 = DEF__read__h421;
      vcd_write_val(sim_hdl, num++, DEF__read__h452, 32u);
      backing.DEF__read__h452 = DEF__read__h452;
      vcd_write_val(sim_hdl, num++, DEF__read__h483, 32u);
      backing.DEF__read__h483 = DEF__read__h483;
      vcd_write_val(sim_hdl, num++, DEF__read__h49, 32u);
      backing.DEF__read__h49 = DEF__read__h49;
      vcd_write_val(sim_hdl, num++, DEF__read__h514, 32u);
      backing.DEF__read__h514 = DEF__read__h514;
      vcd_write_val(sim_hdl, num++, DEF__read__h545, 32u);
      backing.DEF__read__h545 = DEF__read__h545;
      vcd_write_val(sim_hdl, num++, DEF__read__h576, 32u);
      backing.DEF__read__h576 = DEF__read__h576;
      vcd_write_val(sim_hdl, num++, DEF__read__h607, 32u);
      backing.DEF__read__h607 = DEF__read__h607;
      vcd_write_val(sim_hdl, num++, DEF__read__h638, 32u);
      backing.DEF__read__h638 = DEF__read__h638;
      vcd_write_val(sim_hdl, num++, DEF__read__h669, 32u);
      backing.DEF__read__h669 = DEF__read__h669;
      vcd_write_val(sim_hdl, num++, DEF__read__h700, 32u);
      backing.DEF__read__h700 = DEF__read__h700;
      vcd_write_val(sim_hdl, num++, DEF__read__h731, 32u);
      backing.DEF__read__h731 = DEF__read__h731;
      vcd_write_val(sim_hdl, num++, DEF__read__h762, 32u);
      backing.DEF__read__h762 = DEF__read__h762;
      vcd_write_val(sim_hdl, num++, DEF__read__h793, 32u);
      backing.DEF__read__h793 = DEF__read__h793;
      vcd_write_val(sim_hdl, num++, DEF__read__h80, 32u);
      backing.DEF__read__h80 = DEF__read__h80;
      vcd_write_val(sim_hdl, num++, DEF__read__h824, 32u);
      backing.DEF__read__h824 = DEF__read__h824;
      vcd_write_val(sim_hdl, num++, DEF__read__h855, 32u);
      backing.DEF__read__h855 = DEF__read__h855;
      vcd_write_val(sim_hdl, num++, DEF__read__h886, 32u);
      backing.DEF__read__h886 = DEF__read__h886;
      vcd_write_val(sim_hdl, num++, DEF__read__h917, 32u);
      backing.DEF__read__h917 = DEF__read__h917;
      vcd_write_val(sim_hdl, num++, DEF__read__h948, 32u);
      backing.DEF__read__h948 = DEF__read__h948;
      vcd_write_val(sim_hdl, num++, DEF__read__h979, 32u);
      backing.DEF__read__h979 = DEF__read__h979;
      vcd_write_val(sim_hdl, num++, PORT_EN_write, 1u);
      backing.PORT_EN_write = PORT_EN_write;
      vcd_write_val(sim_hdl, num++, PORT_write_addr, 5u);
      backing.PORT_write_addr = PORT_write_addr;
      vcd_write_val(sim_hdl, num++, PORT_write_data, 32u);
      backing.PORT_write_data = PORT_write_data;
    }
}

void MOD_mkRegisterFile::vcd_prims(tVCDDumpType dt, MOD_mkRegisterFile &backing)
{
  INST_x1.dump_VCD(dt, backing.INST_x1);
  INST_x10.dump_VCD(dt, backing.INST_x10);
  INST_x11.dump_VCD(dt, backing.INST_x11);
  INST_x12.dump_VCD(dt, backing.INST_x12);
  INST_x13.dump_VCD(dt, backing.INST_x13);
  INST_x14.dump_VCD(dt, backing.INST_x14);
  INST_x15.dump_VCD(dt, backing.INST_x15);
  INST_x16.dump_VCD(dt, backing.INST_x16);
  INST_x17.dump_VCD(dt, backing.INST_x17);
  INST_x18.dump_VCD(dt, backing.INST_x18);
  INST_x19.dump_VCD(dt, backing.INST_x19);
  INST_x2.dump_VCD(dt, backing.INST_x2);
  INST_x20.dump_VCD(dt, backing.INST_x20);
  INST_x21.dump_VCD(dt, backing.INST_x21);
  INST_x22.dump_VCD(dt, backing.INST_x22);
  INST_x23.dump_VCD(dt, backing.INST_x23);
  INST_x24.dump_VCD(dt, backing.INST_x24);
  INST_x25.dump_VCD(dt, backing.INST_x25);
  INST_x26.dump_VCD(dt, backing.INST_x26);
  INST_x27.dump_VCD(dt, backing.INST_x27);
  INST_x28.dump_VCD(dt, backing.INST_x28);
  INST_x29.dump_VCD(dt, backing.INST_x29);
  INST_x3.dump_VCD(dt, backing.INST_x3);
  INST_x30.dump_VCD(dt, backing.INST_x30);
  INST_x31.dump_VCD(dt, backing.INST_x31);
  INST_x4.dump_VCD(dt, backing.INST_x4);
  INST_x5.dump_VCD(dt, backing.INST_x5);
  INST_x6.dump_VCD(dt, backing.INST_x6);
  INST_x7.dump_VCD(dt, backing.INST_x7);
  INST_x8.dump_VCD(dt, backing.INST_x8);
  INST_x9.dump_VCD(dt, backing.INST_x9);
}
