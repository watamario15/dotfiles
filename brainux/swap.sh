#!/usr/bin/env bash

if(! test -e "/swapfile"); then
    dd if=/dev/zero of=/swapfile bs=1M count="${1:-1024}"
fi
chmod 0600 /swapfile
mkswap /swapfile
swapon /swapfile
