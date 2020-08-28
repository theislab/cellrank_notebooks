#!/usr/bin/env bash

if [[ $TRAVIS_EVENT_TYPE == "push" && $TRAVIS_BRANCH == "master" && ! -z "${CR_NOTEBOOKS+x}" ]]; then
    git config --global user.name "TravisCI"
    git config --global user.email "travis@travis-ci.com"

    git checkout master
    git add -f tutorials/*
    git commit -m "[ci skip] Regenerate notebooks: $TRAVIS_BUILD_NUMBER"

    if [[ $? -eq 0 ]]; then
        echo "Pushing regenerated notebooks"

        git remote rm origin
        git remote add origin "https://$CR_NOTEBOOKS@github.com/$TRAVIS_REPO_SLUG"  >/dev/null 2>&1
        git push origin master --quiet

        if [[ $? -eq 0 && ! -z "${RTD_TOKEN+x}" ]]; then
            echo "Requesting documentation rebuild for master"
            curl -X POST -d "branches=master" -d "token=$RTD_TOKEN" https://readthedocs.org/api/v2/webhook/cellrank/125510/
        fi
    else
        echo "Nothing to commit"
    fi
fi
