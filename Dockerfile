## Dockerfile for Base GMT Image nc5ng/gmt for 6.0.0 branch
##     (Currently master)
##
## Approach: Perform development build in situ
##
## Construct and delete the build environment.
## This reduces image size at expense of longer build.
## Also fetch DCW/GSSHG data first, this extends layer cache
## between subsequent builds (less to re-download)
##

FROM ubuntu:16.04
LABEL maintainer="akshmakov@nc5ng.org"

## Part 1: Fetch Static Data

ARG GSHHG_VERSION=2.3.7
ARG DCW_VERSION=1.1.4
ENV GMT_DCW_FTP=ftp://ftp.soest.hawaii.edu/dcw/dcw-gmt-$DCW_VERSION.tar.gz GMT_GSHHG_FTP=ftp://ftp.soest.hawaii.edu/gshhg/gshhg-gmt-$GSHHG_VERSION.tar.gz

RUN apt-get update             		 &&\
    apt-get install -y			   \
    	    wget			 &&\
    (					   \
      mkdir -p /opt/gmt                  &&\
      cd /opt/gmt				 &&\
      wget $GMT_DCW_FTP                  &&\
      wget $GMT_GSHHG_FTP		 &&\
      tar -xzf gshhg-gmt-$GSHHG_VERSION.tar.gz &&\
      tar -xzf dcw-gmt-$DCW_VERSION.tar.gz &&\
      rm -f *.tar.gz                       \
    )                                    &&\
    apt-get purge -y wget                   &&\
    rm -rf /var/lib/apt/lists/*          


## Part 2: Download and Build GMT

COPY install.sh /opt/gmt/install.sh
ARG GMT_BRANCH=trunk
ARG GMT_CMAKE_ARGS=""	    

RUN apt-get update -y && \
    apt-get install -y \
    	    software-properties-common \
	    python-software-properties && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y \
    	    subversion \
	    build-essential \
	    cmake \
	    libcurl4-gnutls-dev \
	    libnetcdf11 \
	    libnetcdf-dev \
	    libgdal1i \
	    libgdal1-dev \
	    libfftw3-3 \
	    libfftw3-dev \
	    libpcre3     \
	    libpcre3-dev \
	    liblapack3    \
	    liblapack-dev \
	    libblas-dev \
	    graphicsmagick  &&\
    (			\
        cd /opt/gmt 	&&\	
    	./install.sh fetch_src &&\
	./install.sh build  &&\
	./install.sh clean_src \
    ) 		     	       &&\
    apt-get purge  -y \
    	    subversion \
	    build-essential \
	    cmake \
	    libnetcdf-dev \
	    libgdal1-dev \
	    libfftw3-dev \
	    libpcre3-dev \
	    liblapack-dev \
	    graphicsmagick \    
    	    software-properties-common \
	    python-software-properties && \
    apt-get autoremove -y &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/gmt"]
