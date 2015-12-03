#define clock
netlist clock clk -period 10

# constrain reset
formal netlist constraint rst 1'b1
formal netlist constraint flush_in_valid 1'b0

# one synchronous request in flight at a time
formal netlist constraint way_out_ready 1'b1
formal netlist constraint state_out_ready 1'b1
formal netlist constraint inv_ack_cnt_out_ready 1'b1
