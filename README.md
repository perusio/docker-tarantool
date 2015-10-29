# Docker image for tarantool

## Introduction

This image contains [tarantool](http://tarantool.org) for debian
testing using a default composers database specified in the
`instances` directory. This is for testing purposes only.

You can **adapt it** for your database by doing
a search & replace of "composers" by your database name in the
Dockerfile. Something like this:

```shell
sed -i 's/composers/mydbname/g' Dockerfile
```
should work. Now you have a Docker image with your database.

Of course you can always login into the container and configure your
own database by hand.

It has a volume in `/data/db`.

## Usage

 1. Clone the repository.
 2. Put your own instance definition in `instances`
 3. Search and replace the composers database instance name by your
    own: 
```shell
sed -i 's/composers/mydbname/g' Dockerfile
```
 4. Build it now: `docker build tarantool .`
 5. Run the image, e.g.:
```shell
docker run -d -ti --name my_tarantool_db -p 127.0.0.1:3301:3301 tarantool
```
 6. Now you can connect from the host to the container using the
    localhost address on port 3301.
 7. Done.

The tarantool daemon runs as user and group `tarantool`. The privilege
drop is done using [gosu](https://github.com/tianon/gosu) from
[debian](https://packages.debian.org/search?keywords=gosu).

## Volumes

The data from tarantool is written to the Docker
[volume](http://docs.docker.com/userguide/dockervolumes/) at
`/data/db`.

Issuing:

```shell docker-inspect -f '{{ index .Volumes "/data/db" }}'
my_tarantool_db ``` will give you the host filesystem directory (VFS)
where the tarantool log, wal and data files when using the [sophia](https://sphia.org)
storage engine reside.

## Default database 'composers'

You can look at the `instances/composers.lua` file to see the definition. It
is a database of Baroque composers. To see all records do:

```lua
box.space.composers:select{}

```

## License (MIT)

Copyright (C) 2015 António P. P. Almeida <appa@perusio.net>

Author: António P. P. Almeida <appa@perusio.net>

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright
holders shall not be used in advertising or otherwise to promote the sale,
use or other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
