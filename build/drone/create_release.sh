#!/bin/bash

set -ue

apt-get update -y
apt-get install -y -q curl bzip2

# ship to github
curl -sL https://github.com/aktau/github-release/releases/download/v0.7.2/linux-amd64-github-release.tar.bz2 | tar -xjO > /usr/local/bin/github-release
chmod +x /usr/local/bin/github-release

if [[ $DRONE_TAG =~ .+-.+ ]]; then
    /usr/local/bin/github-release release \
        --user kontena \
        --repo pharos-cluster \
        --tag $DRONE_TAG \
        --name $DRONE_TAG \
        --description "Pre-release, only for testing" \
        --draft \
        --pre-release
else
    /usr/local/bin/github-release release \
        --user kontena \
        --repo pharos-cluster \
        --draft \
        --tag $DRONE_TAG \
        --name $DRONE_TAG
fi