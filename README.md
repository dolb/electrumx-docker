# About

This is a electrumx docker container repository. Before we start shout out to @rizkiwicaksono (https://github.com/rizkiwicaksono) for making big part of the Dockerfile and electrumx-server script.

Basically there are 3 files that needs to be pointed out here:
1) Dockerfile - contains the image initialization
2) docker-entrypoint.sh - entrypoint that is injected before every command you give to the docker container. Its default behavior is to run electrumx server as zcluser making sure that all files permissions are set correctly. You can also run commands on the container as root thanks to it by simply adding -e CUSTOM_USER="root" to your docker run command.
3) electrumx-server - the main script that runs zcashd as deamon and starts electrumx server that connects to it


## Sample usage

The **test-build-example.sh** script will build electrumx docker container from scratch on the docker host you are connected to.
The **test-run-example.sh** is a run image example with persistent volumes linked.


## What seems needed

1) **Releases and versioning** - it shouldn't be pulled from master - some zip releases from github with sha256 checksums that will be downloaded.
2) **Build deps** (optional) - to be puristic if we know what is needed to build z-classic full node we would be able to download it, build and then purge build dependiencies.


## Why sudo?

Dude why sudo? Haven't you heard of gosu? Well I actually did still I wasted 2h trying to figure out why it isn't working for me, so I'm stuck with sudo :)
