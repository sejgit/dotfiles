#!/bin/bash

### Platform Specific Installation Methods


# Debian, or Debian based distros.

#You may need to install the package software-properties-common to use apt-add-repository command.

sudo apt-get install software-properties-common


# After installing software-properties-common, you can run these commands. Updates will be as normal with all debian packages.

sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B
sudo apt-key update
sudo apt-get update
sudo apt-get install drive

