#!/usr/bin/env bash

if [[ $TRAVIS_EVENT_TYPE == "push" && $TRAVIS_BRANCH == "master" && ! -z "${CR_NOTEBOOKS+x}" && ! -z "${RTD_TOKEN+x}" ]]; then
    echo "Testing and regenerating notebooks"
    python -m pytest --regenerate
else
    echo "Testing notebooks"
    python -m pytest
fi
