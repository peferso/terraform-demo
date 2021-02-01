#!/bin/bash

ENVNAME=${1}
TEMPLATESDIR="../environment-template/"
TEMPLATE="environment"
TEMPLATEFILE="${TEMPLATESDIR}/${TEMPLATE}.txt"
TFFILE="${TEMPLATE}_${ENVNAME}.tf"
MAINDIR="../.."

HELPMSSG="
# ========================================================
# + Run it as follows ->
# >
# >   ./create-environment.sh \"Name of new environment\"
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"

ERRMSSGA="
# ========================================================
# + The environment name should not contain white spaces.
# > It should consists of alphanumeric characters 
# > plus \"-\" and \"_\".
# + Examples:
# >  \"dev01\"
# >  \"dev-23\"
# >  \"env_100-32\"
# ========================================================
"

ERRMSSGB="
# ========================================================
# + Error message:
# >
# > The environment \"${ENVNAME}\" is running
# > The file \"${MAINDIR}/${TFFILE}\" already exists
# ========================================================
"

STEPINFO_1="
# ========================================================
# + ... Creating environment template 
# ========================================================
"
STEPINFO_2="
# ========================================================
# + ... updating Terraform modules 
# ========================================================
"
STEPINFO_3="
# ========================================================
# + ... applying changes to the configuration 
# ========================================================
"
STEPINFO_4="
# ========================================================
# + ... infrastructure created. 
# ========================================================
"



readInput() {
  if [ -z "${1}" ]
  then
    echo "$HELPMSSG"
    exit
  fi
}

checkEnvNameFormat() {
  if [[ "${ENVNAME}" =~ ^[a-zA-Z0-9_-]+$ ]]
  then
    echo "${ENVNAME}"
  else
    echo "${ERRMSSGA}"
    exit
  fi
}

checkEnvExistence() {
  exists=$( 2>/dev/null ls ${MAINDIR}/${TFFILE} )
  if [ -z "${exists}" ]
  then
    echo "File template ${MAINDIR}/${TFFILE} does not exists"
  else
    echo "${ERRMSSGB}"
    echo " "
    echo "Current *tf files:"
    echo " "
    ls -lrth ${MAINDIR} | grep -i tf
    exit
  fi
}

createEnvironment() {
  echo "${STEPINFO_1}"
  cp ${TEMPLATEFILE} ${MAINDIR}/${TFFILE}
  sed -i -e "s/ENVNAME/${ENVNAME}/g" ${MAINDIR}/${TFFILE}
  
  echo "${STEPINFO_2}"
  cd ${MAINDIR}/
  terraform init
  
  echo "${STEPINFO_3}"
  terraform apply -auto-approve
  
  echo "${STEPINFO_4}"
  cd -
}

readInput ${ENVNAME}

checkEnvNameFormat

checkEnvExistence

createEnvironment

