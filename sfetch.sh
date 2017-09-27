#!/bin/bash
REALPATH=$(realpath "$0")
DIR=$(dirname "$REALPATH")

REPO=$1

git fetch -v $1

while read -r COMMIT REF; do
    if ! $DIR/verify-commits/verify-commits.sh $COMMIT > /dev/null; then
        echo "FAILED at $COMMIT from $REF"
        exit 1
    fi
done < <(git ls-remote $1 2> /dev/null)
