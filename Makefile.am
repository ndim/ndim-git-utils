CLEANFILES =
BUILT_SOURCES =
EXTRA_DIST =
bin_SCRIPTS =
man1_MANS =
UPLOAD_FILES =
doc_DATA =
dist_doc_DATA =
AM_INSTALLCHECK_STD_OPTIONS_EXEMPT =

ACLOCAL_AMFLAGS = -I m4 --install

include Makefile-files
include doc/Makefile-files
include git-ndim-sh/Makefile-files
include git-amb/Makefile-files
include git-buildmsg/Makefile-files
include git-follow/Makefile-files

if HAVE_NDIM_MAN2TXT
.man.txt:
	$(NDIM_MAN2TXT) "$<" > "$@.new"
	test -s "$@.new"
	mv -f "$@.new" "$@"
endif

tag:
	test -d "$(top_srcdir)/.git"
	cd "$(top_srcdir)" && git status;:
	@echo "Do you really want to tag this as rel-$(PACKAGE_VERSION)? Enter to continue, Ctrl-C to abort."
	@read
	cd "$(top_srcdir)" && git tag "rel-$(PACKAGE_VERSION)"

UPLOAD_DIR = upload-dir
ALL_UPLOAD_FILES = $(UPLOAD_FILES) $(distdir).tar.bz2
upload: $(UPLOAD_FILES) dist tag
	rm -rf "$(UPLOAD_DIR)"
	mkdir -p "$(UPLOAD_DIR)"
	for f in $(ALL_UPLOAD_FILES); do \
		ln "$$(test -e "$$f" || echo "$(top_srcdir)/")$$f" "$(UPLOAD_DIR)/"; \
	done
	rsync -avz --delete "$(UPLOAD_DIR)/" $(RSYNC_HOST):$(RSYNC_DIR)/$(PACKAGE_TARNAME)/
	rm -rf "$(UPLOAD_DIR)"
	if test -d "$(top_srcdir)/.git"; then git push public master; fi

clean-local:
	rm -rf "$(UPLOAD_DIR)"
