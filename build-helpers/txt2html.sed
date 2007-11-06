# Convert certain text files to HTML fragment
s/&/\&amp/g;
s/</\&lt;/g;
s/>/\&gt;/g;
1s/^/<pre>\
/;
$s/$/\
<\/pre>/;
s|\([a-z]\{1,\}\)@\([a-z0-9.-]\{1,\}\)|\1\&#x40;\2|;
s|\([a-zA-Z0-9_-]\{1,\}\)\(([1-9])\)|<a href="\1.txt">\1\2</a>|;
s|\(http://[a-zA-Z0-9./_-]\{1,\}\)|<a href="\1">\1</a>|g;
