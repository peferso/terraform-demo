#!/bin/bash


PLAYBOOKSDIR="/home/ec2-user/tf_templates/Utilities/ansible-playbooks"
DBSETUP="db-server-setup.yml"
ANSCONFIGFILE="ansible.cfg"

create_environment_variable_ansiblecfg_dir() {
  MSSGENV="
  # ========================================================
  # + ... Using .cfg file:
  # > ${PLAYBOOKSDIR}/${1}
  # ========================================================
  "
  echo "${MSSGENV}"
  export ANSIBLE_CONFIG=${PLAYBOOKSDIR}/${1}
}

delete_environment_variable_ansiblecfg_dir() {
  unset ANSIBLE_CONFIG
}

run_ansible_playbook() {
  MSSGPLBK="
  # ========================================================
  # + ... Running the playbook: 
  # > ${PLAYBOOKSDIR}/${1}
  # ========================================================
  "
  echo "${MSSGPLBK}"
  ansible-playbook ${PLAYBOOKSDIR}/${1}
}

# Main

create_environment_variable_ansiblecfg_dir "${ANSCONFIGFILE}"

run_ansible_playbook "${DBSETUP}"

delete_environment_variable_ansiblecfg_dir 
