#!/bin/bash

dir=`dirname $0`

base=${1:-centos:7}

os=${base%%:*}
tag=${base##*:}

mkdir -p ${dir}/${os}${tag}
for i in `ls ${dir}/template/*-${os} ${dir}/template/*-all | sort` ; do
  cat $i
done | sed "s/%os%/${os}/g;s/%tag%/${tag}/g" > ${dir}/${os}${tag}/Dockerfile
