#################################################################################
# PrimeTime Reference Methodology Script
# Script: pt.tcl
# Version: K-2015.06 (July 13, 2015)
# Copyright (C) 2008-2015 Synopsys All rights reserved.
################################################################################



# Please do not modify the sdir variable.
# Doing so may cause script to fail.
set PROJECT_DIR                   $env(PROJECT_DIR)  ;# root path of the project
                                                      # all the synthesis scripts are in ${PROJECT_DIR)/ptpx
set sdir "${PROJECT_DIR}/ptpx"



##################################################################
#    Source common and pt_setup.tcl File                         #
##################################################################

source ${sdir}/rm_setup/common_setup.tcl
source ${sdir}/rm_setup/pt_setup.tcl

set REPORTS_DIR ${sdir}/reports 
file mkdir ${REPORTS_DIR}

set RESULTS_DIR ${sdir}/results
file mkdir ${RESULTS_DIR}



##################################################################
#    Search Path, Library and Operating Condition Section        #
##################################################################

# Under normal circumstances, when executing a script with source, Tcl
# errors (syntax and semantic) cause the execution of the script to terminate.
# Uncomment the following line to set sh_continue_on_error to true to allow 
# processing to continue when errors occur.
#set sh_continue_on_error true 


  
set power_enable_analysis true 
set power_enable_multi_rail_analysis true 
#set power_analysis_mode time_based 

set report_default_significant_digits 3 ;
set sh_source_uses_search_path true ;
set search_path ". $search_path" ;

##################################################################
#    Netlist Reading Section                                     #
##################################################################
set link_path "* $link_path"
read_verilog ${DESIGN_NETLIST}

current_design $DESIGN_NAME 
link


##################################################################
#    Back Annotation Section                                     #
##################################################################
if { [info exists SDF_PATHS] && [info exists SDF_FILES] } {
foreach sdf_path $SDF_PATHS sdf_file $SDF_FILES {
   if {[string compare $sdf_path $DESIGN_NAME] == 0} {
      read_sdf -analysis_type on_chip_variation $sdf_file
   } else {
      read_sdf -path $sdf_path -analysis_type on_chip_variation $sdf_file
   }
}
report_annotated_delay > $REPORTS_DIR/${DESIGN_NAME}_report_annotated_delay.report
}



##################################################################
#    Reading Constraints Section                                 #
##################################################################
if  {[info exists CONSTRAINT_FILES]} {
        foreach constraint_file $CONSTRAINT_FILES {
                if {[file extension $constraint_file] eq ".sdc"} {
                        read_sdc -echo $constraint_file
                } else {
                        source -echo $constraint_file
                }
        }
}

##################################################################
#    Update_timing and check_timing Section                      #
##################################################################

update_timing -full
check_timing -verbose > $REPORTS_DIR/${DESIGN_NAME}_check_timing.report


##################################################################
#    Report_timing Section                                       #
##################################################################
report_global_timing > $REPORTS_DIR/${DESIGN_NAME}_report_global_timing.report
report_clock -skew -attribute > $REPORTS_DIR/${DESIGN_NAME}_report_clock.report 
report_analysis_coverage > $REPORTS_DIR/${DESIGN_NAME}_report_analysis_coverage.report
report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net  > $REPORTS_DIR/${DESIGN_NAME}_report_timing.report


##################################################################  
#    Power Switching Activity Annotation Section                 #  
##################################################################  
read_saif $ACTIVITY_FILE -strip_path $STRIP_PATH         
report_switching_activity -list_not_annotated           

##################################################################
#    Power Analysis Section                                      #
##################################################################

## set power analysis options                                   
#set_power_analysis_options -waveform_format fsdb -waveform_output $REPORTS_DIR/${DESIGN_NAME}

## run power analysis
check_power   > $REPORTS_DIR/${DESIGN_NAME}_check_power.report
update_power  

## report_power
report_power > $REPORTS_DIR/${DESIGN_NAME}_report_power.report


# Clock Gating & Vth Group Reporting Section
report_clock_gate_savings  

# Set Vth attribute for each library if not set already
foreach_in_collection l [get_libs] {
        if {[get_attribute [get_lib $l] default_threshold_voltage_group] == ""} {
                set lname [get_object_name [get_lib $l]]
                set_user_attribute [get_lib $l] default_threshold_voltage_group $lname -class lib
        }
}
report_power -threshold_voltage_group > $REPORTS_DIR/${DESIGN_NAME}_pwr.per_lib_leakage
report_threshold_voltage_group > $REPORTS_DIR/${DESIGN_NAME}_pwr.per_volt_threshold_group

exit











