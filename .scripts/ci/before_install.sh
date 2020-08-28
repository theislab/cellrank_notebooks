#!/usr/bin/env bash

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" && "$USE_SLEPC" == "true" ]]; then
    echo "Installing SLEPc and PETSc dependencies"
    sudo apt-get update -y
    sudo apt-get install gcc gfortran libopenmpi-dev libblas-dev liblapack-dev curl -y

    echo "Installing SLEPc and PETSc Python libraries"

    pip_cmd=$(which pip)  # because sudo pip is Python2.7

    sudo -H $pip_cmd install mpi4py

    sudo -H $pip_cmd install petsc
    sudo -H $pip_cmd install petsc4py

    sudo -H $pip_cmd install slepc
    sudo -H $pip_cmd install slepc4py

    python -c "import slepc; import petsc;"
    echo "Successfully installed SLEPc and PETSc"
fi
