# wordpress-docker-local-environment
Local WordPress Development Environment Using Docker, quickly configurable for theme and plugin development. 


### This Environment Includes:

 * DB - MariaDB (MySQL drop-in replacement)
 * PHP7 - PHP is processed in its own container using PHP FPM
   * includes standard PHP & WP tooling such as sendmail, wp-cli, composer etc.
 * NginX - Web Server
 * MailHog - Mail Catcher for local dev

## requirements
First install docker following the instructions below.

* Git
* Docker - https://www.docker.com/products/overview

## Table of Contents

<!-- MarkdownTOC depth=4 autolink=true bracket=round style=unordered -->

- [Quick Start](#quick-start)
  - [What you get](#what-you-get)
- [Credits and Inspiration](#credits-and-inspiration)
- [Contributions and Suggestions Welcome!](#contributions-and-suggestions-welcome)
    - [License MIT](#license-mit)

<!-- /MarkdownTOC -->


# Quick Start
This is simply using [docker-compose](https://docs.docker.com/compose/overview/), so starting and stopping the environment, or accessing specific containers is done by using standard docker-compose commands.

1. with docker installed, clone the repo into a new folder

```sh
# get the git repo
git clone git@github.com:Pushplaybang/wordpress-docker-local-environment.git . --depth=1
# remove the git
rm -Rf .git
# initialize a new repository
git init
```

2. In the `.env` file set `COMPOSE_PROJECT_NAME` to a unique name for your project. This is the only environment variable in `.env` file that you **need** to set, change the others at your own risk, and at will.

3. In your terminal from the project root, run `docker-compose up` (show container logs) or `docker-compose up -d` (for no logs).  To stop the environment, press `ctrl+C` or run `docker-compose stop` or `docker-compose kill`.

**Adavnced config : ** For additional documentation view the [advanced notes](https://github.com/Pushplaybang/wordpress-docker-local-environment/blob/master/ADVANCED.md)

## What you get
Once your environment starts it will create a theme folder, this is mapped to the wp-content folder in the wordpress php container. should you wish to map other folders, suh as for a custom plugin etc, have a look at the [Advanced Setup](#advanced-setup) below.

 * access the wordpress site at `http://localhost:8000/`
 * access mailhog at `http://localhost:8001/`
 * connect to your DB via `http://localhost:3306`
   * the default username and password are both `wplocal`, (same for db) if you change these in the `.env` file, use your custom username and password, you may also want to update


# Credits and Inspiration
When looking for a docker setup for wordpress none of them satified all of me needs, from php7 and nginx to having working email, flexible project setup, splitting the services out, using alpine base images,  or putting wordpress inside the container rather than bloating your project directory. This was inspired by the work done on the following projects:

* https://github.com/Wodby/docker4wordpress
* https://wckr.github.io/
* https://github.com/visiblevc/wordpress-starter

# Contributions and Suggestions Welcome!
Have something you think this needs or could use as an improvement, let me know.  add [an issue on github](https://github.com/Pushplaybang/wordpress-docker-local-environment/issues) or fork and create a pull request.


____


### License [MIT](https://opensource.org/licenses/MIT)
Copyright (c) 2016 Paul van Zyl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
