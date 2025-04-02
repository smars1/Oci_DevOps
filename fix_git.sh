#!/bin/sh
git fetch --unshallow

for f in $(git ls-files) ; do touch --date=@$(git log -1 --date=unix --format='%cd' "$f") "$f"; done