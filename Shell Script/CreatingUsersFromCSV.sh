#!/bin/bash

while IFS=, read username password
do
    if [ "$username" != "username" ]; then
        useradd -m $username
        echo "$username:$password" | chpasswd
        echo "Created $username"
    fi
done < users.csv
