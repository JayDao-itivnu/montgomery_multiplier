## create directory for work library
file mkdir WORK
define_design_lib work -path ./WORK

## read the verilog files
analyze -library WORK -format vhd  ${PROJECT_DIR}/src/${DESIGN_NAME}.vhd

elaborate -library WORK ${DESIGN_NAME} 
