#!/usr/bin/env bash

if [[ -n "${DEPLOY_TOKEN+x}" ]]; then
    python -m pytest --regenerate
else
    python -m pytest
fi
