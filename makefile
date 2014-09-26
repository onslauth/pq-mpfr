include $(PQ_FACTORY)/factory.mk

$(info AG)
$(call show_vars,pq_part_dir_pq-gmp)

pq_module_name := mpfr-2.4.2
pq_module_file := $(pq_module_name).tar.bz2

build: build-stamp
build-stamp: stage-stamp
	(cd $(pq_module_name) && \
		$(MAKE) && \
		$(MAKE) install DESTDIR=$(stage_dir) \
	) && touch $@

stage-stamp: configure-stamp

configure: configure-stamp
configure-stamp: patch-stamp
	(cd $(pq_module_name) && \
		./configure --prefix=$(part_dir) \
				--with-gmp=$(pq_part_dir_pq-gmp) \
	) && touch $@

patch: patch-stamp
patch-stamp: unpack-stamp
	touch $@

unpack: unpack-stamp
unpack-stamp: $(pq_module_file)
	tar jxf $(source_dir)/$(pq_module_file) && touch $@

