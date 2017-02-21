# Dockerized librsvg
[![Image][image-badge]][image-link]
[![License][license-badge]][license-link]
[![Build][build-badge]][build-link]

---

 * [Summary](#summary)
 * [Usage](#usage)
 * [Components](#components)
 * [Build Process](#build-process)
 * [Labels](#labels)
 * [User and Group Mapping](#user-and-group-mapping)

## Summary

A super small Alpine image with rsvg-convert installed.

## Usage

You can use this image locally with `docker run`, calling [`rsvg-convert`](http://manpages.ubuntu.com/manpages/zesty/man1/rsvg-convert.1.html) as such:

```console
docker run -v /media/:/media/ jrbeverly/rsvg rsvg-convert test.svg -o test.png
```

### Gitlab
You can add a build job with `.gitlab-ci.yml`

```yaml
compile_pdf:
  image: jrbeverly/rsvg
  script:
    - rsvg-convert test.svg -o test.png
  artifacts:
    paths:
      - test.png
```

## Image Tags

Build tags available with the image `jrbeverly/rsvg:{TAG}`.

| Tag | Status | Description |
| --- | ------ | ----------- |
| [![Version base][base-badge]][base-link] | [![Image base][base-image-badge]][base-link] | A docker image with librsvg installed, with a non-root running user. |
| [![Version privileged][privileged-badge]][privileged-link] | [![Image privileged][privileged-image-badge]][privileged-link]  | A docker image with librsvg installed. |

## Components

### Metadata Arguments

Metadata build arguments used in the system, the follow the [Label Schema Convention](http://label-schema.org).

| Variable | Value | Description |
| -------- | ----- |------------ |
| BUILD_DATE | see [metadata.variable](Makefile.metadata.variable) | The Date/Time the image was built. |
| VERSION | see [metadata.variable](Makefile.metadata.variable) | Release identifier for the contents of the image. |
| VCS_REF | see [metadata.variable](Makefile.metadata.variable) | Identifier for the version of the source code from which this image was built. |

### Build Arguments

Build arguments used in the system.

| Variable | Value | Description |
| -------- | ------- |------------ |
| DUID | see [user.variable](Makefile.user.variable) | The [user id](http://www.linfo.org/uid.html) of the docker user. |
| DGID | see [user.variable](Makefile.user.variable) | The [group id](http://www.linfo.org/uid.html) of the docker user's group. |
| USER | see [Makefile](Makefile) | Sets the [user](http://www.linfo.org/uid.html) to use when running the image. |

### Volumes

Volumes exposed by the docker container.[^1]

| Volume | Description |
| ------ | ----------- |
| /media/ | The root directory containing files. |

### Environment Variables

Environment variables used in the system.

| Variable | Default | Description |
| -------- | ------- |------------ |
| HOME | / | The pathname of the user's home directory. |

## Build Process

To build the docker image, use the included [`Makefile`](Makefile). It is recommended to use the makefile to ensure all build arguments are provided.

```
make baseimage
make privileged
```

You can also build the image manually, as visible in [`Makefile`](Makefile).  However this is discouraged as the makefile ensures all build arguments are properly formatted.

## Labels

The docker image follows the [Label Schema Convention](http://label-schema.org).  The values in the namespace can be accessed by the following command:

```console
docker inspect -f '{{ index .Config.Labels "org.label-schema.LABEL" }}' IMAGE
```

The label namespace `io.gitlab.jrbeverly` is common among `jrbeverly-docker` images and is a loosely structured set of values.  The values in the namespace can be accessed by the following command:

```console
docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.LABEL" }}' IMAGE
```

## User and Group Mapping

All processes within the docker container will be run as the **docker user**, a non-root user.  The **docker user** is created on build with the user id `DUID` and a member of a group with group id `DGID`.  

Any permissions on the host operating system (OS) associated with either the user (`DUID`) or group (`DGID`) will be associated with the docker user.  The values of `DUID` and `DGID` are visible in the [Build Arguments](#build-arguments), and can be accessed by the commands:

```console
docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.user" }}' IMAGE
docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.group" }}' IMAGE
```

The notation of the build variables is short form for docker user id (`DUID`) and docker group id (`DGID`). 

[^1]: It is necessary to ensure that the **docker user** (`DUID`) has permission to access volumes. (see [User / Group Identifiers](#user-and-group-mapping)

[build-badge]: https://gitlab.com/jrbeverly-docker/docker-rsvg/badges/master/build.svg
[build-link]: https://gitlab.com/jrbeverly-docker/docker-rsvg/commits/master

[license-badge]: https://images.microbadger.com/badges/license/jrbeverly/rsvg.svg
[license-link]: https://microbadger.com/images/jrbeverly/rsvg "Get your own license badge on microbadger.com"

[image-badge]: https://img.shields.io/badge/alpine-3.5-orange.svg?maxAge=2592000
[image-link]: https://hub.docker.com/_/alpine/

[base-badge]: https://images.microbadger.com/badges/version/jrbeverly/rsvg:baseimage.svg
[base-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/rsvg:baseimage.svg
[base-link]: https://microbadger.com/images/jrbeverly/rsvg:baseimage "Get your own version badge on microbadger.com"

[privileged-badge]: https://images.microbadger.com/badges/version/jrbeverly/rsvg:privileged.svg
[privileged-image-badge]: https://images.microbadger.com/badges/image/jrbeverly/rsvg:privileged.svg
[privileged-link]: https://microbadger.com/images/jrbeverly/rsvg:privileged "Get your own version badge on microbadger.com"