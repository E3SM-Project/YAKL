

set(MYSRC FFT.cpp)

add_executable(FFT ${MYSRC})
include(../../yakl_utils.cmake)
yakl_process_target(FFT)

separate_arguments(REAL_MPI_COMMAND UNIX_COMMAND ${MPI_COMMAND})

add_test(NAME FFT_test COMMAND ${REAL_MPI_COMMAND} ./FFT)

