# Environment variables to be used in the reference flow
# These variable must be set correctly before running the reference flow scripts
# Tools  setups ----------------------------------------------------------------
export PROJECT_DIR=`pwd`
# Environment variable
#	SYNOPSYS_HOME=""
#	MENTOR_HOME=""
#	MODELSIM_HOME="
#	DESIGN_KIT_PATH=""

#Critical ENV
# defining the clock period in ns
export CLOCK_PERIOD=100
# Design name to be synthesized (should match the top entity name)
export DESIGN_NAME=MontMul
export TB_DIR="${PROJECT_DIR}/tb"
# #technology lib type: possible value: NLDM, CCS, ECSM for Nandgate 45nm
## recommended to use CCS or NLDM
# export PDK_LIB_TYPE="NLDM"
# export PDK_LIB_TYPE="ECSM"
# export PDK_LIB_TYPE="CCS"

# For post-synthesis simulation & power estimation
export DESIGN_NETLIST="${PROJECT_DIR}/syn/netlist/${DESIGN_NAME}.v"
export DESIGN_VCD_FILE="${PROJECT_DIR}/sim/${DESIGN_NAME}.vcd.gz"
export DESIGN_INSTANCE_PATH="/aes_tb/uut"
export DESIGN_SDF_FILE="${PROJECT_DIR}/syn/netlist/${DESIGN_NAME}.sdf"
export DESIGN_CONSTRAINT_FILE="${DESIGN_NAME}.sdc"
# ------------------------------------------------------------------------------


# CHECK setups/ENV -------------------------------------------------------------
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

env_non_exist_use_default "SYNOPSYS_HOME" "/home/tools/synopsys"
#env_non_exist_use_default "SYNOPSYS_HOME" "/home/apps/synopsys"
export MENTOR_HOME="/home/tools/mentor/questasim/10.7c/questasim/bin"

check_file_dir_exist ${SYNOPSYS_HOME} \
	${MENTOR_HOME}

source ${SYNOPSYS_HOME}/synopsys.sh
source ${MENTOR_HOME}/env.sh

env_non_exist_use_default "DESIGN_KIT_PATH" \
	"/home/dkit/synopsys/SAED32_EDK/lib/stdcell_rvt/db_nldm"


# Return result ----------------------------------------------------------------
echo "
-------------------------------------------------------------------------
PROJECT PARAMETERs
-------------------------------------------------------------------------
Project directory    = ${PROJECT_DIR}
SYNOPSYS_HOME        = ${SYNOPSYS_HOME}
DESIGN_KIT_PATH      = ${DESIGN_KIT_PATH}
DESIGN_NAME          = ${DESIGN_NAME}
CLOCK_PERIOD         = ${CLOCK_PERIOD}
-------------------------------------------------------------------------
"

