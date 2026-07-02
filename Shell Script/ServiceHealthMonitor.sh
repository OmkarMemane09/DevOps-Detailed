#!/bin/bash

SERVICE="nginx"

systemctl is-active --quiet $SERVICE

if [ $? -eq 0 ]
then
    echo "$SERVICE is Running"
else
    echo "$SERVICE is Down"
    systemctl restart $SERVICE
fi
