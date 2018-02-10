from ubuntu:16.04

LABEL maintainer="akshmakov@nc5ng.org"

WORKDIR /workspace
ENV DCW_VERSION=1.1.3 GSHHG_VERSION=2.3.7 GMT_BRANCH=trunk 
COPY install.sh /workspace

## Do This in One Go to Minimize Docker Image Size

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
	    libnetcdf-dev \
	    libgdal1-dev \
	    libfftw3-dev \
	    libpcre3-dev \
	    liblapack-dev \
	    libblas-dev \
	    graphicsmagick \
	    wget &&\
    ./install.sh && \
    rm -rf /workspace && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/gmt"]
