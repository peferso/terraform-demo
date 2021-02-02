#!/bin/bash

PLAYBOOKSDIR="../ansible-playbooks"
DBSETUP="db-server-setup.yml"

run_ansible_playbook() {
  ansible-playbook ${PLAYBOOKSDIR}/${1}
}

run_ansible_playbook "${DBSETUP}"
