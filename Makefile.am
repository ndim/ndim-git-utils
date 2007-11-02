BUILT_SOURCES =
EXTRA_DIST =
bin_SCRIPTS =
man_MANS =
UPDATE_SOURCE_FILES =

ACLOCAL_AMFLAGS = -I m4 --install

include doc/Makefile-files
include src/Makefile-files

all-local: update-sources

update-sources: $(UPDATE_SOURCE_FILES)
	@echo "x$(top_srcdir)" "x$(top_builddir)"; \
	if test "x$(top_srcdir)" != "x$(top_builddir)"; then \
		for file in $(UPDATE_SOURCE_FILES); do \
			echo cp -f "$${file}" "$(top_srcdir)/$${file}"; \
			cp -f "$${file}" "$(top_srcdir)/$${file}"; \
		done; \
	else \
		echo "srcdir == builddir, no special updates needed."; \
	fi

if HAVE_NDIM_MAN2TXT
.1.txt:
	set -x; $(NDIM_MAN2TXT) "$<" > "$@.new"
	test -s "$@.new"
	mv -f "$@.new" "$@"
endif
