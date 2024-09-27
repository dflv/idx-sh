#!/bin/bash

# Assume the index script repo is in the source code folder as below:
# /path/to/src/debug/idx-sh

if [ -e "./debug/idx-sh/linux.sh" ]; then
    SRC_DIR=.
elif [ -e "./idx-sh/linux.sh" ]; then
    SRC_DIR=..
elif [ -e "./linux.sh" ]; then
    SRC_DIR=../..
else
    echo "ERROR - linux.sh should be contained in $/linux/debug/idx-sh"
    exit
fi

ARCH=arm64

pushd $SRC_DIR >& /dev/null

find . -name "*.[chS]" | sort > ./debug/.all.tmp
sed -e '/\/arch\//d' ./debug/.all.tmp > ./debug/.part.tmp
find ./arch/$ARCH -name "*.[chS]" | sort > ./debug/.$ARCH.tmp
cat ./debug/.$ARCH.tmp > ./debug/.sum.tmp
cat ./debug/.part.tmp >> ./debug/.sum.tmp
sed -e '/\/debug\//d' ./debug/.sum.tmp > ./debug/src-to-idx

cscope -Rkb -i ./debug/src-to-idx &
ctags -R -L ./debug/src-to-idx &
wait

rm -f ./debug/.*.tmp

popd >& /dev/null
