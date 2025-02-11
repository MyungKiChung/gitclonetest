#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "please give me employee identification number and password"
    exit 1
fi

if sudo -v; then
    echo "sudo permission granted"
else
    echo "sudo permission is required to install pclient."
    exit 1
fi

#if [ -e "pclient_setup.deb" ]; then
#    echo "File $filename exists in the current directory. Skip Download"
#else
    echo "Download deb package"
    wget http://10.10.10.181/pclient_setup.deb -O pclient_setup.deb
#fi

echo "Install downloaded Package"
sudo dpkg -i pclient_setup.deb

if command -v authctl > /dev/null 2>&1; then
    echo "authctl installed Successfully."
else
    echo "Failed to install authctl"
    exit 1
fi

authctl login $1 $2
sudo systemctl restart authserviced
authctl stats
