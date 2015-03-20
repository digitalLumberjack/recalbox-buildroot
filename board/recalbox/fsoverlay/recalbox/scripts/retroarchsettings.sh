#!/bin/bash

retroarch_settings=/recalbox/configs/retroarch/retroarchcustom.cfg

command="$1"
argsetting="$2"
newval="$3"
log=/root/recalbox.log

if [[ "$command" == "set" ]];then
        echo "`logtime` : retroarchsetting.sh - setting $argsetting to $newval" >> $log
        sed -i "s#^\(${argsetting} *= *\).*#\1\"$newval\"#" $retroarch_settings
fi
exit 1
