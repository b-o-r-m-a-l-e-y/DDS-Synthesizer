###############################################################################
#
# ICARUS VERILOG & GTKWAVE MAKEFILE
# MADE BY WILLIAM GIBB FOR HACDC
# williamgibb@gmail.com
# 
# USE THE FOLLOWING COMMANDS WITH THIS MAKEFILE
#	"make check" - compiles your verilog design - good for checking code
#	"make simulate" - compiles your design+TB & simulates your design
#	"make display" - compiles, simulates and displays waveforms
# 
###############################################################################
#
# CHANGE THESE THREE LINES FOR YOUR DESIGN
#
#TOOL INPUT
SRC = nco.v
TB = nco_tb.v

all:
	iverilog -o tb.out $(TB)
	vvp -lxt tb.out

check:
	iverilog -v $(TB) 

display:
	iverilog -o tb.out $(TB)
	vvp -lxt tb.out
	gtkwave out.vcd &

clean:
	rm -rf *.out *.vcd *.vvp