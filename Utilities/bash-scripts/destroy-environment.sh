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
# >   ./destroy-environment.sh \"Name of existing environment\"
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"

ERRMSSGA="
# ========================================================
# + Error message: 
# >
# > The environment \"${ENVNAME}\" is not running
# > The file \"${MAINDIR}/${TFFILE}\" does not exists 
# ========================================================
"

if [ -z ${1} ]
then
  echo "$HELPMSSG"
  exit
fi

exists=$( 2>/dev/null ls ${MAINDIR}/${TFFILE} )
if [ -z ${exists} ]
then
 echo "${ERRMSSGA}"
 echo "Current *tf files:"
 echo " "
 ls -lrth ${MAINDIR} | grep -i tf
 exit
fi

rm -f ${MAINDIR}/${TFFILE}

cd ${MAINDIR}/
terraform apply -auto-approve
cd -
