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
# >   ./create-environment.sh \"Name of new environment\
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"

ERRMSSGA="
# ========================================================
# + Error message:
# >
# > The environment \"${ENVNAME}\" is running
# > The file \"${MAINDIR}/${TFFILE}\" already exists
# ========================================================
"
  
if [ -z ${1} ]
then
  echo "$HELPMSSG"
  exit
fi

exists=$( 2>1 ls ${MAINDIR}/${TFFILE} )
if [ -n ${exists} ]
then
 echo "${ERRMSSGA}"
 exit
fi


cp ${TEMPLATEFILE} ${MAINDIR}/${TFFILE}
sed -i -e "s/ENVNAME/${ENVNAME}/g" ${MAINDIR}/${TFFILE}
