#!/bin/bash

start_time=$(date +%s)

banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

if [ -z "$BASE_DIR" ]
then
  export BASE_DIR=$(pwd)
fi

banner "Ansible Provisioning"
cd $BASE_DIR/deploy/terraform
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_NOCOWS=1
ansible-playbook -i ./generated/server.ini ../ansible/server.yaml

banner "Terraform Output"
terraform output

cd $BASE_DIR

end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
echo "Time: $elapsed sec"