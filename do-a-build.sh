#!/bin/sh

# Do a build: build software and dependencies based on simple Git heuristics

function die() {
  echo "FAIL: $*" >&2
  exit 1
}

COMMIT_RANGE=${1:-HEAD}

echo "Do a build for ${COMMIT_RANGE}"

git diff --name-only ${COMMIT_RANGE} | grep '[^.].*/' | cut -f1 -d/ | sort -u | \
while read PROJECT
do
  test -f "${PROJECT}/gradlew" && { cd "${PROJECT}" && ./gradlew build; }
done

