#!/usr/bin/env bash

dd if=/dev/zero of=/swapfile bs=1M count="${1:-1024}"
chmod 0600 /swapfile
mkswap /swapfile
swapon /swapfile
