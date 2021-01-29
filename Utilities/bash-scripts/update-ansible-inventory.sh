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
# ========================================================
To proceed with the execution type y[yes]:
...
"


confirm() {
  echo ${INITMSSG}
  
}

find_ips () {
	cd ${MAINDIR}
	outputList=$(terraform output)
        cd -
	echo ${outputList}
}

find_ips
