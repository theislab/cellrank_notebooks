#!/usr/bin/env bash

set -e

pip install -r requirements.txt  # test requirements for notebooks
python -m ipykernel install --name cellrank --user

git clone https://github.com/theislab/cellrank
cd cellrank

if [[ "$TRAVIS_OS_NAME" == "linux" && "$USE_SLEPC" == "true" ]]; then
    pip install -e".[krylov,test]"
else
    pip install -e".[test]"
fi

python-vendorize
cd ..
