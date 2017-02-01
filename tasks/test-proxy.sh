#!/bin/sh

set -e

export GOPATH=$(pwd)/gopath
export PATH=$PATH:$GOPATH/bin

cd gopath/src/github.com/cloudfoundry-community/cf-uaa-guard-service/proxy

go get github.com/onsi/ginkgo/ginkgo
go get github.com/onsi/gomega

curl https://glide.sh/get | sh
glide install

ginkgo -r
