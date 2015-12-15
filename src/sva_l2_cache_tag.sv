module l2_cache_tag_checker_sva(
clk, rst, tag_in_valid, set_in_valid, 
state_in_valid, inv_ack_cnt_in_valid, 
flush_in_valid, flush_complete_ready, 
way_out_ready, state_out_ready, inv_ack_cnt_out_ready, tag_out_evict_ready, 
set_out_evict_ready, state_out_evict_ready, way_out_flush_ready, 
inv_ack_cnt_out_flush_ready, tag_out_flush_ready, set_out_flush_ready, 
state_out_flush_ready, 
tag_in_ready, set_in_ready, state_in_ready, 
inv_ack_cnt_in_ready, flush_in_ready, flush_complete_valid,
way_out_valid, state_out_valid,
inv_ack_cnt_out_valid, tag_out_evict_valid, 
set_out_evict_valid,
state_out_evict_valid, way_out_flush_valid, 
inv_ack_cnt_out_flush_valid,
tag_out_flush_valid, set_out_flush_valid,
state_out_flush_valid, mem_tag_CE0,
mem_tag_WE0, mem_tag_CE1, mem_tag_CE2, mem_tag_CE3, 
mem_tag_CE4, mem_tag_CE5, mem_tag_CE6, 
mem_tag_CE7, mem_tag_CE8, mem_state_CE0, 
mem_state_WE0, mem_state_CE1,
mem_state_CE2, mem_state_CE3, mem_state_CE4, 
mem_state_CE5, mem_state_CE6,
mem_state_CE7, mem_state_CE8, mem_inv_ack_cnt_CE0, 
mem_inv_ack_cnt_WE0, mem_inv_ack_cnt_CE1, 
mem_inv_ack_cnt_CE2, mem_inv_ack_cnt_CE3, 
mem_inv_ack_cnt_CE4, mem_inv_ack_cnt_CE5, 
mem_inv_ack_cnt_CE6, mem_inv_ack_cnt_CE7, 
mem_inv_ack_cnt_CE8);

input     clk, rst;
input     tag_in_valid, set_in_valid, state_in_valid, inv_ack_cnt_in_valid;
input     flush_in_valid, flush_complete_ready;
input     way_out_ready, state_out_ready, inv_ack_cnt_out_ready;
input     tag_out_evict_ready, set_out_evict_ready, state_out_evict_ready;
input     way_out_flush_ready, inv_ack_cnt_out_flush_ready, tag_out_flush_ready;
input     set_out_flush_ready, state_out_flush_ready;

input     tag_in_ready, set_in_ready, state_in_ready, inv_ack_cnt_in_ready;
input     flush_in_ready, flush_complete_valid;
input     way_out_valid, state_out_valid, inv_ack_cnt_out_valid;
input     tag_out_evict_valid, set_out_evict_valid, state_out_evict_valid;
input     way_out_flush_valid, inv_ack_cnt_out_flush_valid, tag_out_flush_valid;
input     set_out_flush_valid, state_out_flush_valid;

input     mem_tag_CE0, mem_tag_WE0;
input     mem_tag_CE1, mem_tag_CE2, mem_tag_CE3, mem_tag_CE4;
input     mem_tag_CE5, mem_tag_CE6, mem_tag_CE7, mem_tag_CE8;

input     mem_state_CE0, mem_state_WE0;
input     mem_state_CE1, mem_state_CE2, mem_state_CE3, mem_state_CE4;
input     mem_state_CE5, mem_state_CE6, mem_state_CE7, mem_state_CE8;

input     mem_inv_ack_cnt_CE0, mem_inv_ack_cnt_WE0;
input     mem_inv_ack_cnt_CE1, mem_inv_ack_cnt_CE2, mem_inv_ack_cnt_CE3, mem_inv_ack_cnt_CE4;
input     mem_inv_ack_cnt_CE5, mem_inv_ack_cnt_CE6, mem_inv_ack_cnt_CE7, mem_inv_ack_cnt_CE8;

default clocking c0 @(posedge clk); endclocking

/*
 * ASSUMPTIONS
 */

