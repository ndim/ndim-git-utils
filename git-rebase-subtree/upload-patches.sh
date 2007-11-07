#!/bin/sh
set -x
rsync -avz --delete patches/ "${RSYNC_HOST}:${RSYNC_DIR}/patches/"
for branch in "" ndim-trivial-fixes ndim-doc ndim-git-version
do
	git push -f public ${branch}
done
