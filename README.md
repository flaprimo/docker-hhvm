# Docker hhvm

Minimal [Docker](https://www.docker.com/) container running ubuntu + hhvm + nginx, it is suitable for running any php/hack application.
Database is not included as Docker philosophy is "one container for one logical service", but the container can easily be extended as you wish and connected to other containers too.

## Tech

This Docker container uses:

* [Nginx](http://nginx.org/) - as HTTP Server
* [hhvm](http://hhvm.com/) - as just-in-time compiler for PHP
* [ubuntu:trusty](https://registry.hub.docker.com/_/ubuntu/) - as base container and OS
* [supervisor](http://supervisord.org/) - as process controller for nginx and hhvm

## Installation

Be sure to have [Docker](https://docs.docker.com/installation/) installed. Then choose a way to get and run the container.

### Build & Run

Download the repo and run the following commands to have the container running:

```sh
docker build -t flaprimo/hhvm .
docker run -it --rm --name my-app flaprimo/hhvm
```

### Download & Run

Download the container and run it by using the following commands:

```sh
docker pull flaprimo/hhvm
docker run -it --rm --name my-app flaprimo/hhvm
```

### Examples
add shared folders: if you want to add `/var/www` and `/var/log/nginx` attached respectively to `~/www` and `~/nginx_logs`:

```sh
docker run -it --rm --name my-app -v ~/www:/var/www -v ~/nginx_logs:/var/log/nginx flaprimo/hhvm
```

change default port: if you want to change the default port for example 80->9000:

```sh
docker run -it --rm --name my-app -p 9000:80 flaprimo/hhvm
```

## Usage

Simply put your web application in `/var/www`.

To interact with the container:

```sh
docker exec -i -t my-app bash
```

## References

References that I've used to build the docker file

* http://webdevstudios.com/2014/07/17/setting-up-wordpress-nginx-hhvm-for-the-fastest-possible-load-times
* https://github.com/facebook/hhvm/wiki/Getting-Started
* http://docs.docker.com/articles/dockerfile_best-practices

## License

Apache 2.0
