default: formal

debug: formal
	qverify formal_results/formal_verify.db &

formal: compile
	qverify -c -do formal.do -od formal_results

compile: clean
	vlib work
	vmap work work
	vlog ./src/l2_cache_tag_unisim_rtl.v -pslfile ./src/l2_cache_tag_unisim_assertions.psl
	vlog -sv -mfcu -cuname my_bind_sva ./src/sva_bind.sv ./src/sva_l2_cache_tag.sv

clean:
	qverify_clean
	rm -rf work modelsim.ini *.log
	rm -rf formal_results

