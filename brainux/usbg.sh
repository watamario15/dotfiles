#!/usr/bin/env bash

g=/sys/kernel/config/usb_gadget/eth

mkdir ${g}

mkdir ${g}/functions/rndis.rn0
echo "8a:15:8b:44:3a:02" > ${g}/functions/rndis.rn0/dev_addr
echo "8a:15:8b:44:3a:01" > ${g}/functions/rndis.rn0/host_addr

mkdir ${g}/configs/c.1
ln -s ${g}/functions/rndis.rn0 ${g}/configs/c.1/

echo "ci_hdrc.0" > ${g}/UDC

sleep 1
ifconfig usb0 up
sleep 1
dhclient
