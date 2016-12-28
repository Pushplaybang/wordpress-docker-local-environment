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

 * access the wordpress site at `http://localhost:8000/`
 * access mailhog at `http://localhost:8001/`

### Theme Deevelopment
To create a new theme simply add it in the themes directory.

## Docker Compose Commands Reference
* up with logging : `docker-compose up`
* up without logging : `docker-compose up -d`
* rebuild : `docker-compose up build`
    * pass the container name after build to target a specific container
* remove specific container : `docker-compose rm <container_name>`

