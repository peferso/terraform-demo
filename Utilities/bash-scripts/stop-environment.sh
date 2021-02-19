#!/bin/bash

ENVNAME=${1}
TAGKEY=${2}
TAGVAL=${3}
TEMPLATESDIR="../environment-template/"
ENV_TEMPLATE="environment"
ENV_TEMPLATEFILE="${TEMPLATESDIR}/${ENV_TEMPLATE}.txt"
ENV_TFFILE="${ENV_TEMPLATE}_${ENVNAME}.tf"
STOP_TEMPLATE="stop"
STOP_TEMPLATEFILE="${TEMPLATESDIR}/${STOP_TEMPLATE}.txt"
STOP_TFFILE="${STOP_TEMPLATE}_${ENVNAME}.tf"
MAINDIR="../.."
hh=$(date +%H)
mm=$(( $(date +%M) + 2))
DD=$(date +%d)
MM=$(date +%m)
YY=$(date +%Y)
SCHEDULE=$(echo "${mm} ${hh} ${DD} ${MM} ? ${YY}")

HELPMSSG="
# ========================================================
# + Run it as follows ->
# >
# >   ./stop-environment.sh \"Name of environment\"
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# >
# > Or specify environment, tag and value
# >
# >   ./stop-environment.sh \"Name of environment\" \"tag\" \"value\"
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# >
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
# > The environment \"${ENVNAME}\" is not running
# > The file \"${MAINDIR}/${ENV_TFFILE}\" does not exists
# ========================================================
"

STEPINFO_1="
# ========================================================
# > ... Creating stop template
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
# + ... infrastructure modified.
# ========================================================
"

readInput() {
  if [ "$#" == "1" ]
  then
    KEY="Environment"
    VAL="${ENVNAME}"
  elif [ "$#" == "3" ]
  then
    KEY="${2}"
    VAL="${3}"
  else 
    echo "$HELPMSSG"
    exit
  fi
  echo "
# ========================================================  
# + A CloudWatch rule locating instances with the tag
# >
# - ${KEY} = ${VAL}
# >
# > will be created.
# >
# > Stopping instances with CRON schedule:
# >
# - ${SCHEDULE}
# >
# + Stopping environment \"${ENVNAME}\"...
# ========================================================
"
}

checkEnvNameFormat() {
  if [[ "${ENVNAME}" =~ ^[a-zA-Z0-9_-]+$ ]]
  then
    echo "Environment name: \"${ENVNAME}\" has the correct format"
  else
    echo "${ERRMSSGA}"
    exit
  fi
}

checkEnvExistence() {
  exists=$( 2>/dev/null ls ${MAINDIR}/${ENV_TFFILE} )
  if [ "${ENVNAME}" == "Standard" ]
  then
    echo "Stopping Standard environment"
  elif [ -z "${exists}" ] 
  then
    echo "${ERRMSSGB}"
    echo " "
    echo "Current *tf files:"
    echo " "
    ls -lrth ${MAINDIR} | grep -i tf
    exit
  else
    echo "Stopping ${ENVNAME} environment"
    echo "File template ${MAINDIR}/${ENV_TFFILE} does not exists"
  fi
}

stopEnvironment() {
  echo "${STEPINFO_1}"
  cp ${STOP_TEMPLATEFILE} ${MAINDIR}/${STOP_TFFILE}
  sed -i -e "s/RSCHEDULE/${SCHEDULE}/g" ${MAINDIR}/${STOP_TFFILE}
  sed -i -e "s/RKEY/${KEY}/g" ${MAINDIR}/${STOP_TFFILE}
  sed -i -e "s/RVAL/${VAL}/g" ${MAINDIR}/${STOP_TFFILE}
  sed -i -e "s/ENVNAME/${ENVNAME}/g" ${MAINDIR}/${STOP_TFFILE}

  echo "${STEPINFO_2}"
  cd ${MAINDIR}/
  terraform init

  echo "${STEPINFO_3}"
  terraform apply -auto-approve

  echo "${STEPINFO_4}"
  cd -
}

readInput ${ENVNAME} ${TAGKEY} ${TAGVAL}

checkEnvNameFormat

checkEnvExistence

stopEnvironment

