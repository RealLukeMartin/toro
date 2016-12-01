#!/bin/bash

set -e

command_exists () {
  type "$1" &> /dev/null ;
}

if ! command_exists docker; then
  echo 'installing docker...'
  brew cask install docker-toolbox
fi

if ! command_exists dinghy; then
  echo 'installing dinghy...'
  brew tap codekitchen/dinghy
  brew install dinghy
fi

dinghy create --provider virtualbox
eval $(dinghy env)

git clone git@github.com:poetic/drupal-project.git drupal
cd drupal
composer run-script pre-install-cmd
composer install
composer run-script drupal-scaffold
composer run-script post-install-cmd
cd ..

docker-compose up -d
