#!/bin/bash

HELPMSSG="
# ========================================================
# + Run it as follows ->
# >
# >   ./create-environment.sh \"Name of new environment\
# >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ========================================================
"
ENVNAME=${1}
TEMPLATESDIR="../environment-template/"
TEMPLATE="environment"
TEMPLATEFILE="${TEMPLATESDIR}/${TEMPLATE}.txt"
TFFILE="${TEMPLATE}_${ENVNAME}.tf"
MAINDIR="../"


if [ -z ${1} ]
then
  echo "$HELPMSSG"
  exit
fi

cp ${TEMPLATEFILE} ${MAINDIR}/${TFFILE}
sed -i -e "s/ENVNAME/${ENVNAME}/g" ${MAINDIR}/${TFFILE}
