#!/bin/bash

system_settings=/recalbox/share/system/recalbox.conf
custom_system_settings=/recalbox/share/system/custom_recalbox.conf

command="$1"
argsetting="$2"
log=/root/recalbox.log

if [[ "$command" == "get" ]];then
	echo "`logtime` : systemsetting.sh - searching for settings $argsetting" >> $log
	csetting=`cat "$custom_system_settings" | sed -n "s/^${argsetting}=\(.*\)/\1/p"`
	if [[ "$?" != "0" ]]; then
		exit 1
	fi
	if [[ "$csetting" != "" ]]; then
		echo "`logtime` : systemsetting.sh - customsetting $argsetting found : $csetting" >> $log
		echo $csetting
		exit 0
	else
	        setting=`cat "$system_settings" | sed -n "s/^${argsetting}=\(.*\)/\1/p"`
	        if [[ "$setting" != "" ]]; then
	               echo "`logtime` : systemsetting.sh - defaultsetting $argsetting found : $setting" >> $log
		       echo $setting
		       exit 0
	        fi
	fi
fi
exit 1
