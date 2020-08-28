#!/usr/bin/env bash

echo "Pushing regenerated notebooks"

git config --global user.name "TravisCI"
git config --global user.name "travis@travis-ci.com"

git add tutorials/*
git commit --allow-empty -m "[ci skip] Regenerate notebooks"
git push "https://$CR_NOTEBOOKS@github.com/$TRAVIS_REPO_SLUG" origin master

echo "Requesting documentation rebuild for master"
curl -X POST -d "branches=master" -d "token=$RTD_TOKEN" https://readthedocs.org/api/v2/webhook/cellrank/125510/
