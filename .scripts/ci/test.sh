#!/usr/bin/env bash

set -e

ORIGIN="https://github.com/theislab/cellrank_notebooks"


if [[ -n "${DEPLOY_TOKEN+x}" ]]; then
    python -m pytest --regenerate
    git add tutorials/*
    git commit -m "[ci skip] Regenerate notebooks"
    git push "https://$DEPLOY_TOKEN@${ORIGIN:8}"
else
    python -m pytest
fi
