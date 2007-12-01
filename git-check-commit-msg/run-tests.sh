#!/bin/sh

tcdir="${top_srcdir-.}"
script="${top_srcdir-.}/git-check-commit-msg/git-check-commit-msg"

errors=0

while read tc expect restofline
do
	tcfile="${tcdir}/git-check-commit-msg/${tc}"
	test -s "$tcfile" || continue

	"$script" "$tcfile"; s="$?"

	if   [ "$s" -eq 0 ] && [ "x$expect" = "xOK" ]; then :;
	elif [ "$s" -ne 0 ] && [ "x$expect" = "xFAIL" ]; then :;
	else
		sh -x "$script" "$tcfile"
		echo "TC: $tc expected $expect, but deviates."
		errors="$(expr $errors + 1)"
	fi
done<<EOF
commit-1	OK
commit-2	FAIL
commit-3	OK
EOF

[ "$errors" -ne 0 ] && exit 1
