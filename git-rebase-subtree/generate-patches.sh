#!/bin/sh
set -x

repourl="http://radeonhd.lauft.net/xf86-video-radeonhd.git/"
sedhtml="s/&/\&amp;/g; s/@/\&#x40;/g; s/</\&lt;/g; s/>/\&gt;/g;"

rm -f "patches/"*/[0-9][0-9][0-9][0-9]-*.patch
rmdir "patches/"*

while read start from to dir restofline
do
	if echo "$start" | grep '^#' > /dev/null; then continue; fi
	git format-patch -o "patches/$dir" --start-number "$start" "$from".."$to"
	if test "x$to" = "x$dir"; then
		{
		echo "<h1 style='margin:0;'>${to} branch</h1>"
		echo "<p><tt>git pull ${repourl} ${to}</tt></p>"
		} > "patches/$dir/HEADER.html"
		echo "IndexIgnore .." > "patches/$dir/.htaccess"
		{
		sedcmds=""
		for f in "patches/$dir/"[0-9]*.patch; do
			b="$(basename "$f")"
			commit="$(sed -n '1s/^From \([a-z0-9]\{1,\}\).*/\1/p' "$f")"
			sedcmds="${sedcmds} s|\(${commit}\)|<a href=\"$b\">\1</a>|;"
			echo "AddDescription \"$(sed -n 's|^Subject: [PATCH[^\]*] \(.*\)|\1|p' "$f" | sed "${sedhtml}")\" ${b}" >> "patches/$dir/.htaccess"
		done
		echo "$commits"
		echo "<pre style=\"\">"
		git log --stat "${from}..${to}" | sed "${sedhtml}${sedcmds}"
		echo "</pre>"
		} > "patches/$dir/README.html"
	fi
done<<EOF
#1	master			ndim-trivial-fixes		ndim-trivial-fixes
#1	ndim-trivial-fixes	ndim-doc			ndim-doc
1	ndim-trivial-fixes	ndim-git-version		ndim-git-version
101	ndim-doc		ndim/update-docs		manpage-update
201	ndim-doc		ndim/update-docs-auto		manpage-update
301	ndim-doc		ndim/update-man-sed		manpage-update
EOF

( cd patches && tar cvfz ndim-all-radeonhd-patches.tar.gz --exclude .htaccess --exclude '*~' --exclude '*.tar.gz' --exclude 'HEADER.html' .)

ls -l patches
