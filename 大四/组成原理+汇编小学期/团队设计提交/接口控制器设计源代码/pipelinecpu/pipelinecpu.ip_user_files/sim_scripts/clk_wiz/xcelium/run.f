-makelib xcelium_lib/xpm -sv \
  "E:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "E:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../pipelinecpu.srcs/sources_1/new/ip/clk_wiz/clk_wiz_clk_wiz.v" \
  "../../../../pipelinecpu.srcs/sources_1/new/ip/clk_wiz/clk_wiz.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

