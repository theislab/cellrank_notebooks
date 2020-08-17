#!/usr/bin/env bash

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" && "$USE_SLEPC" == "true" ]]; then
    echo "Installing SLEPc and PETSc dependencies"
    sudo apt-get update -y
    sudo apt-get install gcc gfortran libopenmpi-dev libblas-dev liblapack-dev -y

    echo "Installing SLEPc and PETSc"

    sudo pip install mpi4py

    sudo pip install petsc
    sudo pip install petsc4py

    sudo pip install slepc
    sudo pip install slepc4py

    python -c "import slepc; import petsc;"
    echo "Succesfully installed SLEPc and PETSc"
fi
