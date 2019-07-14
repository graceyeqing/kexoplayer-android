#!/bin/bash -exu

VERSION="$1"

# Make sure BINTRAY_USER and BINTRAY_KEY are exported

MYDIR=$(cd $(dirname $0); pwd)
TEMPLATE_DIR="$MYDIR/template"
WORK_DIR="$MYDIR/work"

mkdir "$WORK_DIR"
cd "$WORK_DIR"

## Step 1: Download ExoPlayer
curl -L https://github.com/google/ExoPlayer/archive/r$VERSION.tar.gz | tar -xz

## Step 2: Prepare the sources
$MYDIR/prepare.sh "ExoPlayer-r$VERSION" dist
	
## Step 3: Build
cd dist
./gradlew publishReleasePublicationToMavenLocal

## Step 4: Push to Bintray
./gradlew bintrayUpload -PbintrayUser=$BINTRAY_USER -PbintrayKey=$BINTRAY_KEY -PdryRun=false
	