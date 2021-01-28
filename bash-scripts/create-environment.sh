#!/bin/bash

ENVNAME=${1}
TEMPLATESDIR="../environment-template/"
TEMPLATE="environment"
TEMPLATEFILE="${TEMPLATESDIR}/${TEMPLATE}.txt"
TFFILE="${TEMPLATE}_${ENVNAME}.tf"
MAINDIR=".."

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
if [ -z ${exists} ]
then
 echo "File template ${MAINDIR}/${TFFILE} does not exists"
else
 echo "${ERRMSSGA}"
 echo " "
 echo "Current *tf files:"
 echo " "
 ls -lrth .. | grep -i tf
 exit
fi

echo "... Creating template"
cp ${TEMPLATEFILE} ${MAINDIR}/${TFFILE}
sed -i -e "s/ENVNAME/${ENVNAME}/g" ${MAINDIR}/${TFFILE}

cd ..
echo "... updating modules"
terraform init

echo "... applying changes"
terraform apply -auto-approve

echo ""
echo "Infrastructure created."
echo ""
cd -
