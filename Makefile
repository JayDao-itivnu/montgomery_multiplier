test_gen:
	sage sage/${DESIGN_NAME}.sage

syn:
	dc_shell -64 -f ${SYN_DIR}/rm_dc_scripts/dc.tcl 2>&1 | tee ${SYN_DIR}/run_syn.${DESIGN_NAME}.`date +%Y-%m-%d-%H%M%S`.log

pnr:
	vsim -c -do sim.do -l run-gatesim.log 
.PHONY: clean
clean:
	rm -rf ${SYN_DIR}/*.log
	rm -rf ${SYN_DIR}/reports ${SYN_DIR}/results ${SYN_DIR}/WORK	
