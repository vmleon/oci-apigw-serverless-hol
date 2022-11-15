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

TF_VAR_rsa_public_key=$(cat generated/hol_public_key.pem)
export TF_VAR_rsa_public_key

banner "Terraform Destroy"
cd $BASE_DIR/deploy/terraform
terraform destroy -auto-approve

cd $BASE_DIR

end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
echo "Time: $elapsed sec"
