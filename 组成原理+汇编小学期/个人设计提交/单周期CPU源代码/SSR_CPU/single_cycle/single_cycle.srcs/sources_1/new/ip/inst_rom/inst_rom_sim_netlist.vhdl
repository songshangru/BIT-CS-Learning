-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Sat Oct  2 14:25:26 2021
-- Host        : LAPTOP-MU8B2MRR running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/workplace/Vivado/SSRCPU/SSR_CPU/single_cycle/single_cycle.srcs/sources_1/new/ip/inst_rom/inst_rom_sim_netlist.vhdl
-- Design      : inst_rom
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity inst_rom_rom is
  port (
    spo : out STD_LOGIC_VECTOR ( 22 downto 0 );
    a : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of inst_rom_rom : entity is "rom";
end inst_rom_rom;

architecture STRUCTURE of inst_rom_rom is
  signal \spo[31]_INST_0_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \spo[0]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \spo[11]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \spo[13]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \spo[14]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \spo[16]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \spo[17]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \spo[19]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \spo[21]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \spo[22]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \spo[23]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \spo[24]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \spo[26]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \spo[27]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \spo[28]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \spo[29]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \spo[2]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \spo[31]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \spo[3]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \spo[4]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \spo[5]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \spo[6]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \spo[7]_INST_0\ : label is "soft_lutpair10";
begin
\spo[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1400C200"
    )
        port map (
      I0 => a(2),
      I1 => a(1),
      I2 => a(0),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(3),
      O => spo(0)
    );
\spo[11]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000700"
    )
        port map (
      I0 => a(1),
      I1 => a(2),
      I2 => a(0),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(3),
      O => spo(6)
    );
\spo[13]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004300"
    )
        port map (
      I0 => a(2),
      I1 => a(1),
      I2 => a(0),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(3),
      O => spo(7)
    );
\spo[14]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00004404"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      O => spo(8)
    );
\spo[16]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"40001700"
    )
        port map (
      I0 => a(2),
      I1 => a(3),
      I2 => a(1),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(0),
      O => spo(10)
    );
\spo[17]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"35002000"
    )
        port map (
      I0 => a(2),
      I1 => a(3),
      I2 => a(1),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(0),
      O => spo(11)
    );
\spo[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(2),
      O => spo(12)
    );
\spo[19]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"4F5F0000"
    )
        port map (
      I0 => a(2),
      I1 => a(0),
      I2 => a(3),
      I3 => a(1),
      I4 => \spo[31]_INST_0_i_1_n_0\,
      O => spo(13)
    );
\spo[21]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"42003500"
    )
        port map (
      I0 => a(2),
      I1 => a(3),
      I2 => a(1),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(0),
      O => spo(14)
    );
\spo[22]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000888"
    )
        port map (
      I0 => a(0),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(1),
      I3 => a(3),
      I4 => a(2),
      O => spo(15)
    );
\spo[23]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44400000"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      O => spo(16)
    );
\spo[24]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"4F5D0000"
    )
        port map (
      I0 => a(2),
      I1 => a(0),
      I2 => a(3),
      I3 => a(1),
      I4 => \spo[31]_INST_0_i_1_n_0\,
      O => spo(17)
    );
\spo[26]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00203020"
    )
        port map (
      I0 => a(2),
      I1 => a(3),
      I2 => \spo[31]_INST_0_i_1_n_0\,
      I3 => a(0),
      I4 => a(1),
      O => spo(18)
    );
\spo[27]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00602020"
    )
        port map (
      I0 => a(2),
      I1 => a(3),
      I2 => \spo[31]_INST_0_i_1_n_0\,
      I3 => a(0),
      I4 => a(1),
      O => spo(19)
    );
\spo[28]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"40040000"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      O => spo(20)
    );
\spo[29]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"405F0000"
    )
        port map (
      I0 => a(2),
      I1 => a(0),
      I2 => a(3),
      I3 => a(1),
      I4 => \spo[31]_INST_0_i_1_n_0\,
      O => spo(21)
    );
\spo[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000802A"
    )
        port map (
      I0 => \spo[31]_INST_0_i_1_n_0\,
      I1 => a(3),
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      O => spo(1)
    );
\spo[31]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04400000"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      O => spo(22)
    );
\spo[31]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => a(6),
      I1 => a(4),
      I2 => a(8),
      I3 => a(9),
      I4 => a(5),
      I5 => a(7),
      O => \spo[31]_INST_0_i_1_n_0\
    );
\spo[3]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000804"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(0),
      I3 => a(1),
      I4 => a(2),
      O => spo(2)
    );
\spo[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => a(1),
      I1 => a(0),
      I2 => \spo[31]_INST_0_i_1_n_0\,
      I3 => a(3),
      I4 => a(2),
      O => spo(3)
    );