/* always ready for nominal request since there's a max of 1 in flight at a time */
tag_in_valid_fc_0:
  assume property (disable iff(!rst) $rose(tag_in_valid) |-> tag_in_ready);
set_in_valid_fc_0:
  assume property (disable iff(!rst) $rose(set_in_valid) |-> set_in_ready);
state_in_valid_fc_0:
  assume property (disable iff(!rst) $rose(state_in_valid) |-> state_in_ready);
inv_ack_cnt_in_valid_fc_0:
  assume property (disable iff(!rst) $rose(inv_ack_cnt_in_valid) |-> inv_ack_cnt_in_ready);

/* flex channel semantics */
tag_in_valid_fc_1:
  assume property (disable iff(!rst) tag_in_valid && tag_in_ready |=> !tag_in_valid);
set_in_valid_fc_1:
  assume property (disable iff(!rst) set_in_valid && set_in_ready |=> !set_in_valid);
state_in_valid_fc_1:
  assume property (disable iff(!rst) state_in_valid && state_in_ready |=> !state_in_valid);
inv_ack_cnt_in_valid_fc_1:
  assume property (disable iff(!rst) inv_ack_cnt_in_valid && inv_ack_cnt_in_ready |=> !inv_ack_cnt_in_valid);
flush_in_valid_fc_1:
  assume property (disable iff(!rst) flush_in_valid && flush_in_ready |=> !flush_in_valid);

/* come as a group */
nom_input_0:
  assume property (disable iff(!rst)
    (tag_in_valid || set_in_valid || state_in_valid || inv_ack_cnt_in_valid) |->
      (tag_in_valid && set_in_valid));

