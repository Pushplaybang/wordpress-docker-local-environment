# wordpress-docker-local-environment
Prototypal Local WordPress Development Environment Using Docker. Includes:

 * DB - MariaDB (MySQL drop-in replacement)
 * PHP7 - PHP is processed in its own container using PHP FPM
   * includes standard PHP & WP tooling such as sendmail, wp-cli, composer etc.
 * NginX - Web Server
 * MailHog - Mail Catcher for local dev

## requirements
First install docker following the instructions below.

* Docker - https://www.docker.com/products/overview

<!-- MarkdownTOC depth=3 autolink=true bracket=round style=unordered -->

- [Quick Start](#quick-start)
  - [What you get](#what-you-get)
    - [Theme Development](#theme-development)
    - [Plugin Development](#plugin-development)
    - [Advanced Setup](#advanced-setup)
- [Notes](#notes)
  - [Quick Docker Compose Commands Reference](#quick-docker-compose-commands-reference)
  - [Rebuild the stack](#rebuild-the-stack)
  - [Common Issues](#common-issues)
- [Why Docker for WP](#why-docker-for-wp)
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

2. In the `.env` file set `COMPOSE_PROJECT_NAME` to a unique name for your project. This is the only environment variable in `.env` file that you need to set.

3. In your terminal from the project root, run `docker-compose up` (show container logs) or `docker-compose up -d` (for no logs).  To stop the environment, press `ctrl+C` or run `docker-compose stop`.

## What you get
Once your environment starts it will create a themes, plugins and uploads folder, these are mapped to the wp-content folder in the wordpress php container. Note the uploads and plugins folders are GIT ignored by default.

 * access the wordpress site at `http://localhost:8000/`
 * access mailhog at `http://localhost:8001/`
 * connect to your DB via `http://localhost:3306`
   * the default username and password are both `wordpress`, if you change these in the `.env` file, use your custom username and password.

### Theme Development
To create a new theme simply add it in the themes directory, or follow the instructions below in the "advanced setup" section.

### Plugin Development
To create a new plugin simply add it in the plugins directory, make sure to remove the plugins folder from the `.gitignore`, or follow the instructions below in the "advanced setup" section.

### Advanced Setup
By default this basically maps the main folders from the wp-content folder, into your project root.  This makes no assumptions about what you're developing, and what you might deploy.  Though it may leave you with some junk in your repository if you don't take the time to clean it up, or manage your .gitignore carefully.

#### Developing a Theme or Plugin
If you'd like to be more selective about your project structure, or what you map into the container, you can do this by editing the `.environment/docker-compose.yml` file.  scroll to the `volumes` section defined under the `php` container, and customise it for your project.  If you'd prefer to mount in a single theme directory, or plugin directory remove the default volumes for plugins and themes listed and add the following:

```sh
# for a custom theme
  - ./../<theme_folder_name>:/var/www/html/wp-content/themes/<theme_folder_name>
# for a custom plugin
- ./../<plugin_folder_name>:/var/www/html/wp-content/plugins/<plugin_folder_name>
```

if you add a custom volume after starting your project, you will have to restart your docker containers.

#### Working In the Project Root
You could of course also map the root directory to a specific theme of plugin directory if you prefer. simply change to volumes to:

```sh
  - ./../:/var/www/html/wp-content/themes/<plugin_or_theme_folder_name>
```


**note :** the uploads and data volumes are also listed as a convenience, and not neccessary for the environment to operate as expected.




# Notes

## Quick Docker Compose Commands Reference
* up with logging : `docker-compose up`
* up without logging : `docker-compose up -d`
* rebuild : `docker-compose up build`
    * pass the container name after build to target a specific container
* remove specific container : `docker-compose rm <container_name>`

## Rebuild the stack
if you'd like to rebuild the stack run the following:

```sh
# remove the containers for this project
docker-compose rm php mariadb nginx mailhog

# build the stack again
docker-compose build
```
## Common Issues
**Scenario:**  updating the db name, user or password.
 - Ensure that you've updated under the php vars and the db vars in .env file.


# Why Docker for WP

* Minimal system requirements and quick setup
* Easy transferability between developers
* Lightening fast project setup times as new containers are created from images stored on your system after the first setup
* incredibly easy to learn, configure, change, and extend and then share
* paves the way for scalable docker deployments


# Credits and Inspiration
When looking for a docker setup for wordpress none of them satified all of me needs, from php7 and nginx to having working email, flexible project setup, splitting the services out, using alpine base images,  or putting wordpress inside the container rather than bloating your project directory. This was inspired by the work done on the following projects:

* https://github.com/Wodby/docker4wordpress
* https://wckr.github.io/
* https://github.com/visiblevc/wordpress-starter

# Contributions and Suggestions Welcome!
Have something you think this needs or could use as an improvement, let me know.  add [an issue on github]() or fork and create a pull request.



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
