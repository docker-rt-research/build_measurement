#!/bin/bash
#
# Configuration:
# scen4.sh
# native ArchLinux, CCache=enabled, make -j4
CUR_FOLDER=$(cd .. && pwd)

$CUR_FOLDER/config/reset.sh
$CUR_FOLDER/config/config-keys.sh
$CUR_FOLDER/config/install-dep.sh
$CUR_FOLDER/config/install-docker.sh


rm -rf ~/ccache
mkdir ~/ccache
export PATH=/usr/lib/ccache:$PATH
export CCACHE_DIR=~/ccache
export CC="ccache gcc" CXX="ccache g++"

cd ~/OpenDaVINCI && mkdir build
cd build && cmake -D CMAKE_INSTALL_PREFIX=~/install_od ..

echo "Beginning measurement and build"
echo "Start pre cache at $(date +%s%N)" >> $CUR_FOLDER/measurements/scenario4.log
cd ~/OpenDaVINCI/build && make -j4
echo "End pre cache at $(date +%s%N)" >> $CUR_FOLDER/measurements/scenario4.log
echo "DONE!"


$CUR_FOLDER/config/reset.sh
$CUR_FOLDER/config/config-keys.sh
$CUR_FOLDER/config/install-dep.sh
$CUR_FOLDER/config/install-docker.sh


rm -rf ~/ccache
mkdir ~/ccache
export PATH=/usr/lib/ccache:$PATH
export CCACHE_DIR=~/ccache
export CC="ccache gcc" CXX="ccache g++"

cd ~/OpenDaVINCI && mkdir build
cd build && cmake -D CMAKE_INSTALL_PREFIX=~/install_od ..

echo "Beginning measurement and build"
echo "Start post cache at $(date +%s%N)" >> $CUR_FOLDER/measurements/scenario4.log
cd ~/OpenDaVINCI/build && make -j4
echo "End post cahce at $(date +%s%N)" >> $CUR_FOLDER/measurements/scenario4.log
echo "DONE!"