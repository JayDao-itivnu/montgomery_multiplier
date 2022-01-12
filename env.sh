# Author: Manh-Hiep DAO <manh-hiep.dao@lcis.grenoble-inp.fr>
#
# Environment variables to be used in the reference flow
# These variable must be set correctly before running the reference flow scripts
# ----------------------------------------------------------------
# TOOL SETUPS
# ----------------------------------------------------------------
source /home/tools/synopsys/env.sh
source /home/tools/mentor/env.sh
export PROJECT_DIR=`pwd`
export SIM_DIR="${PROJECT_DIR}/sim"
export SYN_DIR="${PROJECT_DIR}/syn"
# Environment variable
#	SYNOPSYS_HOME=""
#	MENTOR_HOME=""
#	MODELSIM_HOME="
#	DESIGN_KIT_PATH=""
export DESIGN_KIT_PATH=/home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db
# ----------------------------------------------------------------
# DESIGN SETUP
# ----------------------------------------------------------------
#Critical ENV
# defining the clock period in ns
export CLOCK_PERIOD=100

# Design name to be synthesized (should match the top entity name)
export DESIGN_NAME=montgomery_multiplier

## technology lib type: possible value: NLDM, ECSM, CCS for FreePDK45nm
## recommended to use LVT for low-power design
export PDK_LIB_TYPE="NLDM"
#export PDK_LIB_TYPE="ECSM"
#export PDK_LIB_TYPE="CCS"
export DESIGN_KIT_PATH=$DESIGN_KIT_PATH/${PDK_LIB_TYPE}
# For post-synthesis simulation & power estimation
export DESIGN_NETLIST="${PROJECT_DIR}/syn/netlist/${DESIGN_NAME}.v"

export DESIGN_VCD_FILE="${SIM_DIR}/${DESIGN_NAME}.vcd.gz"

export DESIGN_INSTANCE_PATH="/aes_tb/uut"
export DESIGN_SDF_FILE="${PROJECT_DIR}/syn/netlist/${DESIGN_NAME}.sdf"
export DESIGN_CONSTRAINT_FILE="${DESIGN_NAME}.sdc"
# ------------------------------------------------------------------------------

# ----------------------------------------------------------------
# CHECK setups/ENV 
# ----------------------------------------------------------------
# If a $1 does not exist, set to $2
function env_non_exist_use_default() {
	cmd="if [[ -z \$$1 ]]; then
		echo -e \"\033[0;33mWarn\033[0m: $1: No such environment variable\";
		echo -e \"Setting to default: $1=$2\";
		export $1=$2;
	fi"
	eval $cmd

}
# If ENV does not exist, return error
function envs_non_exist_return_error() {
	for args
	do
		cmd="if [[ -z \$$args ]]; then
			echo -e \"\033[0;31mError\033[0m: $args: No such environment variable\";
		fi"
		eval $cmd
	done
}
function check_file_dir_exist() {
	for args
	do
		if [[ ! -d "${args}" && ! -e "${args}"  ]]; then
			echo -e "\033[0;31mError\033[0m: ${args}: No such file or directory"
		fi
	done
}
# ------------------------------------------------------------------------------

# env_non_exist_use_default "SYNOPSYS_HOME" "/home/apps/synopsys"

# env_non_exist_use_default "MENTOR_HOME" "/home/apps/mentor"

# check_file_dir_exist ${SYNOPSYS_HOME} \
	${MENTOR_HOME}

# source ${SYNOPSYS_HOME}/synopsys.sh
# source ${MENTOR_HOME}/env.sh

env_non_exist_use_default "DESIGN_KIT_PATH" \
	"/home/dkit/synopsys/SAED32_EDK/lib/stdcell_rvt/db_nldm"


# Return result ----------------------------------------------------------------
echo "
-------------------------------------------------------------------------
PROJECT PARAMETERs
-------------------------------------------------------------------------
Project directory    = ${PROJECT_DIR}
DESIGN_KIT_PATH      = ${DESIGN_KIT_PATH}
DESIGN_NAME          = ${DESIGN_NAME}
CLOCK_PERIOD         = ${CLOCK_PERIOD}
-------------------------------------------------------------------------
"
