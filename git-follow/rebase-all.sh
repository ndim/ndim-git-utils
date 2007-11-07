#!/bin/sh

set -x
while read branch base restofline
do
	git rebase "$base" "$branch" || exit "$?"
done<<EOF
master			origin
ndim-trivial-fixes	master
ndim-doc		ndim-trivial-fixes
ndim/update-docs	ndim-doc
ndim/update-docs-auto	ndim-doc
ndim/update-man-sed	ndim-doc
fedora/generate-xinf	ndim-trivial-fixes
ndim-conntest-checks	ndim-trivial-fixes
EOF
