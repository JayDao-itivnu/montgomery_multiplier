behavior:
	vsim -c -do behavioral_sim.do -l run.log
postsyn:
	vsim -c -do postsyn_sim.do -l run-postsyn.log 

.PHONY: clean
clean:
	rm -rf *.log transcript work 
	
