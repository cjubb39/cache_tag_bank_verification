#define clock
netlist clock clk -period 10

# constrain reset
formal netlist constraint rst 1'b1

# one synchronous request in flight at a time
formal netlist constraint way_out_ready 1'b1
formal netlist constraint state_out_ready 1'b1
formal netlist constraint inv_ack_cnt_out_ready 1'b1

formal netlist constraint set_out_evict_ready 1'b1
formal netlist constraint tag_out_evict_ready 1'b1
formal netlist constraint state_out_evict_ready 1'b1
