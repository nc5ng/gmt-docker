#!/bin/bash
# Install Script for docker-gmt image
# Run Inside Base Image





DCW_VERSION=${DCW_VERSION:-1.1.3}
GSHHG_VERSION=${GSHHG_VERSION:-2.3.7}
GMT_BRANCH=${GMT_BRANCH:-trunk}
GMT_CMAKE_ARGS=${GMT_CMAKE_ARGS:-""}




GMT_SVN=svn://gmtserver.soest.hawaii.edu/gmt/$GMT_BRANCH
GMT_DCW_FTP=ftp://ftp.soest.hawaii.edu/dcw/dcw-gmt-$DCW_VERSION.tar.gz
GMT_GSHHG_FTP=ftp://ftp.soest.hawaii.edu/gshhg/gshhg-gmt-$GSHHG_VERSION.tar.gz



echo "Downloading DCW - $DCW_VERSION from $GMT_DCW_FTP"
wget $GMT_DCW_FTP
tar -xzf dcw-gmt-$DCW_VERSION.tar.gz

echo "Downloading GSHHG - $GMT_GSSHG_FTP from $GMT_GSHHG_FTP"
wget $GMT_GSHHG_FTP
tar -xzf gshhg-gmt-$GSHHG_VERSION.tar.gz

echo "Fetching  $GMT_BRANCH from $GMT_SVN"
svn checkout $GMT_SVN gmt-src



echo "Preparing Build Environment"
mkdir build
CMAKE_INSTALL_PREFIX=/opt/gmt

mkdir -p $(CMAKE_INSTALL_PREFIX)

GSHHG_ROOT=$PWD/gshhg-gmt-$GSHHG_VERSION
DCW_ROOT=$PWD/dcw-gmt-$DCW_VERSION

export GCW_VERSION GSHHG_VERSION GSHHG_ROOT DCW_ROOT DCW_VERSION

echo "Building GMT, may take a while"
(cd build; cmake $GMT_CMAKE_ARGS CMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX GSHHG_ROOT=$GSHHG_ROOT DCW_ROOT=$DCW_ROOT DCW_VERSION=$DCW_VERSION GSSHG_VERSION=$GSSHG_VERSION ../gmt-src && make && make install)





