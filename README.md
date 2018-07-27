# All in One

This repo contains some demoware that shows how to build multiple projects
efficiently from one source repository. One should think of a collection of
libraries and applications written in different languages.

The catch with most monorepo build tools is that that one tool should be used
to build all-the-things.

Wouldn't it be nice to be able to build kust what's needed, with the prefered
build tool for the language? E.g. Gradle for Java, NPM for NodeJS and Docker
builds.

The problem is not so much how to build, but how to build the *minimal*
necessary given the commits provided.

This repo tries to unraffle those issues.

In modern projects it's quite common to use an SaaS service for building, such
as [Circle CI](https://circleci.com) or [Travis CI](https://travis-ci.com).


For Travis we do want to disable the settings for Auto Cancellation, as
completely different artifacts may be built with each run.

## What makes a mono repo

A source code repository that contains code for different
applications/libraries/services, with independent lifecycles, can be called a
mono repo. All sources, regardless of their nature, are stored in one place.
