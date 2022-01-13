puts "RM-Info: Running script [info script]\n"

##########################################################################################
# Variables common to all reference methodology scripts
# Script: common_setup.tcl
# Version: K-2015.06 (July 13, 2015)
# Copyright (C) 2007-2015 Synopsys, Inc. All rights reserved.
##########################################################################################

#set DESIGN_NAME                   $env(DESIGN_NAME)  ;#  The name of the top-level design
set DESIGN_SAIF_FILE               $env(DESIGN_SAIF_FILE)
set DESIGN_INSTANCE_PATH          $env(DESIGN_INSTANCE_PATH)
set DESIGN_SDF_FILE               $env(DESIGN_SDF_FILE)
set DESIGN_CONSTRAINT_FILE        $env(DESIGN_CONSTRAINT_FILE)
set DESIGN_NETLIST                $env(DESIGN_NETLIST)

## using the same file as synthesis
source ${PROJECT_DIR}/common/rm_setup/common_setup.tcl