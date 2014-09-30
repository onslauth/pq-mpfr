include $(PQ_FACTORY)/factory.mk

$(call show_vars,pq-gmp-dir)

pq_part_name := mpfr-2.4.2
pq_part_file := $(pq_part_name).tar.bz2

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) && \
	$(MAKE) -C $(pq_part_name) install DESTDIR=$(stage_dir) && \
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	( \
		cd $(pq_part_name) && \
		./configure --prefix=$(part_dir) \
			    --with-gmp=$(pq-gmp-dir) \
	) && touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar jxf $(source_dir)/$(pq_part_file) && touch $@

