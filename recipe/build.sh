#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ $target_platform =~ .*osx.* ]]; then
    LDFLAGS="${LDFLAGS} -liconv"
fi

./configure --disable-silent \
    --disable-dependency-tracking \
    --prefix=${PREFIX}
if [[ ${CONDA_BUILD_CROSS_COMPILATION:-0} == 0 ]]; then
    if [[ ${target_platform} != "linux-ppc64le" ]] && [[ ${target_platform} != "linux-aarch64" ]]; then
        make -j${CPU_COUNT} check
    fi
fi
make -j${CPU_COUNT} install
