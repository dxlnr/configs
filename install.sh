#!/usr/bin/env bash
set -e

SUDO=""

if [[ ! $(id -u) -eq 0 ]]; then
  if [[ -z $(which sudo) ]]; then
    echo "Please run as root"
    exit 1
  fi
  SUDO="sudo"
fi

function install_ubuntu() {
  $SUDO apt-get update
  $SUDO apt-get install -y --no-install-recommends \
    git \
    curl \
    cmake \
    gettext \
    ripgrep
}

install_ubuntu
