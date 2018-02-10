#!/bin/bash
# Install Script for docker-gmt image
# Run Inside Base Image





DCW_VERSION=${DCW_VERSION-1.1.3}
GSHHG_VERSION=${GSHHG_VERSION-2.3.7}
GMT_BRANCH=${GMT_BRANCH-trunk}




GMT_SVN=${GMT_SVN-svn://gmtserver.soest.hawaii.edu/gmt/$GMT_BRANCH}
GMT_DCW_FTP=${GMT_DCW_FTP-ftp://ftp.soest.hawaii.edu/dcw/dcw-gmt-$DCW_VERSION.zip}
GMT_GSHHG_FTP=${GMT_GSHHG_FTP-ftp://ftp.soest.hawaii.edu/gshhg/gshhg-gmt-$GSHHG_VERSION.tar.gz}




echo "Downloading DCW - $DCW_VERSION from $GMT_DCW_FTP"
wget $GMT_DCW_FTP
unzip dcw-gmt-$DCW_VERSION.zip

echo "Downloading GSHHG - $GMT_GSSHG_FTP from $GMT_GSHHG_FTP"
wget $GMT_GSHHG_FTP
tar -xzf gshhg-gmt-$GSHHG_VERSION.tar.gz

echo "Fetching  $GMT_BRANCH from $GMT_SVN"
svn checkout $GMT_SVN gmt



echo "Preparing Build Environment"
mkdir build
CMAKE_INSTALL_PREFIX=/opt/gmt
GSHHG_ROOT=$PWD/gshhg-gmt-$GSHHG_VERSION
DCW_ROOT=$PWD/dcw-gmt-$DCW_VERSION

echo "Building GMT, may take a while"
(cd build; cmake ../gmt && make && make install)





