FROM wodby/wordpress-php
MAINTAINER Paul van Zyl <paul@nonacreative.com>

# set the working directory
WORKDIR "/var/www/html"

# expose the port for nginx container
EXPOSE 9000

# Install dependencies
RUN \
  echo "fetching and installing dependancies..." \
  && apk add --update --no-cache bash sudo gawk sed grep bc coreutils

# Copy in start script
COPY setup.sh /usr/local/bin/

# Run start script
CMD ["bash", "/usr/local/bin/setup.sh"]
