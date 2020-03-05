#!/bin/sh

set -e

oldest_commit='master@{2.days.ago}'

date
dir=$(dirname "$0")
echo "$dir"
echo ""

echo "Add."
echo ""
git -C "$dir" add -A
echo ""

echo "Commit."
echo ""
git -C "$dir" commit --allow-empty --allow-empty-message -m ''
echo ""

echo "Create temp branch."
echo ""
git -C "$dir" checkout --orphan temp "$oldest_commit"
echo ""

echo "Truncate commit."
echo ""
git -C "$dir" commit -m "Truncated history" -q
echo ""

echo "Rebase."
echo ""
git -C "$dir" rebase --onto temp "$oldest_commit" master
echo ""

echo "Delete temp branch."
echo ""
git -C "$dir" branch -D temp
echo ""
