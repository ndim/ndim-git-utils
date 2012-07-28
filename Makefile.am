CLEANFILES =
BUILT_SOURCES =
EXTRA_DIST =

gitbindir = $(pkglibexecdir)

gitbin_SCRIPTS =
man1_MANS =
UPLOAD_FILES =
doc_DATA =
dist_doc_DATA =
bin_PROGRAMS =
check_PROGRAMS =
bin_SCRIPTS =
check_SCRIPTS =
TESTS =
AM_INSTALLCHECK_STD_OPTIONS_EXEMPT =

# For the test cases
export top_srcdir

AM_CPPFLAGS = -I${top_builddir}/include

ACLOCAL_AMFLAGS = -I m4 --install

include build-helpers/package-version.mk

include Makefile-files
include doc/Makefile-files
include git-ndim-sh/Makefile-files
include git-amb/Makefile-files
include git-buildmsg/Makefile-files
include git-rebase-subtree/Makefile-files
include git-check-commit-msg/Makefile-files

if HAVE_NDIM_MAN2TXT
.man.txt:
	$(NDIM_MAN2TXT) "$<" > "$@.new"
	test -s "$@.new"
	mv -f "$@.new" "$@"
endif


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
	if test -d "$(top_srcdir)/.git"; then cd "$(top_srcdir)" && git push public master; fi

clean-local:
	rm -rf "$(UPLOAD_DIR)"

# End of Makefile.am.
