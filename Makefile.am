CLEANFILES =
BUILT_SOURCES =
EXTRA_DIST =

gitexec_SCRIPTS =
man1_MANS =
UPLOAD_FILES =
doc_DATA =
dist_doc_DATA =
bin_PROGRAMS =
check_PROGRAMS =
noinst_DATA =
noinst_PROGRAMS =
bin_SCRIPTS =
check_SCRIPTS =
TESTS =
AM_INSTALLCHECK_STD_OPTIONS_EXEMPT =

CLEAN_LOCAL_TARGETS =

# For the test cases
export top_srcdir

AM_CPPFLAGS = -I${top_builddir}/include

ACLOCAL_AMFLAGS = --install


EXTRA_DIST += sed-subst.sh
export GREP
export MKDIR_P
export SED

SED_SUBST  =

SED_SUBST += -e 's|[@]PACKAGE_NAME@|$(PACKAGE_NAME)|g'
SED_SUBST += -e 's|[@]PACKAGE_TARNAME@|$(PACKAGE_TARNAME)|g'
SED_SUBST += -e 's|[@]PACKAGE_VERSION@|$(PACKAGE_VERSION)|g'

SED_SUBST += -e 's|[@]gitexecdir@|$(gitexecdir)|g'
SED_SUBST += -e 's|[@]mandir@|$(mandir)|g'
SED_SUBST += -e 's|[@]prefix@|$(prefix)|g'

SED_SUBST += -e 's|[@]top_srcdir@|$(top_srcdir)|g'

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


EXTRA_DIST  += INSTALL.in
noinst_DATA += INSTALL
CLEANFILES  += INSTALL
INSTALL: $(srcdir)/INSTALL.in $(srcdir)/sed-subst.sh Makefile
	$(srcdir)/sed-subst.sh $(srcdir)/INSTALL.in INSTALL $(SED_SUBST)

dist-hook: dist-hook-rm-INSTALL-file
dist-hook-rm-INSTALL-file:
	rm -f "$(distdir)/INSTALL"

include m4/ndim-build-rpms.mk

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

clean-local: $(CLEAN_LOCAL_TARGETS)
	rm -rf "$(UPLOAD_DIR)"

# End of Makefile.am.
