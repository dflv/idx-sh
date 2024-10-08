#!/bin/bash

# Assume the index script repo is in the source code folder as below:
# /path/to/src/debug/idx-sh

if [ -e "./debug/idx-sh/tf-a.sh" ]; then
    SRC_DIR=.
elif [ -e "./idx-sh/tf-a.sh" ]; then
    SRC_DIR=..
elif [ -e "./tf-a.sh" ]; then
    SRC_DIR=../..
else
    echo "ERROR - tf-a.sh should be contained in $/{TF-A}/debug/idx-sh"
    exit
fi

# It is only for aarch64 as ARCH, qemu as PLAT.

pushd $SRC_DIR >& /dev/null

find . -name "*.[chS]"                      >   ./debug/.all.tmp
sed -e '/\/plat\//d'    ./debug/.all.tmp    >   ./debug/.part.000.tmp

find ./include/plat/common -name "*.[chS]"      >   ./debug/.comp.000.tmp
find ./plat/common -maxdepth 1 -name "*.[chS]"  >   ./debug/.comp.001.tmp
find ./plat/qemu/common -name "*.[chS]"         >   ./debug/.comp.002.tmp
find ./plat/qemu/qemu -name "*.[chS]"           >   ./debug/.comp.003.tmp

cat ./debug/.part.000.tmp   >   ./debug/.part.010.tmp
cat ./debug/.comp.000.tmp   >>  ./debug/.part.010.tmp
cat ./debug/.comp.001.tmp   >>  ./debug/.part.010.tmp
cat ./debug/.comp.002.tmp   >>  ./debug/.part.010.tmp
cat ./debug/.comp.003.tmp   >>  ./debug/.part.010.tmp

sed -e '/\/aarch32\//d' ./debug/.part.010.tmp   >   ./debug/.part.011.tmp
sed -e '/sbsa/d'        ./debug/.part.011.tmp   >   ./debug/.part.012.tmp
sed -e '/\/debug\//d'   ./debug/.part.012.tmp   >   ./debug/.part.013.tmp

cat ./debug/.part.013.tmp | sort    >   ./debug/src-to-idx

cscope -Rkb -i ./debug/src-to-idx &
ctags -R -L ./debug/src-to-idx &
wait

rm -f ./debug/.*.tmp

popd >& /dev/null
