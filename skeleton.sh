#!/bin/bash

# Assume the index script repo is in the source code folder as below:
# /path/to/src/debug/idx-sh

# Replace the following keywords:
# ___CODEBASE___
# ___KEYWORD___
# ___PATH___

# Find the correct path.
if [ -e "./debug/idx-sh/___CODEBASE___.sh" ]; then
    SRC_DIR=.
elif [ -e "./idx-sh/___CODEBASE___.sh" ]; then
    SRC_DIR=..
elif [ -e "./___CODEBASE___.sh" ]; then
    SRC_DIR=../..
else
    echo "ERROR - ___CODEBASE___.sh should be contained in $/___CODE_BASE___/debug/idx-sh"
    exit
fi

pushd $SRC_DIR >& /dev/null

# Find all.
find . -name "*.[chS]"  >   ./debug/.all.tmp

# Remove some keywords.
sed -e '/\/___KEYWORD___\//d' ./debug/.all.tmp  >   ./debug/.part.000.tmp
sed -e '/\/debug\//d' ./debug/.part.000.tmp     >   ./debug/.part.001.tmp

# Add some keywords then.
find ./___PATH___ -name "*.[chS]"    >   ./debug/.part.002.tmp

# Sum up.
cat ./debug/.part.001.tmp   >   ./debug/.sum.tmp
cat ./debug/.part.002.tmp   >>  ./debug/.sum.tmp

# sort it and save into ./debug/idx-to-src.
cat ./debug/.sum.tmp | sort  >   ./debug/idx-to-src

# Index.
cscope -Rkb -i ./debug/src-to-idx &
ctags -R -L ./debug/src-to-idx &
wait

# Cleanup.
rm -f ./debug/.*.tmp

popd >& /dev/null