/* one request in flight at a time */
tag_in_valid_fc_2:
  assume property (disable iff(!rst) $fell(tag_in_valid) |-> !tag_in_valid[*] ##1 way_out_valid);
set_in_valid_fc_2:
  assume property (disable iff(!rst) $fell(set_in_valid) |-> !set_in_valid[*] ##1 way_out_valid);
state_in_valid_fc_2:
  assume property (disable iff(!rst) $fell(state_in_valid) |-> !state_in_valid[*] ##1 way_out_valid);
inv_ack_cnt_in_valid_fc_2:
  assume property (disable iff(!rst) $fell(inv_ack_cnt_in_valid) |-> !inv_ack_cnt_in_valid[*] ##1 way_out_valid);

/* state and inv_ack are optional so we condition also on tag */
state_in_valid_fc_3:
  assume property (disable iff(!rst) $fell(tag_in_valid) |-> !state_in_valid[*] ##1 way_out_valid);
inv_ack_cnt_in_valid_fc_3:
  assume property (disable iff(!rst) $fell(tag_in_valid) |-> !inv_ack_cnt_in_valid[*] ##1 way_out_valid);

/* one synchronous request in flight at a time */
way_out_valid_fc_0:
  assume property (disable iff(!rst) $rose(way_out_valid) |-> way_out_ready);
state_out_valid_fc_0:
  assume property (disable iff(!rst) $rose(state_out_valid) |-> state_out_ready);
inv_ack_cnt_out_valid_fc_0:
  assume property (disable iff(!rst) $rose(inv_ack_cnt_out_valid) |-> inv_ack_cnt_out_ready);

set_out_evict_valid_fc_0:
  assume property (disable iff(!rst) $rose(set_out_evict_valid) |-> set_out_evict_ready);
tag_out_evict_valid_fc_0:
  assume property (disable iff(!rst) $rose(tag_out_evict_valid) |-> tag_out_evict_ready);
state_out_evict_valid_fc_0:
  assume property (disable iff(!rst) $rose(state_out_evict_valid) |-> state_out_evict_ready);

/* flushes might build up because caching other things */
way_out_flush_valid_fc_0:
  assume property (disable iff(!rst) $rose(way_out_flush_valid) |-> ##[0:5] way_out_flush_ready);
set_out_flush_valid_fc_0:
  assume property (disable iff(!rst) $rose(set_out_flush_valid) |-> ##[0:5] set_out_flush_ready);
tag_out_flush_valid_fc_0:
  assume property (disable iff(!rst) $rose(tag_out_flush_valid) |-> ##[0:5] tag_out_flush_ready);
state_out_flush_valid_fc_0:
  assume property (disable iff(!rst) $rose(state_out_flush_valid) |-> ##[0:5] state_out_flush_ready);
inv_ack_cnt_out_flush_valid_fc_0:
  assume property (disable iff(!rst) $rose(inv_ack_cnt_out_flush_valid) |-> ##[0:5] inv_ack_cnt_out_flush_ready);


/* one flush in progress at a time */
flush_0:
  assume property (disable iff(!rst) $fell(flush_in_valid) |-> !flush_in_valid[*] ##1 flush_complete_valid);
flush_complete_valid_fc_0:
  assume property (disable iff(!rst) $rose(flush_complete_valid) |-> flush_complete_ready);

/*
 * BASIC COVERS
 */

/* DUT input covers */
//rst_cover_0: cover property (!rst);
rst_cover_1: cover property (rst);

tag_in_valid_cover_0: cover property (!tag_in_valid);
tag_in_valid_cover_1: cover property (tag_in_valid);
set_in_valid_cover_0: cover property (!set_in_valid);
set_in_valid_cover_1: cover property (set_in_valid);
state_in_valid_cover_0: cover property (!state_in_valid);
state_in_valid_cover_1: cover property (state_in_valid);
inv_ack_cnt_in_valid_cover_0: cover property (!inv_ack_cnt_in_valid);
inv_ack_cnt_in_valid_cover_1: cover property (inv_ack_cnt_in_valid);

flush_in_valid_cover_0: cover property (!flush_in_valid);
flush_in_valid_cover_1: cover property (flush_in_valid);
//flush_complete_ready_cover_0: cover property (!flush_complete_ready);
flush_complete_ready_cover_1: cover property (flush_complete_ready);

//way_out_ready_cover_0: cover property (!way_out_ready);
way_out_ready_cover_1: cover property (way_out_ready);
//state_out_ready_cover_0: cover property (!state_out_ready);
state_out_ready_cover_1: cover property (state_out_ready);
//inv_ack_cnt_out_ready_cover_0: cover property (!inv_ack_cnt_out_ready);
inv_ack_cnt_out_ready_cover_1: cover property (inv_ack_cnt_out_ready);

//tag_out_evict_ready_cover_0: cover property (!tag_out_evict_ready);
tag_out_evict_ready_cover_1: cover property (tag_out_evict_ready);
//set_out_evict_ready_cover_0: cover property (!set_out_evict_ready);
set_out_evict_ready_cover_1: cover property (set_out_evict_ready);
//state_out_evict_ready_cover_0: cover property (!state_out_evict_ready);
state_out_evict_ready_cover_1: cover property (state_out_evict_ready);

//way_out_flush_ready_cover_0: cover property (!way_out_flush_ready);
way_out_flush_ready_cover_1: cover property (way_out_flush_ready);
//tag_out_flush_ready_cover_0: cover property (!tag_out_flush_ready);
tag_out_flush_ready_cover_1: cover property (tag_out_flush_ready);
//set_out_flush_ready_cover_0: cover property (!set_out_flush_ready);
set_out_flush_ready_cover_1: cover property (set_out_flush_ready);
//state_out_flush_ready_cover_0: cover property (!state_out_flush_ready);
state_out_flush_ready_cover_1: cover property (state_out_flush_ready);
//inv_ack_cnt_out_flush_ready_cover_0: cover property (!inv_ack_cnt_out_flush_ready);
inv_ack_cnt_out_flush_ready_cover_1: cover property (inv_ack_cnt_out_flush_ready);

/* DUT output covers */
tag_in_ready_cover_0: cover property (!tag_in_ready);
tag_in_ready_cover_1: cover property (tag_in_ready);
set_in_ready_cover_0: cover property (!set_in_ready);
set_in_ready_cover_1: cover property (set_in_ready);
state_in_ready_cover_0: cover property (!state_in_ready);
state_in_ready_cover_1: cover property (state_in_ready);
inv_ack_cnt_in_ready_cover_0: cover property (!inv_ack_cnt_in_ready);
inv_ack_cnt_in_ready_cover_1: cover property (inv_ack_cnt_in_ready);

flush_in_ready_cover_0: cover property (!flush_in_ready);
flush_in_ready_cover_1: cover property (flush_in_ready);
flush_complete_valid_cover_0: cover property (!flush_complete_valid);
flush_complete_valid_cover_1: cover property (flush_complete_valid);

way_out_valid_cover_0: cover property (!way_out_valid);
way_out_valid_cover_1: cover property (way_out_valid);
state_out_valid_cover_0: cover property (!state_out_valid);
state_out_valid_cover_1: cover property (state_out_valid);
inv_ack_cnt_out_valid_cover_0: cover property (!inv_ack_cnt_out_valid);
inv_ack_cnt_out_valid_cover_1: cover property (inv_ack_cnt_out_valid);

tag_out_evict_valid_cover_0: cover property (!tag_out_evict_valid);
tag_out_evict_valid_cover_1: cover property (tag_out_evict_valid);
set_out_evict_valid_cover_0: cover property (!set_out_evict_valid);
set_out_evict_valid_cover_1: cover property (set_out_evict_valid);
state_out_evict_valid_cover_0: cover property (!state_out_evict_valid);
state_out_evict_valid_cover_1: cover property (state_out_evict_valid);

way_out_flush_valid_cover_0: cover property (!way_out_flush_valid);
way_out_flush_valid_cover_1: cover property (way_out_flush_valid);
tag_out_flush_valid_cover_0: cover property (!tag_out_flush_valid);
tag_out_flush_valid_cover_1: cover property (tag_out_flush_valid);
set_out_flush_valid_cover_0: cover property (!set_out_flush_valid);
set_out_flush_valid_cover_1: cover property (set_out_flush_valid);
state_out_flush_valid_cover_0: cover property (!state_out_flush_valid);
state_out_flush_valid_cover_1: cover property (state_out_flush_valid);
inv_ack_cnt_out_flush_valid_cover_0: cover property (!inv_ack_cnt_out_flush_valid);
inv_ack_cnt_out_flush_valid_cover_1: cover property (inv_ack_cnt_out_flush_valid);


/* memory covers */
mem_tag_CE0_cover_0: cover property (!mem_tag_CE0);
mem_tag_CE0_cover_1: cover property (mem_tag_CE0);
mem_tag_WE0_cover_0: cover property (!mem_tag_WE0);
mem_tag_WE0_cover_1: cover property (mem_tag_WE0);
mem_tag_CE1_cover_0: cover property (!mem_tag_CE1);
mem_tag_CE1_cover_1: cover property (mem_tag_CE1);
mem_tag_CE2_cover_0: cover property (!mem_tag_CE2);
mem_tag_CE2_cover_1: cover property (mem_tag_CE2);
mem_tag_CE3_cover_0: cover property (!mem_tag_CE3);
mem_tag_CE3_cover_1: cover property (mem_tag_CE3);
mem_tag_CE4_cover_0: cover property (!mem_tag_CE4);
mem_tag_CE4_cover_1: cover property (mem_tag_CE4);
mem_tag_CE5_cover_0: cover property (!mem_tag_CE5);
mem_tag_CE5_cover_1: cover property (mem_tag_CE5);
mem_tag_CE6_cover_0: cover property (!mem_tag_CE6);
mem_tag_CE6_cover_1: cover property (mem_tag_CE6);
mem_tag_CE7_cover_0: cover property (!mem_tag_CE7);
mem_tag_CE7_cover_1: cover property (mem_tag_CE7);
mem_tag_CE8_cover_0: cover property (!mem_tag_CE8);
mem_tag_CE8_cover_1: cover property (mem_tag_CE8);

mem_state_CE0_cover_0: cover property (!mem_state_CE0);
mem_state_CE0_cover_1: cover property (mem_state_CE0);
mem_state_WE0_cover_0: cover property (!mem_state_WE0);
mem_state_WE0_cover_1: cover property (mem_state_WE0);
mem_state_CE1_cover_0: cover property (!mem_state_CE1);
mem_state_CE1_cover_1: cover property (mem_state_CE1);
mem_state_CE2_cover_0: cover property (!mem_state_CE2);
mem_state_CE2_cover_1: cover property (mem_state_CE2);
mem_state_CE3_cover_0: cover property (!mem_state_CE3);
mem_state_CE3_cover_1: cover property (mem_state_CE3);
mem_state_CE4_cover_0: cover property (!mem_state_CE4);
mem_state_CE4_cover_1: cover property (mem_state_CE4);
mem_state_CE5_cover_0: cover property (!mem_state_CE5);
mem_state_CE5_cover_1: cover property (mem_state_CE5);
mem_state_CE6_cover_0: cover property (!mem_state_CE6);
mem_state_CE6_cover_1: cover property (mem_state_CE6);
mem_state_CE7_cover_0: cover property (!mem_state_CE7);
mem_state_CE7_cover_1: cover property (mem_state_CE7);
mem_state_CE8_cover_0: cover property (!mem_state_CE8);
mem_state_CE8_cover_1: cover property (mem_state_CE8);

mem_inv_ack_cnt_CE0_cover_0: cover property (!mem_inv_ack_cnt_CE0);
mem_inv_ack_cnt_CE0_cover_1: cover property (mem_inv_ack_cnt_CE0);
mem_inv_ack_cnt_WE0_cover_0: cover property (!mem_inv_ack_cnt_WE0);
mem_inv_ack_cnt_WE0_cover_1: cover property (mem_inv_ack_cnt_WE0);
mem_inv_ack_cnt_CE1_cover_0: cover property (!mem_inv_ack_cnt_CE1);
mem_inv_ack_cnt_CE1_cover_1: cover property (mem_inv_ack_cnt_CE1);
mem_inv_ack_cnt_CE2_cover_0: cover property (!mem_inv_ack_cnt_CE2);
mem_inv_ack_cnt_CE2_cover_1: cover property (mem_inv_ack_cnt_CE2);
mem_inv_ack_cnt_CE3_cover_0: cover property (!mem_inv_ack_cnt_CE3);
mem_inv_ack_cnt_CE3_cover_1: cover property (mem_inv_ack_cnt_CE3);
mem_inv_ack_cnt_CE4_cover_0: cover property (!mem_inv_ack_cnt_CE4);
mem_inv_ack_cnt_CE4_cover_1: cover property (mem_inv_ack_cnt_CE4);
mem_inv_ack_cnt_CE5_cover_0: cover property (!mem_inv_ack_cnt_CE5);
mem_inv_ack_cnt_CE5_cover_1: cover property (mem_inv_ack_cnt_CE5);
mem_inv_ack_cnt_CE6_cover_0: cover property (!mem_inv_ack_cnt_CE6);
mem_inv_ack_cnt_CE6_cover_1: cover property (mem_inv_ack_cnt_CE6);
mem_inv_ack_cnt_CE7_cover_0: cover property (!mem_inv_ack_cnt_CE7);
mem_inv_ack_cnt_CE7_cover_1: cover property (mem_inv_ack_cnt_CE7);
mem_inv_ack_cnt_CE8_cover_0: cover property (!mem_inv_ack_cnt_CE8);
mem_inv_ack_cnt_CE8_cover_1: cover property (mem_inv_ack_cnt_CE8);

/*
 * LATENCY CONSTRAINTS
 */
rsp_latency_0:
  assert property (disable iff(!rst)
    ($rose(tag_in_valid) && $rose(set_in_valid) && tag_in_ready && set_in_ready) |->
      ##[0:6] ($rose(way_out_valid)));

/*
 * Kind of a worthless property because we could be currently flushing while this
 * happens so we'd still see a latency delay
 */
rsp_latency_1:
  assert property (disable iff(!rst || flush_in_valid)
    ($rose(tag_in_valid) && $rose(set_in_valid) && tag_in_ready && set_in_ready) |->
      ##[0:5] ($rose(way_out_valid)));

endmodule
