TOP=top.sv
SUBINTERFACES=../address_gen/interface.sv ../arbiter/interface.sv ../counter/interface.sv ../fcc/interface.sv ../fcu/interface.sv ../inputbuffers/interface.sv ../queue/interface.sv ../xbar/interface.sv ../FF/interface.sv
INTERFACE=interface.sv
BENCH=bench.sv
SUBMODS=../../src/address_gen.sv ../../src/arbiter.sv ../../src/counter.sv ../../src/fcc.sv ../../src/fcu.sv ../../src/queue.sv ../../src/inputbuffers.sv ../../src/xbar.sv ../../src/FF.sv
DUT=../../src/router.sv

.PHONY: help

help:
	@echo "The following make targets are supported:" ;\
	echo " bench  - builds the testbench";\
        echo " wave   - convert vcd to vpd";\
	echo " expand - expands veritedium directives (autoargs, inst etc.)";\
	echo " indent - automatically indents verilog and c files" ;\
	echo " clean  - cleans testbench and intermediate files" ;\
	echo " help   - show this information";\


indent:
	emacs --batch *.sv -f verilog-batch-indent
	indent -linux *.c *.h
	rm *~

dut:  
	vcs -full64 -PP -sverilog +define+SV +define+VPD +lint=all,noVCDE -notice $(INTERFACE) $(DUT) 

test: 
	vcs -PP -sverilog +define+SV +define+VPD $(SUBINTERFACES) $(INTERFACE) $(BENCH)

bench: 
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(TOP) $(SUBINTERFACES) $(INTERFACE) $(SUBMODS) $(DUT) $(BENCH) -o testbench.exe
        
wave:
	vcs -vpd2vcd vcdplus.vpd waveform.vcd
	gtkwave waveform.vcd &

clean:
	rm -rf *.o *~ *.vpd sim* csrc DVEfiles *daidir *exe *.key

