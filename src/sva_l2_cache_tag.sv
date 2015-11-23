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
 * BASIC COVERS
 */

/* Input covers */
rst_cover_0: cover property (!rst);
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
//flush_in_valid_cover_1: cover property (flush_in_valid);
flush_complete_ready_cover_0: cover property (!flush_complete_ready);
flush_complete_ready_cover_1: cover property (flush_complete_ready);

way_out_ready_cover_0: cover property (!way_out_ready);
way_out_ready_cover_1: cover property (way_out_ready);
state_out_ready_cover_0: cover property (!state_out_ready);
state_out_ready_cover_1: cover property (state_out_ready);
inv_ack_cnt_out_ready_cover_0: cover property (!inv_ack_cnt_out_ready);
inv_ack_cnt_out_ready_cover_1: cover property (inv_ack_cnt_out_ready);

tag_out_evict_ready_cover_0: cover property (!tag_out_evict_ready);
tag_out_evict_ready_cover_1: cover property (tag_out_evict_ready);
set_out_evict_ready_cover_0: cover property (!set_out_evict_ready);
set_out_evict_ready_cover_1: cover property (set_out_evict_ready);
state_out_evict_ready_cover_0: cover property (!state_out_evict_ready);
state_out_evict_ready_cover_1: cover property (state_out_evict_ready);

way_out_flush_ready_cover_0: cover property (!way_out_flush_ready);
way_out_flush_ready_cover_1: cover property (way_out_flush_ready);
tag_out_flush_ready_cover_0: cover property (!tag_out_flush_ready);
tag_out_flush_ready_cover_1: cover property (tag_out_flush_ready);
set_out_flush_ready_cover_0: cover property (!set_out_flush_ready);
set_out_flush_ready_cover_1: cover property (set_out_flush_ready);
state_out_flush_ready_cover_0: cover property (!state_out_flush_ready);
state_out_flush_ready_cover_1: cover property (state_out_flush_ready);
inv_ack_cnt_out_flush_ready_cover_0: cover property (!inv_ack_cnt_out_flush_ready);
inv_ack_cnt_out_flush_ready_cover_1: cover property (inv_ack_cnt_out_flush_ready);

/* output covers */
tag_in_ready_cover_0: cover property (!tag_in_ready);
tag_in_ready_cover_1: cover property (tag_in_ready);
set_in_ready_cover_0: cover property (!set_in_ready);
set_in_ready_cover_1: cover property (set_in_ready);
state_in_ready_cover_0: cover property (!state_in_ready);
state_in_ready_cover_1: cover property (state_in_ready);
inv_ack_cnt_in_ready_cover_0: cover property (!inv_ack_cnt_in_ready);
inv_ack_cnt_in_ready_cover_1: cover property (inv_ack_cnt_in_ready);

/*
flush_in_ready_cover_0: cover property (!flush_in_ready);
flush_in_ready_cover_1: cover property (flush_in_ready);
flush_complete_valid_cover_0: cover property (!flush_complete_valid);
flush_complete_valid_cover_1: cover property (flush_complete_valid);
*/

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

/*
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
*/


/* memory covers */
/*
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
*/

endmodule
