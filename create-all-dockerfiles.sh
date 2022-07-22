#!/bin/bash

dir=`dirname $0`

for os in ubuntu:18.04 ubuntu:20.04 ubuntu:22.04 ; do
  ${dir}/create-one-dockerfile.sh ${os}
done
