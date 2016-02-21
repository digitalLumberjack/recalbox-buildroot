#!/bin/bash

version=$(cat /recalbox/recalbox.arch)
recalboxupdateurl="http://archive.recalbox.com/4"

if ! mkdir -p /recalbox/share/system/upgrade
then
    exit 1
fi

if ! wget "${recalboxupdateurl}/${version}/last/boot.tar.xz" -O /recalbox/share/system/upgrade/boot.tar.xz.part
then
    exit 1
fi

if ! wget "${recalboxupdateurl}/${version}/last/root.tar.xz" -O /recalbox/share/system/upgrade/root.tar.xz.part
then
    rm "/recalbox/share/system/upgrade/boot.tar.xz.part"
    exit 1
fi

if ! mv /recalbox/share/system/upgrade/boot.tar.xz.part /recalbox/share/system/upgrade/boot.tar.xz
then
    rm /recalbox/share/system/upgrade/boot.tar.xz.part
    rm /recalbox/share/system/upgrade/root.tar.xz.part
    exit 1
fi

if ! mv /recalbox/share/system/upgrade/root.tar.xz.part /recalbox/share/system/upgrade/root.tar.xz
then
    rm /recalbox/share/system/upgrade/boot.tar.xz
    rm /recalbox/share/system/upgrade/root.tar.xz.part
    exit 1
fi

exit 0
