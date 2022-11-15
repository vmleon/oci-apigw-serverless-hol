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

banner "Generate RSA Public and Private Keys"
rm -rf $BASE_DIR/generated
mkdir $BASE_DIR/generated
cd $BASE_DIR/generated
openssl genrsa -out hol_private_key.pem  4096
openssl rsa -pubout -in hol_private_key.pem -out hol_public_key.pem

cd $BASE_DIR

end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
echo "Time: $elapsed sec"
