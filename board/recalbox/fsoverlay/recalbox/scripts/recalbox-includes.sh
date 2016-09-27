#!/bin/bash

#
## This is a knid of header file that can be used to declare variables and functions
## That could turn useful in any recalbox script
#

#
## Variables
#

_RBX=/recalbox
_SHAREINIT=$_RBX/share_init
_SHARE=$_RBX/share

#
## Functions
#

# Checks if $1 exists in the array passed for $2
function containsElement {
  # local e
  # for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  [[ "${@:2}" =~ "$1" ]] && return 0
  return 1
}

# Upgrade the recalbox.conf if necessary
function doRbxConfUpgrade {
  # Update recalbox.conf
  cfgIn=$_SHAREINIT/system/recalbox.conf
  cfgOut=$_SHARE/system/recalbox.conf
  rbxVersion=$_RBX/recalbox.version
  curVersion=$_SHARE/system/logs/lastrecalbox.conf.update
  forced=(controllers.ps3.driver)
  savefile=${cfgOut}-pre-$(cat $rbxVersion | sed "s+[/ :]++g")

  # Check if an update is necessary
  diff -N "$curVersion" "$rbxVersion" > /dev/null 2>&1 && recallog "recalbox.conf already up-to-date" && return 0

  recallog -e "UPDATE : recalbox.conf to $(cat $rbxVersion)"
  rm $savefile 2>/dev/null
  mv $cfgOut $savefile

  # Fill an associative array with the values from the recalbox.conf
  # so we can report them back in the new recalbox.conf
  declare -A userValues
  while read -r property ; do
    name=`echo $property | cut -d '=' -f 1`
    nameRegExp=$(echo $name | sed 's/\./\\\./g')
    value=`echo -E $property | sed "s/$nameRegExp=//g"`
    userValues["$name"]="$value"
  done < <(grep -v '^[#;]\|^$' "$savefile")

  # Add each line of the share_init recalbox.conf, and decide what happens if a property is forced, custom or 
  while read -r property ; do
    name=$(echo $property | cut -d '=' -f 1)
    realname=$(echo $name | sed 's/^;//g')

    # Echo empty lines for \n
    if [[ $property == "" ]]; then
      echo "" >> $cfgOut
    # Should we force the value ?
    elif containsElement "$name" ${forced[@]}; then
      recallog "FORCING : $property"
      echo $property >> $cfgOut
      unset -v userValues["$realname"]
    elif containsElement "$realname" ${!userValues[@]}; then
      recallog "ADDING user defined to $cfgOut : $realname=${userValues[$realname]}"
      echo -E "$realname=${userValues[$realname]}" >> $cfgOut
      unset -v userValues["$realname"]
    else
      # need to protect
      recallog "ADDING default to $cfgOut : $property"
      echo $property >> $cfgOut
    fi
  done < $cfgIn

  if [[ ${#userValues[@]} -gt 0 ]] ; then
    echo -e "\n## User custom properties" >> $cfgOut
    for idx in "${!userValues[@]}" ; do
      recallog "RESTORING user specified value to $cfgOut : ${idx}=${userValues[$idx]}"
      echo "${idx}=${userValues[$idx]}" >> $cfgOut
    done
  fi
  
  # Update is done, set the right version number
  cp $rbxVersion $curVersion
  recallog "UPDATE : recalbox.conf to $(cat $rbxVersion) done. The previous file was saved to $savefile"
  return 0
}

