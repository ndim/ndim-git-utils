CLEANFILES =
BUILT_SOURCES =
EXTRA_DIST =
bin_SCRIPTS =
man_MANS =
UPLOAD_FILES =
doc_DATA =
dist_doc_DATA =

ACLOCAL_AMFLAGS = -I m4 --install

include Makefile-files
include doc/Makefile-files
include src/Makefile-files

if HAVE_NDIM_MAN2TXT
.1.txt:
	set -x; $(NDIM_MAN2TXT) "$<" > "$@.new"
	test -s "$@.new"
	mv -f "$@.new" "$@"
endif

UPLOAD_DIR = upload-dir
UPLOAD_FILES += $(distdir).tar.bz2
upload: src/git-amb src/git-amb.txt dist
	rm -rf "$(UPLOAD_DIR)"
	mkdir -p "$(UPLOAD_DIR)"
	for f in $(UPLOAD_FILES); do \
		ln "$$(test -e "$$f" || echo "$(top_srcdir)/")$$f" "$(UPLOAD_DIR)/"; \
	done
	rsync -avz --delete "$(UPLOAD_DIR)/" $(RSYNC_HOST):$(RSYNC_DIR)/$(PACKAGE_TARNAME)/
	rm -rf "$(UPLOAD_DIR)"

clean-local:
	rm -rf "$(UPLOAD_DIR)"
