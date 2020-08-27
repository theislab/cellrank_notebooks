#!/usr/bin/env bash

ORIGIN="https://github.com/theislab/cellrank_notebooks"


echo "Pushing regenerated notebooks"
git add -f tutorials/*
git commit -m "[ci skip] Regenerate notebooks"
git push "https://$DEPLOY_TOKEN@${ORIGIN:8}"

echo "Requesting documentation rebuild for master"
curl -X POST -d "branches=master" -d "token=$RTD_TOKEN" https://readthedocs.org/api/v2/webhook/cellrank/125510/
