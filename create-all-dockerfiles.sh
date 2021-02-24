#!/bin/bash

dir=`dirname $0`

for os in centos:7 centos:8 ubuntu:18.04 ubuntu:20.04 ubuntu:20.10 ; do
  ${dir}/create-one-dockerfile.sh ${os}
done
