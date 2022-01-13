test_gen:
	sage sage/${DESIGN_NAME}.sage

syn:
	dc_shell -64 -f ${SYN_DIR}/rm_dc_scripts/dc.tcl 2>&1 | tee ${SYN_DIR}/run_syn.${DESIGN_NAME}.`date +%Y-%m-%d-%H%M%S`.log

.PHONY: ptpx
ptpx:
	export DESIGN_CONSTRAINT_FILE="${DESIGN_NAME}.mapped.sdc"
	grep -v 'sdc_version' "${PROJECT_DIR}/syn/results/${DESIGN_CONSTRAINT_FILE}" | \
    		grep -v 'set_unit'  > "${DESIGN_NAME}.mapped.sdc"
	
	pt_shell -f ${PT_DIR}/rm_pt_scripts/pt.tcl | tee ${PT_DIR}/pt.run.${DESIGN_NAME}.`date +%Y-%m-%d-%H%M%S`.log

pnr:
	vsim -c -do sim.do -l run-gatesim.log 
.PHONY: clean
clean:
	rm -rf ${SYN_DIR}/*.log
	rm -rf ${SYN_DIR}/reports ${SYN_DIR}/results ${SYN_DIR}/WORK	
