#!/bin/bash

# Simple packaging of zookeepercli
#

release_version="1.0.10"
release_dir=target
rm -rf $release_dir/*
mkdir -p $release_dir

cd  $(dirname $0)
for f in $(find . -name "*.go"); do go fmt $f; done

go build -o $release_dir/local/zookeepercli -ldflags "-s -w"
if [[ $? -ne 0 ]] ; then
	exit 1
fi

#build for linux 386
env GOOS="linux" GOARCH="386" go build -o $release_dir/linux/zookeepercli -ldflags "-s -w"

if [[ $? -ne 0 ]] ; then
	exit 1
fi

echo "---"
echo "Done. Find releases in $release_dir"
