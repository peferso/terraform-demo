#!bin/bash

ENVNAME=$1
TEMPLATESDIR="../environment-template/"
TEMPLATE="environment"
TEMPLATEFILE="${TEMPLATESDIR}/${TEMPLATE}.txt"
TFFILE="${TEMPLATE}_ENVNAME.tf"
MAINDIR="../"


if [ -z $1 ]
then
  echo $HELPMSSG
fi

cp ${TEMPLATEFILE} ${MAINDIR}/${TFFILE}
sed -i -e 's/NAME/${ENVNAME}' ${TFFILE}
