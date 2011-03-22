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

# Requires git 1.5 to work properly.
GIT = git
tag:
	test -d "$(top_srcdir)/.git"
	@cd "$(top_srcdir)" && $(GIT) status;:
	@cd "$(top_srcdir)" && if $(GIT) diff-files --quiet; then :; else \
		echo "Uncommitted local changes detected."; \
		exit 1; fi
	@cd "$(top_srcdir)" && if $(GIT) diff-index --cached --quiet HEAD; then :; else \
		echo "Uncommitted cached changes detected."; \
		exit 1; fi
	@test "x$(TAG)" = "x" && { \
		echo "TAG not defined. Try 'make tag TAG=2.11' or something similar."; \
		exit 1; }
	@test "x$$(echo "$(TAG)" | $(SED) 's/^[0-9]\{1,\}\.[0-9]\{1,\}//')" = "x" || { \
		echo "TAG=$(TAG) is not in numerical 'x.y' format."; \
		exit 1; }
	@test "x$$($(SED) '1p' '$(top_srcdir)/NEWS')" = "x$(PACKAGE_TARNAME) $(TAG)" || { \
		echo "NEWS does not start with entry for '$(PACKAGE_TARNAME) $(TAG)'"; \
		exit 1; }
	@$(SED) -n '1p; 2,/^$(PACKAGE_TARNAME) / p' '$(top_srcdir)/NEWS' \
		| $(SED) '$$d' | $(SED) '$$ { /^$$/d }' \
		> TAG-MESSAGE
	@cat TAG-MESSAGE
	@echo "Do you really want to tag this as release 'v$(TAG))? Enter to continue, Ctrl-C to abort."
	@msgfile="$$PWD/TAG-MESSAGE"; \
	trap "rm $$msgfile" TERM QUIT ABRT INT; read ignore_this; \
	cd "$(top_srcdir)" && $(GIT) tag -s -F "$$msgfile" "v$(TAG)"; \
	rm "$$msgfile"

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
