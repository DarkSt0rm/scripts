#!/usr/bin/env bash
# Install deps
apt-get install subversion libssl-dev libdnet-dev libpcre++-dev libpcre2-dev clang build-essential automake checkinstall  -y
# Checkout
svn checkout https://svn.nmap.org/nmap/
cd nmap
# Build using clang
CC=clang CXX=clang++ ./configure && make
# Move build files
mv ./nmap ../nmap_temp
cd ../
rm -rf nmap
mov ./nmap_temp ./nmap
