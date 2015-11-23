#define clock
netlist clock clk -period 100

# constrain reset
#formal netlist constraint rst 1'b1
formal netlist constraint flush_in_valid 1'b0
