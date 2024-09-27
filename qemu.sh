#!/bin/bash

# Assume the index script repo is in the source code folder as below:
# /path/to/src/debug/idx-sh

if [ -e "./debug/idx-sh/qemu.sh" ]; then
    SRC_DIR=.
elif [ -e "./idx-sh/qemu.sh" ]; then
    SRC_DIR=..
elif [ -e "./qemu.sh" ]; then
    SRC_DIR=../..
else
    echo "ERROR - qemu.sh should be contained in $/{QEMU}/debug/idx-sh"
    exit
fi

### for aarch.

pushd $SRC_DIR >& /dev/null

find . -name "*.[chS]"                          >   ./debug/.all.tmp

sed -e '/\/tests\//d'   ./debug/.all.tmp        >   ./debug/.part.000.tmp

sed -e '/\/target\//d'  ./debug/.part.000.tmp   >   ./debug/.part.001.tmp
find ./target/arm -name "*.[chS]"               >   ./debug/.part.002.tmp
cat                     ./debug/.part.001.tmp   >>  ./debug/.part.002.tmp

sed -e '/\/configs\/devices\//d'    ./debug/.part.002.tmp   >   ./debug/.part.003.tmp
find ./configs/devices/aarch64-softmmu -name "*.[chS]"      >>  ./debug/.part.003.tmp

sed -e '/\/linux-user\//d'          ./debug/.part.003.tmp   >   ./debug/.part.004.tmp
find ./linux-user -maxdepth 1 -name "*.[chS]"               >>  ./debug/.part.004.tmp
find ./linux-user/aarch64 -name "*.[chS]"                   >>  ./debug/.part.004.tmp
find ./linux-user/include/host/aarch64 -name "*.[chS]"      >>  ./debug/.part.004.tmp

sed -e '/\/common-user\/host\//d'   ./debug/.part.004.tmp   >   ./debug/.part.005.tmp
find ./common-user/host/aarch64 -name "*.[chS]"             >>  ./debug/.part.005.tmp

sed -e '/\/disas\/alpha\.c/d'       ./debug/.part.005.tmp   >   ./debug/.part.006.tmp
sed -e '/\/disas\/cris\.c/d'        ./debug/.part.006.tmp   >   ./debug/.part.007.tmp
sed -e '/\/disas\/m68k\.c/d'        ./debug/.part.007.tmp   >   ./debug/.part.008.tmp
sed -e '/\/disas\/mips\.c/d'        ./debug/.part.008.tmp   >   ./debug/.part.009.tmp
sed -e '/\/disas\/nanomips\.c/d'    ./debug/.part.009.tmp   >   ./debug/.part.010.tmp
sed -e '/\/disas\/riscv/d'          ./debug/.part.010.tmp   >   ./debug/.part.011.tmp
sed -e '/\/disas\/sh4\.c/d'         ./debug/.part.011.tmp   >   ./debug/.part.012.tmp
sed -e '/\/disas\/sparc\.c/d'       ./debug/.part.012.tmp   >   ./debug/.part.013.tmp
sed -e '/\/disas\/xtensa\.c/d'      ./debug/.part.013.tmp   >   ./debug/.part.014.tmp

sed -e '/\/linux-headers\//d'       ./debug/.part.014.tmp   >   ./debug/.part.015.tmp
find ./linux-headers/asm-arm64 -name "*.[chS]"              >>  ./debug/.part.015.tmp
find ./linux-headers/linux -name "*.[chS]"                  >>  ./debug/.part.015.tmp

sed -e '/\/tcg\//d'                 ./debug/.part.015.tmp   >   ./debug/.part.016.tmp
find ./tcg -maxdepth 1 -name "*.[chS]"                      >>  ./debug/.part.016.tmp
find ./tcg/aarch64 -name "*.[chS]"                          >>  ./debug/.part.016.tmp

