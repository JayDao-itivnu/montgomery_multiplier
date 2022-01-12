# Simple script to automate the verification process

#------------------------------------------------------------------------------
#    Project directory settings (Put your actual directory paths here)
#------------------------------------------------------------------------------
set proj_dir ".."
set sim_dir "$proj_dir/sim"
set rtl_dir "$proj_dir/rtl"
set tb_dir "$proj_dir/tb"

vlib work

#------------------------------------------------------------------------------
#    Compile RTL and TB modules
#------------------------------------------------------------------------------
vcom -2008 -work work $rtl_dir/montgomery_mult.vhd			

vcom -2008 -work work $tb_dir/tb_package.vhd
vcom -2008 -work work $tb_dir/test_montg_mult.vhd
#------------------------------------------------------------------------------
#    Simulation
#------------------------------------------------------------------------------
vsim work.test_montgomery_mult_vhd

run 200 ms
quit
