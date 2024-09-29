#!/bin/bash

# Assume the index script repo is in the source code folder as below:
# /path/to/src/debug/idx-sh

if [ -e "./debug/idx-sh/rmm.sh" ]; then
    SRC_DIR=.
elif [ -e "./idx-sh/rmm.sh" ]; then
    SRC_DIR=..
elif [ -e "./rmm.sh" ]; then
    SRC_DIR=../..
else
    echo "ERROR - rmm.sh should be contained in $/{RMM}/debug/idx-sh"
    exit
fi

pushd $SRC_DIR >& /dev/null

find . -name "*.[chS]"                              > ./debug/.all.tmp
sed -e '/fake_host/d'       ./debug/.all.tmp        > ./debug/.part.000.tmp
sed -e '/\/tests\//d'       ./debug/.part.000.tmp   > ./debug/.part.001.tmp
sed -e '/\/test\//d'        ./debug/.part.001.tmp   > ./debug/.part.002.tmp
sed -e '/\/debug\//d'       ./debug/.part.002.tmp   > ./debug/.part.003.tmp
sed -e '/\/plat\/host\//d'  ./debug/.part.003.tmp   > ./debug/.part.004.tmp

cat ./debug/.part.004.tmp | sort > ./debug/src-to-idx

cscope -Rkb -i ./debug/src-to-idx &
ctags -R -L ./debug/src-to-idx &
wait

rm -f ./debug/.*.tmp

popd >& /dev/null
