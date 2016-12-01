#!/bin/bash

set -e

command_exists () {
  type "$1" &> /dev/null ;
}

if ! command_exists docker; then
  echo 'installing docker...'
  brew cask install docker-toolbox
fi

git clone git@github.com:poetic/drupal-project.git drupal
cd drupal
composer install
cd ..

docker-compose up -d
