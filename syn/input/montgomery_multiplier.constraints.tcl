## create constraints
## set_operating_conditions -min BEST -max BEST
set_load 0.1  [all_outputs]
set_max_capacitance 1.5 [all_outputs]
set_max_transition 1.5 [all_inputs] 
set time_scale  2
set tran [expr (0.05*$time_scale)]
set delay_in [expr (0.6*$time_scale)]
set delay_out_min [expr (0.6*$time_scale)]

#set delay_out_max [expr (0.5*$time_scale)]

create_clock -period 100 {clock}  
set_clock_uncertainty $tran clock
set_clock_latency $tran clock
set_clock_transition $tran clock

set_input_delay $delay_in [all_inputs] -clock clock
set_output_delay $delay_out_min [all_outputs] -clock clock 

