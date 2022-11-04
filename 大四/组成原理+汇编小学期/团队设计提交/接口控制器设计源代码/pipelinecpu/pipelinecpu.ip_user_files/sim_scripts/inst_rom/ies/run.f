-makelib ies_lib/xpm -sv \
  "E:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/dist_mem_gen_v8_0_13 \
  "../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../pipelinecpu.srcs/sources_1/new/ip/inst_rom/sim/inst_rom.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

