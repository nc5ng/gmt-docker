# gmt-docker

Docker Image of Generic Mapping Tools [GMT HomePage](http://gmt.soest.hawaii.edu), as well as [`gmt-python`]( https://github.com/GenericMappingTools/gmt-python)

Instructions Adapted from [GMT Wiki](http://gmt.soest.hawaii.edu/projects/gmt/wiki/BuildingGMT)


**Requirements:**

 - `docker`



## Usage: Command Line Wrapper

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

The following tags are provided.


- `latest` Latest gmt upstream trunk code (updated regularly, but, not on every commit)
- `python` `latest` with  python gmt toolkit [`gmt-python`]( https://github.com/GenericMappingTools/gmt-python).
- `jupyter`  enchanced `python` image with jupyter online notebook, same version of gmt as `latest`. 
- `6`, `6-python`, `6-jupyter` more stable images featuring 6.0 builds
- `6.0.0_r20469`, `6.0.0_r20469-python`, `6.0.0_r20469-jupyter`, ... Fixed tags for specific versions and build numbers (Never Updated)


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




