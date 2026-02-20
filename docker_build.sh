#!/usr/bin/env bash
set -euo pipefail

docker build . -t steamcmd-l4d2:0.0.1
docker image prune -f
