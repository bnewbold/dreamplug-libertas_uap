#!/bin/sh

set -e

if ! [ `uname -r` = "3.2.9-kirkwood" ]
then
    echo "Got: `uname -r`, need 3.2.9-kirkwood"
    echo "Wrong kernel version, binary module won't work. Try a source install?"
    exit 1
fi

echo "git fetching kernel module binaries..."
rm -rf /tmp/dpla
git clone --depth 1 http://github.com/bnewbold/dreamplug-libertas_uap /tmp/dpla
cd /tmp/dpla

echo "installing..."
mkdir -v /lib/modules/$(uname -r)/kernel/drivers/net/wireless/libertas_uap
cp -v uap8xxx.ko-3.2.9-kirkwood /lib/modules/$(uname -r)/kernel/drivers/net/wireless/libertas_uap
depmod -a
cp -vr firmware/mrvl /lib/firmware/mrvl
cp -v modprobe_libertas_uap.conf /etc/modprobe.d/libertas_uap

echo "installed, probably need to reboot now?"
