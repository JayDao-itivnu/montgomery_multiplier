puts "RM-Info: Running script [info script]\n"
### Start of PrimeTime Runtime Variables ###

##########################################################################################
# PrimeTime Variables PrimeTime Reference Methodology script
# Script: pt_setup.tcl
# Version: K-2015.06 (July 13, 2015)
# Copyright (C) 2008-2015 Synopsys All rights reserved.
##########################################################################################


######################################
# Report and Results Directories
######################################


set REPORTS_DIR "reports"
set RESULTS_DIR "results"


######################################
# Library and Design Setup
######################################

### Mode : Generic

set search_path ". $ADDITIONAL_SEARCH_PATH $search_path"
set target_library $TARGET_LIBRARY_FILES
set link_path "* $target_library $ADDITIONAL_LINK_LIB_FILES"

# Provide list of Verilog netlist files. It can be compressed --- example "A.v B.v C.v"
set NETLIST_FILES               ""
# DESIGN_NAME is checked for existence from common_setup.tcl
if {[string length $DESIGN_NAME] > 0} {
} else {
set DESIGN_NAME                   ""  ;#  The name of the top-level design
}




#######################################
# Non-DMSA Power Analysis Setup Section
#######################################

# switching activity (VCD/SAIF) file 
set ACTIVITY_FILE "${DESIGN_SAIF_FILE}"

# strip_path setting for the activity file
set STRIP_PATH "${DESIGN_INSTANCE_PATH}"

## name map file
set NAME_MAP_FILE ""





######################################
# Back Annotation File Section
######################################
# The path (instance name) and name of the SDF file --- example "top.sdf A.sdf" 
# Each SDF_PATH entry corresponds to the related SDF_FILE for the specific block"   
# For toplevel SDF file please use the toplevel design name in SDF_PATHS variable."   
set SDF_FILES	 "${DESIGN_SDF_FILE}"  
set SDF_PATHS	 "${DESIGN_NAME}"  

######################################
# Constraint Section Setup
######################################
set CONSTRAINT_FILES     "${DESIGN_CONSTRAINT_FILE}"  
######################################
# End
######################################

### End of PrimeTime Runtime Variables ###
puts "RM-Info: Completed script [info script]\n"