#!/bin/bash

PLAYBOOKSDIR="../ansible-playbooks"
DBSETUP="db-server-setup.yml"

run_ansible_playbook() {
  ansible ${PLAYBOOKSDIR}/${1}
}

run_ansible_playbook "${DBSETUP}"
