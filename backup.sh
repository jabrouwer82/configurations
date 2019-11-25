#!/bin/sh

set -e

dir=$(dirname $0)

date
echo ""

echo "add"
echo ""
git -C $dir add -A
echo ""

echo "commit"
echo ""
git -C $dir commit --allow-empty --allow-empty-message -m ''
echo ""

echo "replace"
echo ""
git -C $dir replace -f --graft @{7.days.ago}
echo ""

echo "filter-branch"
echo ""
git -C $dir filter-branch -f
