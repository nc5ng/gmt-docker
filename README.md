# gmt-docker

Docker Image of Generic Mapping Tools [GMT HomePage](http://gmt.soest.hawaii.edu), as well as [`gmt-python`]( https://github.com/GenericMappingTools/gmt-python)

Instructions Adapted from [GMT Wiki](http://gmt.soest.hawaii.edu/projects/gmt/wiki/BuildingGMT)


**Requirements:**

 - `docker`



## Usage: Command Line Wrapper

The convenience script `gmt.sh` can be installed anywhere in path in order to simplify usage. By doing so, containerized versions of `GMT` can be run as though they are local.


```sh
$ git clone https://github.com/nc5ng/gmt-docker

# /home/user/bin is usually on path
# alternatives : /usr/local/bin

$ mkdir -p ~/bin
$ cp gmt-docker/gmt.sh ~/bin/gmt
$ chmod +x ~/bin/gmt
$ gmt --version
6.0.0_r19736

```

> **NOTE:** Docker is a container environment similar to a Virtual Machine, scripts that rely on absolute paths when using GMT tools should extend the container to package the data. When run in convenience script, ***only the local directory (and subdirectories) are hosted in the docker environment***

## Usage: Docker


Docker Container Images are available https://hub.docker.com/r/nc5ng/gmt

The following tags are provided

- `latest` default image for standard arch with latest gmt upstream
- `python` default image for python gmt toolkit [`gmt-python`]( https://github.com/GenericMappingTools/gmt-python).
- `jupyter`  enchanced `python` image with jupyter online notebook. 



### Basic Usage


```sh
# print usage
$ docker run -it --rm nc5ng/gmt --help
```


### Mounting Local Dir to run command

```sh
# All paths in current dir are valid
$ docker run -it --rm -v "$PWD:/wd" --workdir /wd nc5ng/gmt surface 
```


### Starting a gmt-python session with ipython

```sh
$ docker run -it --rm -v "$PWD:/wd" --workdir /wd nc5ng/gmt:pygmt ipython
```

### Starting a jupyter notebook session


```sh
$ docker run -p "8888:8888" -it --rm -v "$PWD:/wd" --workdir /wd nc5ng/gmt:jupyter
```

Then, connect to the device using the IP of the host computer (or local host) and the secure token printed on the command line.



## Usage: docker-compose

`docker-compose` can be used to orchestrate conversions


```docker-compose.yml
version: '2'
services:

  step-1:
    image: nc5ng/gmt
    volumes:
      - "/path/to/dataroot:/workspace:ro"
    command: surface test.xyz
      
  step-2:
    image: nc5ng/gmt
    volumes:
      - "/path/to/dataroot:/workspace:ro"
    command2: ####
    
```




