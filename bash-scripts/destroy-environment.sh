#!/bin/bash

ENVNAME=${1}
TEMPLATESDIR="../environment-template/"
TEMPLATE="environment"
TEMPLATEFILE="${TEMPLATESDIR}/${TEMPLATE}.txt"
TFFILE="${TEMPLATE}_${ENVNAME}.tf"
MAINDIR="../"

HELPMSSG="
# ========================================================
# + Run it as follows ->
# >
# >   ./destroy-environment.sh \"Name of existing environment\
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

exists=$( 2>1 ls ${MAINDIR}/${TFFILE} )
if [ -z ${exists} ]
then
 echo "${ERRMSSGA}"
 exit
fi

rm -f ${MAINDIR}/${TFFILE}

cd ..
terraform apply -auto-approve
cd -
