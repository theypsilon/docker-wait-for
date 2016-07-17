#!/usr/bin/env bash

set -euo pipefail

source scripts/common.source


readonly MODIFIED_FILES=$(git ls-files -m)
if [[ "${MODIFIED_FILES}" != "" ]] ; then
	echo "ERROR: Following files are in a modified status, commit them or stash them."
	echo "${MODIFIED_FILES}"
	exit 1
fi

readonly VERSION=$(get_candidate_version "$@")
readonly RELEASE_BRANCH=release-${VERSION}

git checkout ${BRANCH} -b ${RELEASE_BRANCH}

cleanup() {
	git checkout ${BRANCH}
	git tag -d ${VERSION} || true
	git branch -D ${RELEASE_BRANCH} || true
}

trap cleanup EXIT

./build.sh

cp README.latest.md README.md

sed -i -e "s/latest/${VERSION}/g" README.md
git add README.md
git commit -m "New version ${VERSION}" 

git tag -a ${VERSION} -m "Version ${VERSION}"

git checkout ${VERSION}

./scripts/tag.sh
./scripts/push.sh

git push origin ${VERSION}

git checkout latest
git pull
git merge ${RELEASE_BRANCH}
git branch -D ${RELEASE_BRANCH}
git push origin latest
