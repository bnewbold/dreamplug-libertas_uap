#!/bin/sh

set -e

echo "installing required packages..."
#apt-get update
apt-get install -y module-assistant linux-headers-kirkwood build-essential git-core

echo "git fetching kernel module src..."
rm -rf /tmp/dpla
git clone --depth 1 http://github.com/bnewbold/dreamplug-libertas_uap /tmp/dpla

echo "building..."
cd /tmp/dpla/libertas_uap
make CONFIG_LIBERTAS_UAP=m -C /lib/modules/$(uname -r)/build M=$(pwd)

echo "installing..."
mkdir -pv /lib/modules/$(uname -r)/kernel/drivers/net/wireless/libertas_uap
cp -v uap8xxx.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless/libertas_uap/uap8xxx.ko
depmod -a
cd ..
cp -vr firmware/mrvl /lib/firmware/mrvl
cp -v modprobe_libertas_uap.conf /etc/modprobe.d/libertas_uap

echo "installed, probably need to reboot now?"
