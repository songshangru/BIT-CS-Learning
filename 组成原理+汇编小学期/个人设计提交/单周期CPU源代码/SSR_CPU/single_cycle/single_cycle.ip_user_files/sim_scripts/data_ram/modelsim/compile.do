vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/dist_mem_gen_v8_0_13
vlib modelsim_lib/msim/xil_defaultlib

vmap dist_mem_gen_v8_0_13 modelsim_lib/msim/dist_mem_gen_v8_0_13
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work dist_mem_gen_v8_0_13 -64 -incr \
"../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../../single_cycle.srcs/sources_1/new/ip/data_ram/sim/data_ram.v" \


vlog -work xil_defaultlib \
"glbl.v"

