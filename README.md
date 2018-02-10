# gmt-docker

Docker Image of Generic Mapping Tools [GMT HomePage](http://gmt.soest.hawaii.edu)

Instructions Adapted from [GMT Wiki](http://gmt.soest.hawaii.edu/projects/gmt/wiki/BuildingGMT)


**Requirements:**

 - `docker`
 - `docker-compose`



## Usage: Convenience Script

The convenience script `gmt.sh` can be installed anywhere in path in order to simplify usage


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

GMT can 

> **NOTE:** Docker is a container environment similar to VM, scripts that rely on absolute paths when using GMT tools may need to be reworked or hosted in an extended container in order to guarantee access to all data, when run in convenience script, only the local directory (and subdirectories) are hosted in the docker environment

## Usage: Docker


Docker Container Images are available https://hub.docker.com/g/nc5ng/gmt

The following tags are provided

- `latest` default image for standard arch



Basic Usage


```sh
# print usage
$ docker run -it --rm nc5ng/gmt --help
```

Mounting Local Dir to run command

```sh
# All paths in current dir are valid
$ docker run -it --rm -v "$PWD:/wd" --wordir /wd nc5ng/gmt surface 
```


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



### Advanced Usage