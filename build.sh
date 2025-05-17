#!/usr/bin/env bash

OCTOPI_VERSION="1.1.0"
OCTOPI_DOWNLOAD_URL="https://github.com/guysoft/OctoPi/releases/download/${OCTOPI_VERSION}/octopi-bookworm-armhf-lite-${OCTOPI_VERSION}.zip"

echo "Grab OctoPi image"
mkdir --parents workspace
cd workspace || exit
curl \
  --location \
  --output octopi.zip \
  "${OCTOPI_DOWNLOAD_URL}"
unzip -n octopi.zip
rm octopi.zip
find . -name '*.img' -exec mv -v {} input.img \;

echo "Run CustoPiZer"
cd ..
docker run \
  --rm \
  --privileged \
  --volume "$(pwd)/workspace:/CustoPiZer/workspace" \
  --volume "$(pwd)/scripts:/CustoPiZer/workspace/scripts" \
  ghcr.io/octoprint/custopizer:latest
