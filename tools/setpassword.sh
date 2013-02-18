#!/bin/bash

# display usage
if [ $# -ne 1 ]
then
    echo "usage: $0 username"
    exit 1
fi

username=$1
#here you can use password generator, send password via email, etc.
password="password"
#echo $password
echo $password | passwd --stdin $username
