#!/bin/bash

wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -
sudo sh -c "echo 'deb https://download.jitsi.org unstable/' > /etc/apt/sources.list.d/jitsi-unstable.list"
sudo apt-get -y update
sudo apt-get -y install jitsi-meet
