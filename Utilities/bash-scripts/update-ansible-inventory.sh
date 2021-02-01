#!/bin/bash

MAINDIR="../.."
HOSTSFILE="/etc/ansible/hosts"
INITMSSG="
# ========================================================
# + Script: update-ansible-inventory.sh
# >
# > Bash script that retrieves the list of running EC2
# > instances and private ip's and consistently updates
# > the list of Ansible managed hosts:
# >  /etc/ansible/hosts
# > 
# + To run it just call:
# >    ./update-ansible-inventory.sh -a
# >    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"


confirm() {
  if [ "$1" != "-a" ]
  then
    echo "${INITMSSG}"
    exit
  fi
}

find_ips () {
  cd ${MAINDIR}

  outputList="$(terraform output | grep -i privateIp)"

  delimiter="="
  modNames=();
  insPrvIP=();
  while IFS= read -r line
  do
    partLeftt=${line%%"$delimiter"*}
    partRight=${line#*"$delimiter"}
    partRight=$( echo  "${partRight//\"/}"  )
    modNames+=( ${partLeftt} );
    insPrvIP+=( ${partRight} );
    echo "Line:"
    echo "$line"
    echo "${partLeftt}"
    echo "${partRight}"
    echo " "

  done <<< "${outputList}"
  
  echo " ${modNames[@]} "
  echo " ${insPrvIP[@]} "

  cd -
}

confirm $1

find_ips
