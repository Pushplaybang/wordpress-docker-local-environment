# wordpress-docker-local-environment
Prototypal Local WordPress Development environment using docker.  Includes:

* DB - MariaDB (MySQL drop-in replacement)
* PHP7 - PHP is processed in its own container using PHP FPM
  * includes standard PHP & WP tooling such as sendmail, wp-cli, composer etc.
* NginX - Web Server
* MailHog - Mail Catcher for local dev

## requirements
* Docker - https://www.docker.com/products/overview

## Quick Start
This is simply using docker-compose, so starting and stopping the environment, or accessing specific containers uses standard docker compose commands.

with docker installed, clone the repo and in your terminal, from the project root, run `docker-compose up` (show container logs) or `docker-compose up -d` (for no logs).  To stop the environment, press `ctrl+C` or run `docker-compose stop`.

## What you get
Once your environment starts it will create a themes, plugins and uploads folder, these are mapped to the wp-content folder in the wordpress php container. Note the uploads and plugins folders are GIT ignored by default.

### Theme Deevelopment
To create a new theme simply add it in the themes directory.


