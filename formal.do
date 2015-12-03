onerror {exit 1}
do directives.do
configure error -inferred black_box
formal compile -d l2_cache_tag_unisim_rtl -cuname my_bind_sva -target_cover_statements
formal verify -init init.seq -effort unlimited -timeout 30m -rtl_init_values
exit 0
