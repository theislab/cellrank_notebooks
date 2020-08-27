#!/usr/bin/env bash

ORIGIN="https://github.com/theislab/cellrank_notebooks"


if [[ -n "${DEPLOY_TOKEN+x}" ]]; then
    echo "Pushing regenerated notebooks"
    git add tutorials/*
    git commit -m "[ci skip] Regenerate notebooks"
    git push "https://$DEPLOY_TOKEN@${ORIGIN:8}"
fi

if [[ -n "${RTD_TOKEN+x}" ]]; then
    echo "Requesting documentation rebuild"
    curl -X POST -d "branches=master" -d "token=$RTD_TOKEN" https://readthedocs.org/api/v2/webhook/cellrank/125510/
fi
