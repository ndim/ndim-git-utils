#!/bin/sh
#
# Usage:
#   $(SHELL) $(srcdir)/sed-subst.sh foo.sh.in foo.sh $(SED_SUBST)

set -e

infile="$1"
shift

outfile="$1"
shift

${MKDIR_P-mkdir -p} "$(dirname "$outfile")"

tmpfile="${outfile}.tmp.$$"

${SED-sed} "$@" "$infile" > "$tmpfile"

if ${GREP-grep} -n '@[A-Za-z0-9_]\{1,\}@' "$tmpfile"; then
    echo "Error: Unsubstituted strings in input file: $infile"
    rm -f "$tmpfile"
    exit 1
else
    mv -f "$tmpfile" "$outfile"
    exit 0
fi
