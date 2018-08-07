# gmt-docker

[Docker Hub Link](https://hub.docker.com/r/nc5ng/gmt)

Docker Image of Generic Mapping Tools [GMT HomePage](http://gmt.soest.hawaii.edu), as well as [`GMT/Python`]( https://github.com/GenericMappingTools/gmt-python)

Instructions Adapted from [GMT Wiki](http://gmt.soest.hawaii.edu/projects/gmt/wiki/BuildingGMT)


**Requirements:**

 - `docker`



## Usage: Command Line Wrapper


Download the command line wrapper from the git repository

```sh
# Get Code
$ git clone https://github.com/nc5ng/gmt-docker

# /home/user/bin is usually on path
# alternatives : /usr/local/bin
$ mkdir -p ~/bin
$ cp gmt-docker/gmt.sh ~/bin/gmt
$ chmod +x ~/bin/gmt
$ gmt --version
6.0.0_r19736

# plot something
$ gmt pscoast -JM10.0i -R235.0/294.0/24.0/50.0 -Cblue -N2  > conus.ps
```

The wrapper script is a simplistic shortcut, feel free to use the same approach
to define an alias or your own ~/bin/gmt convenience script. The docker tag can be specified with environment variable `$DOCKER_GMT_VERSION`. 


> **NOTE:** Docker is a container environment similar to a Virtual Machine, scripts that rely on absolute paths when using GMT tools should extend the container to package the data. When run in convenience script, ***only the local directory (and subdirectories) are hosted in the docker environment***

## Usage: Docker


Docker Container Images are available https://hub.docker.com/r/nc5ng/gmt

The following tags are provided.


- **`latest`** Latest gmt upstream trunk code. Currently following 6.0.0 Development. Updated regularly, but not on every commit
- **`python`** ,  [`GMT/Python`]( https://github.com/GenericMappingTools/gmt-python) pre-installed. Updated every time `latest` is updated
- **`jupyter`**  enhanced `python` image with jupyter online notebook, same version of gmt as `latest` and updated at the same time. 
- `6`, `6-python`, `6-jupyter` more stable images featuring 6.0 builds that are verified to work. Updated occasionally
- `6.0.0_r20469`, `6.0.0_r20469-python`, `6.0.0_r20469-jupyter`, ... Fixed tags for specific commits and build numbers (Never Updated)


### Basic Usage


**Print Help:**

```sh
$ docker run -it --rm nc5ng/gmt --help
```

**Start a local Shell:**

```sh
$ docker run -it --rm --entrypoint /bin/bash nc5ng/gmt
``

**Using Docker with local files:**

By default, image operates in directory "/workspace"

```sh
# All paths in current dir are valid
$ docker run -it --rm -v "$PWD:/workspace" nc5ng/gmt surface 
```

**Run a gmt command and save output locally:**

```sh
$ docker run --rm nc5ng/gmt pscoast -JM10.0i -R235.0/294.0/24.0/50.0 -C blue -N2  > conus.ps
```


**Starting a `GMT/Python` session in ipython:**

```sh
$ docker run -it --rm nc5ng/gmt:python
```

**Starting a `jupyter` notebook session

```sh
$ docker run -p "8888:8888" -it --rm -v "$PWD:/workspace"  nc5ng/gmt:jupyter
```

Then, connect to the device using the IP of the host computer (or local host) and the secure token printed on the command line.


### Advanced Usage

** Extending Container:**

Complex data processing pipelines are well served by docker images. They can be shared by multiple people easily, with all dependencies and data in place.


The easiest way to integrate your complex data set with the docker image is to extend the image

```Dockerfile
# Extend Python Image
FROM nc5ng/gmt:python

# Add local directory data
ADD ./ /workspace

# Install custom requirements
RUN pip install -r /workspace/requirements.txt

# Use your command as entrypoint for container
ENTRYPOINT /workspace/my_processing_script.sh
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
    command: -JM10.0i -R235.0/294.0/24.0/50.0 -Cblue -N2  > conus.ps
    
```


```sh
$ docker-compose run step-1
$ docker-compose run step-2
```

-




