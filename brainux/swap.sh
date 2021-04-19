#!/usr/bin/env bash

if(! test -e "/swapfile"); then
    sudo dd if=/dev/zero of=/swapfile bs=1M count="${1:-1024}"
fi
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
