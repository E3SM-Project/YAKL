#!/bin/bash

test_home=/gpfs/alpine/cli133/proj-shared/yakl-testing/
export CTEST_BUILD_NAME=main-hip-rocm-opt

# unset CXXFLAGS
# unset FFLAGS
# unset CFLAGS
# unset FCLAGS
# unset HIPCXX
# unset HIPFLAGS
 
source $MODULESHOME/init/bash
module purge
module load PrgEnv-amd craype-accel-amd-gfx90a
unset GATOR_DISABLE
unset OMP_NUM_THREADS
export CC=cc
export CXX=hipcc
export FC=ftn

export YAKL_CTEST_SRC=${test_home}/YAKL
export YAKL_CTEST_BIN=${test_home}/scratch
export CTEST_YAKL_ARCH="HIP"
export CTEST_HIP_FLAGS="-O3 -DYAKL_ENABLE_STREAMS -Wno-tautological-pointer-compare -Wno-unused-result --offload-arch=gfx90a -x hip"
export CTEST_C_FLAGS="-O3"
export CTEST_F90_FLAGS="-O3"
export CTEST_LD_FLAGS=""
export CTEST_GCOV=0
export CTEST_VALGRIND=0

ctest_dir=`pwd`
cd ${YAKL_CTEST_SRC}
git fetch origin
git checkout main
git reset --hard origin/main
git submodule update --init --recursive

rm -rf ${YAKL_CTEST_BIN}
mkdir ${YAKL_CTEST_BIN}

cd ${ctest_dir}

ctest -S ctest_script.cmake
