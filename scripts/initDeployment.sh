#!/bin/bash

#parameters and config
project=$(basename $PWD)
keyname=$(openssl rand -base64 3)
password=$(openssl rand -base64 12)

export IPFS_PATH="$PWD/_deployment/.ipfs"

#preparation
rm -rf $IPFS_PATH
mkdir -p $IPFS_PATH

#download ipfs
rm -rf $PWD/_deployment/kubo
latest=`curl -s -o- https://api.github.com/repos/ipfs/kubo/releases/latest | grep -oP '"https.*releases/download/.*kubo_.*linux-amd64.tar.gz"' | sed 's/"//g'`
wget -qO- $latest | tar xz -C $PWD/_deployment

#generate key and export
$PWD/_deployment/kubo/ipfs init >/dev/null
$PWD/_deployment/kubo/ipfs key gen $keyname >/dev/null
$PWD/_deployment/kubo/ipfs key export $keyname --format=pem-pkcs8-cleartext --output="$PWD/_deployment/${project}.pem"

ipns=$($PWD/_deployment/kubo/ipfs key list -l | grep $keyname | head -n 1 | awk '{print $1;}')
$PWD/_deployment/kubo/ipfs key rm $keyname >/dev/null

#output configuration information
echo "---------------------------"
echo "IPNS Deployment Information"
echo "---------------------------"
echo "Add following DNS record:"
echo "_dnslink.$project 3600 IN TXT dnslink=/ipns/$ipns"
echo ""
echo "Set following Secret Variables in Github:"
echo ""
echo "IPNS_KEY = $(cat _deployment/$project.pem)"
echo "PINT_PASSWORD = [get from passwordsafe]"
echo "PINT_USERNAME = [get from passwordsafe]"
echo ""
echo ""
echo "Set following Variables in Github:"
echo ""
echo "PINT_URL = https://chixodo.xyz/pint/"
echo "NODE_1 = /ip4/185.143.45.58/tcp/4001/p2p/12D3KooWPE1U1x31QteygQ7a34tzqx5FFJ3B5ttrfWjAqTn8kHo1"
echo "NODE_2 = /ip4/195.15.245.11/tcp/4001/p2p/12D3KooWRHKJzo1ajNGBJnjeaunXXL9jNkEwsEi32KHMQkS5pm3t"
