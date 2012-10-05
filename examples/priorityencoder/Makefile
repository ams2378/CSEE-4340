DUV=priorityencoder
TEST=priorityencoder_test
BENCH=testbench.exe

all: 
	make clean
	make test
	make gtkwave

test:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV).sv $(TEST).sv -o $(BENCH)
	./$(BENCH)
	
view:
	dve -full64 -vpd vcdplus.vpd &
	
gtkwave:
	vcs -vpd2vcd vcdplus.vpd waveform.vcd
	gtkwave waveform.vcd &

leda:
	leda -full64 -sverilog -top $(DUV) $(DUV).sv
	
clean:
	rm -rf csrc *.exe.daidir *.exe *.log *.inf .leda_work *.key *.vpd *.vcd DVEfiles
