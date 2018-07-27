#!/bin/sh

# Do a build: build software and dependencies based on simple Git heuristics
set -e

# HEAD picks up files changes (both 'added' and in working copy.
COMMIT_RANGE=${1:-HEAD}

echo "Do a build for ${COMMIT_RANGE}"

function build_elixir {
  docker run -v `pwd`:/work -w "/work/${1}" -u `id -u`:`id -g` elixir:1.6 mix test
  # TODO: find projects that depend on this project
}

function build_gradle {
  docker run -v `pwd`:/work -w "/work/${1}" -u `id -u`:`id -g` -e HOME=/work gradle:4.9-jdk8 gradle --no-daemon build
  # TODO: find projects that depend on this project
}

{ test "-a" == "${COMMIT_RANGE}" && git ls-files || git diff --name-only ${COMMIT_RANGE}; } | \
grep '[^.].*/' | cut -f1 -d/ | sort -u | \
while read PROJECT
do
  echo
  echo "=== Project to build: $PROJECT ==="
  echo

  test -f "${PROJECT}/build.gradle" && build_gradle "${PROJECT}"
  test -f "${PROJECT}/mix.exs" && build_elixir "${PROJECT}"
done

