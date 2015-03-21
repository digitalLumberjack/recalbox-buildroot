#!/bin/bash

system_settings=/recalbox/share/system/recalbox.conf

command="$1"
argsetting="$2"
log=/root/recalbox.log

if [[ "$command" == "get" ]];then
	echo "`logtime` : systemsetting.sh - searching for $argsetting" >> $log
	setting=`cat "$system_settings" | sed -n "s/^${argsetting}=\(.*\)/\1/p"`
	if [[ "$?" != "0" ]]; then
		exit 1
	fi
	if [[ "$setting" != "" ]]; then
		echo "`logtime` : systemsetting.sh - $argsetting found : $setting" >> $log
		echo $setting
		exit 0
	fi
fi
if [[ "$command" == "set" ]];then 
        echo "`logtime` : systemsetting.sh - setting $varname to $newval" >> $log
	sed -i "s|^${argsetting}=\".*\"|^${argsetting}=\"${newval}\"|g" $system_settings
fi
exit 1

