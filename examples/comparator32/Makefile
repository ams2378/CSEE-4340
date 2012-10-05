DUV4=comparator4
DUV16=comparator16
DUV=comparator32

TEST4=comparator4_test
TEST16=comparator16_test
TEST=comparator32_test

BENCH=testbench.exe


all: 
	make clean
	make test
	make gtkwave

duv4:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV4).sv -o $(BENCH)
	./$(BENCH)

test4:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV4).sv $(TEST4).sv -o $(BENCH)
	./$(BENCH)

duv16:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV4).sv $(DUV16).sv -o $(BENCH)
	./$(BENCH)

test16:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV4).sv $(DUV16).sv $(TEST16).sv -o $(BENCH)
	./$(BENCH)

duv:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV4).sv $(DUV16).sv $(DUV).sv -o $(BENCH)
	./$(BENCH)

test:
	vcs -full64 -PP -sverilog +define+SV +define+VPD $(DUV4).sv $(DUV16).sv $(DUV).sv $(TEST).sv -o $(BENCH)
	./$(BENCH)

view:
	dve -full64 -vpd vcdplus.vpd &

gtkwave:
	vcs -vpd2vcd vcdplus.vpd waveform.vcd
	gtkwave waveform.vcd &

leda:
	leda -full64 -sverilog -top $(DUV) $(DUV4).sv $(DUV16).sv $(DUV).sv
	
clean:
	rm -rf csrc *.exe.daidir *.exe *.log *.inf .leda_work *.key *.vpd *.vcd DVEfiles
