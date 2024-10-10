#!/bin/bash

# Assume the index script repo is in the source code folder as below:
# /path/to/src/debug/idx-sh

# Replace the following keywords:
# ___CODEBASE___
# ___KEYWORD___
# ___PATH___

# Find the correct path.
if [ -e "./debug/idx-sh/kvmtool.sh" ]; then
    SRC_DIR=.
elif [ -e "./idx-sh/kvmtool.sh" ]; then
    SRC_DIR=..
elif [ -e "./kvmtool.sh" ]; then
    SRC_DIR=../..
else
    echo "ERROR - kvmtool.sh should be contained in $/kvmtool/debug/idx-sh"
    exit
fi

pushd $SRC_DIR >& /dev/null

# Find all.
find . -name "*.[chS]"  >   ./debug/.all.tmp

# Remove some keywords.
sed -e '/\/aarch32\//d' ./debug/.all.tmp        >   ./debug/.part.000.tmp
sed -e '/\/mips\//d'    ./debug/.part.000.tmp   >   ./debug/.part.001.tmp
sed -e '/\/powerpc\//d' ./debug/.part.001.tmp   >   ./debug/.part.002.tmp
sed -e '/\/riscv\//d'   ./debug/.part.002.tmp   >   ./debug/.part.003.tmp
sed -e '/\/tests\//d'   ./debug/.part.003.tmp   >   ./debug/.part.004.tmp
sed -e '/\/x86\//d'     ./debug/.part.004.tmp   >   ./debug/.part.005.tmp
sed -e '/\/debug\//d'   ./debug/.part.005.tmp   >   ./debug/.part.006.tmp

# Add some keywords then.
### find ./___PATH___ -name "*.[chS]"    >   ./debug/.part.002.tmp

# Sum up.
cat ./debug/.part.006.tmp   >   ./debug/.sum.tmp
### cat ./debug/.part.002.tmp   >>  ./debug/.sum.tmp

# sort it and save into ./debug/src-to-idx.
cat ./debug/.sum.tmp | sort  >   ./debug/src-to-idx

# Index.
cscope -Rkb -i ./debug/src-to-idx &
ctags -R -L ./debug/src-to-idx &
wait

# Cleanup.
rm -f ./debug/.*.tmp

popd >& /dev/null
