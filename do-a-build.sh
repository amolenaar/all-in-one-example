#!/bin/sh

# Do a build: build software and dependencies based on simple Git heuristics

COMMIT_RANGE=${1:-HEAD}

echo "Do a build for ${COMMIT_RANGE}"

git diff --name-only ${COMMIT_RANGE} | grep '[^.].*/' | cut -f1 -d/ | sort -u | \
while read PROJECT
do
  echo "Project to build: $PROJECT"
  test -f "${PROJECT}/gradlew" && { cd "${PROJECT}" && ./gradlew build; }
  test -f "${PROJECT}/mix.exs" && { cd "${PROJECT}" && mix test; }
done

