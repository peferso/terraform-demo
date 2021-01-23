#!/bin/bash

func_splitter() {
  str=$1
  delimiter=$2
  s=$str$delimiter
  array=();
  while [[ $s ]]; do
      array+=( "${s%%"$delimiter"*}" );
      s=${s#*"$delimiter"};
  done;  
}

pattern='{ "module":'
tfstatestring=$(cat ./terraform.tfstate)
tfstatestring=$(echo $tfstatestring)
func_splitter "$tfstatestring" "$pattern"

array_full=( "${array[@]}" ) # Store the initial array

# Iterate over array values locating module names and private ips
echo " "
echo " "
echo "----------------------------------------------------  "
echo " "
echo " "
modNames=();
for i in "${array_full[@]}"
do
  func_splitter "$i" ", "
  modNames+=${array[0]}
  for j in "${i[@]}"
  do
    func_splitter "$j" ", "
  done
done
echo " "
echo " "
echo "----------------------------------------------------  "
echo " "
echo " "




echo " "
echo " "
echo " -------------- "
echo "++ 0: ${modNames}"
