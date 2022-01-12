set pro_dir ".."
set # Simple script to automate the verification process

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
vcom -work work $rtl_dir/*.vhd

vcom -work work $tb_dir/*.vhd

#------------------------------------------------------------------------------
#    Simulation
#------------------------------------------------------------------------------
vsim work.test_montgomery_mult_vhd
log -r /*
run 2 ms
quit