sed -e '/\/hw\/alpha\//d'       ./debug/.part.016.tmp   >   ./debug/.part.017.tmp
sed -e '/\/hw\/cris\//d'        ./debug/.part.017.tmp   >   ./debug/.part.018.tmp
sed -e '/\/hw\/i386\//d'        ./debug/.part.018.tmp   >   ./debug/.part.019.tmp
sed -e '/\/hw\/loongarch\//d'   ./debug/.part.019.tmp   >   ./debug/.part.020.tmp
sed -e '/\/hw\/m68k\//d'        ./debug/.part.020.tmp   >   ./debug/.part.021.tmp
sed -e '/\/hw\/microblaze\//d'  ./debug/.part.021.tmp   >   ./debug/.part.022.tmp
sed -e '/\/hw\/mips\//d'        ./debug/.part.022.tmp   >   ./debug/.part.023.tmp
sed -e '/\/hw\/openrisc\//d'    ./debug/.part.023.tmp   >   ./debug/.part.024.tmp
sed -e '/\/hw\/ppc\//d'         ./debug/.part.024.tmp   >   ./debug/.part.025.tmp
sed -e '/\/hw\/riscv\//d'       ./debug/.part.025.tmp   >   ./debug/.part.026.tmp
sed -e '/\/hw\/s390x\//d'       ./debug/.part.026.tmp   >   ./debug/.part.027.tmp
sed -e '/\/hw\/sh4\//d'         ./debug/.part.027.tmp   >   ./debug/.part.028.tmp
sed -e '/\/hw\/sparc\//d'       ./debug/.part.028.tmp   >   ./debug/.part.029.tmp
sed -e '/\/hw\/sparc64\//d'     ./debug/.part.029.tmp   >   ./debug/.part.030.tmp
sed -e '/\/hw\/tricore\//d'     ./debug/.part.030.tmp   >   ./debug/.part.031.tmp
sed -e '/\/hw\/xtensa\//d'      ./debug/.part.031.tmp   >   ./debug/.part.032.tmp

sed -e '/\/include\/hw\/cris\//d'       ./debug/.part.032.tmp   >   ./debug/.part.033.tmp
sed -e '/\/include\/hw\/i386\//d'       ./debug/.part.033.tmp   >   ./debug/.part.034.tmp
sed -e '/\/include\/hw\/loongarch\//d'  ./debug/.part.034.tmp   >   ./debug/.part.035.tmp
sed -e '/\/include\/hw\/m68k\//d'       ./debug/.part.035.tmp   >   ./debug/.part.036.tmp
sed -e '/\/include\/hw\/mips\//d'       ./debug/.part.036.tmp   >   ./debug/.part.037.tmp
sed -e '/\/include\/hw\/openrisc\//d'   ./debug/.part.037.tmp   >   ./debug/.part.038.tmp
sed -e '/\/include\/hw\/ppc\//d'        ./debug/.part.038.tmp   >   ./debug/.part.039.tmp
sed -e '/\/include\/hw\/riscv\//d'      ./debug/.part.039.tmp   >   ./debug/.part.040.tmp
sed -e '/\/include\/hw\/s390x\//d'      ./debug/.part.040.tmp   >   ./debug/.part.041.tmp
sed -e '/\/include\/hw\/sh4\//d'        ./debug/.part.041.tmp   >   ./debug/.part.042.tmp
sed -e '/\/include\/hw\/sparc\//d'      ./debug/.part.042.tmp   >   ./debug/.part.043.tmp
sed -e '/\/include\/hw\/tricore\//d'    ./debug/.part.043.tmp   >   ./debug/.part.044.tmp
sed -e '/\/include\/hw\/xtensa\//d'     ./debug/.part.044.tmp   >   ./debug/.part.045.tmp

sed -e '/\/host\/include\//d'           ./debug/.part.045.tmp   >   ./debug/.part.046.tmp
find ./host/include/aarch64 -name "*.[chS]"                     >>  ./debug/.part.046.tmp
find ./host/include/generic -name "*.[chS]"                     >>  ./debug/.part.046.tmp

sed -e '/\/debug\//d'                   ./debug/.part.046.tmp   >   ./debug/.part.047.tmp

cat ./debug/.part.047.tmp | sort                                >   ./debug/src-to-idx

cscope -Rkb -i ./debug/src-to-idx &
ctags -R -L ./debug/src-to-idx &
wait

rm -f ./debug/.*.tmp

popd >& /dev/null
