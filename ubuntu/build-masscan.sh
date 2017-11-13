#!/usr/bin/env bash
apt-get install git gcc make libpcap-dev clang git -y
git clone https://github.com/robertdavidgraham/masscan.git
cd masscan
make
mv ./bin/masscan ../masscan_bin
cd ../
rm -rf masscan
mv masscan_bin masscan
