# Advanced Setup
The environment is setup for theme development by default. To create a new theme simply begin creating it in the theme folder, or follow the instructions below in the "advanced setup" section.

## Developing a Theme or Plugin
If you'd like to be more selective about your project structure, or what you map into the container, you can do this by editing the `.environment/docker-compose.yml` file.  scroll to the `volumes` section defined under the `php` container, and customise it for your project.  If you'd prefer to mount in a single theme directory, or plugin directory remove the default volumes for plugins and themes listed and add the following:

```sh
# for a custom theme
  - ./../<theme_folder_name>:/var/www/html/wp-content/themes/<theme_folder_name>
# for a custom plugin
- ./../<plugin_folder_name>:/var/www/html/wp-content/plugins/<plugin_folder_name>
```

if you add a custom volume after starting your project, you will have to restart your docker containers.


## Extending The Environment
One of the major benefits of using docker is how easy it can be to extend your setup withadditional dependancies.  Simply edit the `docker-compose.yml` file in the `.environment` directory. for example:

```yaml
# redis
redis:
  image: redis:3.2-alpine

# memcached
memcached:
  image: memcached:1.4-alpine

# elasticsearch
elasticsearch:
  image: elasticsearch:5.1.1-alpine
```

Look up these and more images on [docker hub](https://hub.docker.com/) where you'll find any available documentation. You'll notice that we're using the alpine versions for all images, which keeps the images and container sizes much slimmer.




# Notes
Its worth spending some time getting to grips with the fundementals of docker and docker compose if you haven't worked with it before.

## Why Docker for WordPress
* Minimal system requirements and quick setup
* Easy shareability  between developers
* Lightening fast project setup times as new containers are created from images stored on your system after the first setup
* incredibly easy to learn, configure, change, extend and then share
* paves the way for scalable docker deployments


## Basic Concepts
By Comparison to Vagrant which creates Virtual Machines in minutes, Docker creates Virtual Containers in seconds.

Instead of providing a full Virtual Machine, like you get with Vagrant, Docker provides you lightweight Virtual Containers, that share the same kernel and allow to safely execute independent processes.

Fundementally, docker relies on "images", once an image is downloaded, you work with a single or set of "containers", which are instances of an image. This is why setting up a new environment for each project is so quick, as its creating your containers from locally stored images.  Docker compose allows us to "compose" a set of images as an environment.

 You will be creating a set of isolated containers for each project, so if you require unique dependancies for that project, adjusting it without affecting your entire development machine becomes trivial.

Learn more about docker by having a look at the documentation here: https://docs.docker.com/


## Quick Docker Compose Commands Reference
* up with logging : `docker-compose up`
* up without logging : `docker-compose up -d`
* rebuild : `docker-compose up build`
    * pass the container name after build to target a specific container
* remove specific container : `docker-compose rm <container_name>`
* list all docker images on your system: `docker images`
* list all containers: `docker ps -a`.

## Rebuild the stack
if you'd like to rebuild the stack run the following:

```sh
# remove the containers for this project
docker-compose rm php mariadb nginx mailhog

# build the stack again
docker-compose build
```
## Common Issues


 - undoubtedly more coming soon.


___