\spo[5]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00008C48"
    )
        port map (
      I0 => a(0),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(3),
      I3 => a(1),
      I4 => a(2),
      O => spo(4)
    );
\spo[6]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"41001200"
    )
        port map (
      I0 => a(2),
      I1 => a(1),
      I2 => a(3),
      I3 => \spo[31]_INST_0_i_1_n_0\,
      I4 => a(0),
      O => spo(5)
    );
\spo[7]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => a(3),
      I1 => \spo[31]_INST_0_i_1_n_0\,
      I2 => a(0),
      I3 => a(1),
      O => spo(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity inst_rom_dist_mem_gen_v8_0_13_synth is
  port (
    spo : out STD_LOGIC_VECTOR ( 22 downto 0 );
    a : in STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of inst_rom_dist_mem_gen_v8_0_13_synth : entity is "dist_mem_gen_v8_0_13_synth";
end inst_rom_dist_mem_gen_v8_0_13_synth;

architecture STRUCTURE of inst_rom_dist_mem_gen_v8_0_13_synth is
begin
\gen_rom.rom_inst\: entity work.inst_rom_rom
     port map (
      a(9 downto 0) => a(9 downto 0),
      spo(22 downto 0) => spo(22 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity inst_rom_dist_mem_gen_v8_0_13 is
  port (
    a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    d : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 31 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 31 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of inst_rom_dist_mem_gen_v8_0_13 : entity is 10;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of inst_rom_dist_mem_gen_v8_0_13 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of inst_rom_dist_mem_gen_v8_0_13 : entity is 1024;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of inst_rom_dist_mem_gen_v8_0_13 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst_rom_dist_mem_gen_v8_0_13 : entity is "artix7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of inst_rom_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of inst_rom_dist_mem_gen_v8_0_13 : entity is "inst_rom.mif";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of inst_rom_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of inst_rom_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of inst_rom_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of inst_rom_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of inst_rom_dist_mem_gen_v8_0_13 : entity is 32;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of inst_rom_dist_mem_gen_v8_0_13 : entity is "dist_mem_gen_v8_0_13";
end inst_rom_dist_mem_gen_v8_0_13;

architecture STRUCTURE of inst_rom_dist_mem_gen_v8_0_13 is
  signal \<const0>\ : STD_LOGIC;
  signal \^spo\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  dpo(31) <= \<const0>\;
  dpo(30) <= \<const0>\;
  dpo(29) <= \<const0>\;
  dpo(28) <= \<const0>\;
  dpo(27) <= \<const0>\;
  dpo(26) <= \<const0>\;
  dpo(25) <= \<const0>\;
  dpo(24) <= \<const0>\;
  dpo(23) <= \<const0>\;
  dpo(22) <= \<const0>\;
  dpo(21) <= \<const0>\;
  dpo(20) <= \<const0>\;
  dpo(19) <= \<const0>\;
  dpo(18) <= \<const0>\;
  dpo(17) <= \<const0>\;
  dpo(16) <= \<const0>\;
  dpo(15) <= \<const0>\;
  dpo(14) <= \<const0>\;
  dpo(13) <= \<const0>\;
  dpo(12) <= \<const0>\;
  dpo(11) <= \<const0>\;
  dpo(10) <= \<const0>\;
  dpo(9) <= \<const0>\;
  dpo(8) <= \<const0>\;
  dpo(7) <= \<const0>\;
  dpo(6) <= \<const0>\;
  dpo(5) <= \<const0>\;
  dpo(4) <= \<const0>\;
  dpo(3) <= \<const0>\;
  dpo(2) <= \<const0>\;
  dpo(1) <= \<const0>\;
  dpo(0) <= \<const0>\;
  qdpo(31) <= \<const0>\;
  qdpo(30) <= \<const0>\;
  qdpo(29) <= \<const0>\;
  qdpo(28) <= \<const0>\;
  qdpo(27) <= \<const0>\;
  qdpo(26) <= \<const0>\;
  qdpo(25) <= \<const0>\;
  qdpo(24) <= \<const0>\;
  qdpo(23) <= \<const0>\;
  qdpo(22) <= \<const0>\;
  qdpo(21) <= \<const0>\;
  qdpo(20) <= \<const0>\;
  qdpo(19) <= \<const0>\;
  qdpo(18) <= \<const0>\;
  qdpo(17) <= \<const0>\;
  qdpo(16) <= \<const0>\;
  qdpo(15) <= \<const0>\;
  qdpo(14) <= \<const0>\;
  qdpo(13) <= \<const0>\;
  qdpo(12) <= \<const0>\;
  qdpo(11) <= \<const0>\;
  qdpo(10) <= \<const0>\;
  qdpo(9) <= \<const0>\;
  qdpo(8) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  qspo(31) <= \<const0>\;
  qspo(30) <= \<const0>\;
  qspo(29) <= \<const0>\;
  qspo(28) <= \<const0>\;
  qspo(27) <= \<const0>\;
  qspo(26) <= \<const0>\;
  qspo(25) <= \<const0>\;
  qspo(24) <= \<const0>\;
  qspo(23) <= \<const0>\;
  qspo(22) <= \<const0>\;
  qspo(21) <= \<const0>\;
  qspo(20) <= \<const0>\;
  qspo(19) <= \<const0>\;
  qspo(18) <= \<const0>\;
  qspo(17) <= \<const0>\;
  qspo(16) <= \<const0>\;
  qspo(15) <= \<const0>\;
  qspo(14) <= \<const0>\;
  qspo(13) <= \<const0>\;
  qspo(12) <= \<const0>\;
  qspo(11) <= \<const0>\;
  qspo(10) <= \<const0>\;
  qspo(9) <= \<const0>\;
  qspo(8) <= \<const0>\;
  qspo(7) <= \<const0>\;
  qspo(6) <= \<const0>\;
  qspo(5) <= \<const0>\;
  qspo(4) <= \<const0>\;
  qspo(3) <= \<const0>\;
  qspo(2) <= \<const0>\;
  qspo(1) <= \<const0>\;
  qspo(0) <= \<const0>\;
  spo(31) <= \^spo\(31);
  spo(30) <= \<const0>\;
  spo(29 downto 26) <= \^spo\(29 downto 26);
  spo(25) <= \<const0>\;
  spo(24 downto 21) <= \^spo\(24 downto 21);
  spo(20) <= \<const0>\;
  spo(19 downto 16) <= \^spo\(19 downto 16);
  spo(15) <= \^spo\(7);
  spo(14 downto 13) <= \^spo\(14 downto 13);
  spo(12) <= \^spo\(11);
  spo(11) <= \^spo\(11);
  spo(10) <= \^spo\(7);
  spo(9) <= \^spo\(7);
  spo(8) <= \^spo\(7);
  spo(7 downto 2) <= \^spo\(7 downto 2);
  spo(1) <= \<const0>\;
  spo(0) <= \^spo\(0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.inst_rom_dist_mem_gen_v8_0_13_synth
     port map (
      a(9 downto 0) => a(9 downto 0),
      spo(22) => \^spo\(31),
      spo(21 downto 18) => \^spo\(29 downto 26),
      spo(17 downto 14) => \^spo\(24 downto 21),
      spo(13 downto 10) => \^spo\(19 downto 16),
      spo(9) => \^spo\(7),
      spo(8 downto 7) => \^spo\(14 downto 13),
      spo(6) => \^spo\(11),
      spo(5 downto 1) => \^spo\(6 downto 2),
      spo(0) => \^spo\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity inst_rom is
  port (
    a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of inst_rom : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of inst_rom : entity is "inst_rom,dist_mem_gen_v8_0_13,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of inst_rom : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of inst_rom : entity is "dist_mem_gen_v8_0_13,Vivado 2019.2";
end inst_rom;

architecture STRUCTURE of inst_rom is
  signal NLW_U0_dpo_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 0;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 0;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 0;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of U0 : label is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 0;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 0;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of U0 : label is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of U0 : label is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of U0 : label is 0;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 0;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 10;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 1024;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_clk : integer;
  attribute c_has_clk of U0 : label is 0;
  attribute c_has_qspo : integer;
  attribute c_has_qspo of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_has_qspo_rst : integer;
  attribute c_has_qspo_rst of U0 : label is 0;
  attribute c_has_qspo_srst : integer;
  attribute c_has_qspo_srst of U0 : label is 0;
  attribute c_has_spo : integer;
  attribute c_has_spo of U0 : label is 1;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "inst_rom.mif";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 1;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 0;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 32;
begin
U0: entity work.inst_rom_dist_mem_gen_v8_0_13
     port map (
      a(9 downto 0) => a(9 downto 0),
      clk => '0',
      d(31 downto 0) => B"00000000000000000000000000000000",
      dpo(31 downto 0) => NLW_U0_dpo_UNCONNECTED(31 downto 0),
      dpra(9 downto 0) => B"0000000000",
      i_ce => '1',
      qdpo(31 downto 0) => NLW_U0_qdpo_UNCONNECTED(31 downto 0),
      qdpo_ce => '1',
      qdpo_clk => '0',
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(31 downto 0) => NLW_U0_qspo_UNCONNECTED(31 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(31 downto 0) => spo(31 downto 0),
      we => '0'
    );
end STRUCTURE;
