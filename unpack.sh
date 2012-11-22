#!/bin/sh

mkdir /lib/modules/$(uname -r)/kernel/drivers/net/wireless/libertas_uap
cp uap8xxx.ko-3.2.9-kirkwood /lib/modules/$(uname -r)/kernel/drivers/net/wireless/libertas_uap
depmod -a
cp -r firmware/mrvl /lib/firmware/mrvl
cp modprobe_libertas_uap.conf /etc/modprobe.d/libertas_uap
