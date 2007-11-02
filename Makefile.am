CLEANFILES =
BUILT_SOURCES =
EXTRA_DIST =
bin_SCRIPTS =
man_MANS =
UPDATE_SOURCE_FILES =
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
