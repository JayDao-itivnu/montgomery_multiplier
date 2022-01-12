# Simple script to automate the verification process

#------------------------------------------------------------------------------
#    Project directory settings (Put your actual directory paths here)
#------------------------------------------------------------------------------
set proj_dir ".."
set sim_dir "$proj_dir/sim"
set rtl_dir "$proj_dir/src"
set tb_dir "$proj_dir/tb"

vlib work

#------------------------------------------------------------------------------
#    Compile RTL and TB modules
#------------------------------------------------------------------------------
vcom -2008 -work work $rtl_dir/*.vhd			

vcom -2008 -work work $tb_dir/*.vhd
#------------------------------------------------------------------------------
#    Simulation
#------------------------------------------------------------------------------
vsim work.tb_montgomery_multiplier

run 200 ms
quit
