# Simple script to automate the verification process
# Delete the previous work
# vdel -lib work aes_tb
#------------------------------------------------------------------------------
#    Project directory settings (Put your actual directory paths here)
#------------------------------------------------------------------------------
set proj_dir ".."
set design_name "montgomery_multiplier"
set sim_dir "$proj_dir/sim"
set rtl_dir "$proj_dir/src"
set tb_dir "$proj_dir/tb"

vlib work
vlog /home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog/NangateOpenCellLibrary.v 
#------------------------------------------------------------------------------
#    Compile post-synthesis netlist and TB modules
#------------------------------------------------------------------------------
vlog ../syn/results/${design_name}.mapped.v
vcom -2008 -work work $tb_dir/*.vhd

#vsim -t 1ps -voptargs=+acc -wlf $(VSIM_WLF_FILE) -sdfmax /tb_lif_neuron/dut/=../syn/output/lif_neuron.sdf tb_lif_neuron -c -do "log -r /*; power add tb_lif_neuron/dut/*; run -a;power report -all -bsaif lif_neuron.saif; exit"


#------------------------------------------------------------------------------
#    Simulation
#------------------------------------------------------------------------------
vsim -onfinish stop -t 1ps +notimingcheck -sdfmax /tb_montgomery_multiplier/uut=../syn/results/${design_name}.mapped.sdf +sdf_verbose work.tb_montgomery_multiplier -do " log -r /*;power add tb_montgomery_multiplier/uut/*; run -a; power report -all -b saif montgomery_multiplier.saif; exit"
