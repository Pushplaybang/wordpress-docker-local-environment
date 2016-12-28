#!/bin/bash

# Set Environmental Variables
# - - - - - - - - -
set_envs() {
  SITE_TITLE=${SITE_TITLE:-'freshpress'}
  DB_HOST=${DB_HOST:-'db'}
  DB_NAME=${DB_NAME:-'wordpress'}
  DB_PASS=${DB_PASS:-'wordpress'}
  DB_USER=${DB_USER:-'root'}
  DB_PREFIX=${DB_PREFIX:-'wp_'}
  WP_VERSION=${WP_VERSION:-'latest'}
  ADMIN_EMAIL=${ADMIN_EMAIL:-"admin@freshpress.com"}
  WP_DEBUG_DISPLAY=${WP_DEBUG_DISPLAY:-'true'}
  WP_DEBUG_LOG=${WB_DEBUG_LOG:-'false'}
  WP_DEBUG=${WP_DEBUG:-'false'}
  MULTISITE=${MULTISITE:-'false'}
  [ "$SEARCH_REPLACE" ] && \
    BEFORE_URL=$(echo "$SEARCH_REPLACE" | cut -d ',' -f 1) && \
    AFTER_URL=$(echo "$SEARCH_REPLACE" | cut -d ',' -f 2) || \
    SEARCH_REPLACE=false
}

# General Purpose Error Function
# - - - - - - - - - - - - - - - -
ERROR() {
  echo -e "\n=> (Line $1): $2.";
  exit 1;
}

# Configure wp-cli
# ----------------
wpcli_config() {
cat > /wp-cli.yml <<EOF
quiet: true

core config:
  dbuser: $DB_USER
  dbpass: $DB_PASS
  dbname: $DB_NAME
  dbprefix: $DB_PREFIX
  dbhost: $DB_HOST
  extra-php: |
    define('WP_DEBUG', ${WP_DEBUG,,});
    define('WP_DEBUG_LOG', ${WP_DEBUG_LOG,,});
    define('WP_DEBUG_DISPLAY', ${WP_DEBUG_DISPLAY,,});

core install:
  url: $([ "$AFTER_URL" ] && echo "$AFTER_URL" || echo localhost:8000)
  title: $SITE_TITLE
  admin_user: admin
  admin_password: $DB_PASS
  admin_email: $ADMIN_EMAIL
  skip-email: false
EOF
}


# Download WordPress
# ------------------
download_wp() {
  if [ ! -f /var/www/html/wp-settings.php ]; then
    printf "=> Downloading wordpress... "
    chown -R www-data:www-data /var/www/html
    sudo -u www-data wp core download --version=$WP_VERSION >/dev/null 2>&1 || \
      ERROR $LINENO "Failed to download wordpress"
    printf "Done!\n"
  else
    printf "WordPress is installed \n"
  fi
}


# Wait for MySQL
# --------------
wait_for_mysql() {
  printf "=> Waiting for MySQL to initialize... \n"
  while ! mysqladmin ping --host=$DB_HOST --password=$DB_PASS --silent; do
    printf "...ping"
    sleep 1
  done
}



# wp-config.php
# -------------
setup_wp_config() {
  printf "=> Generating wp.config.php file... "
  rm -f /var/www/html/wp-config.php
  # sudo -u www-data wp core config >/dev/null 2>&1 || \
  sudo -u www-data wp core config >/dev/null 2>&1 || \
    ERROR $LINENO "Could not generate wp-config.php file"
  printf "Done!\n"
}



# Setup database
# --------------
setup_db() {
  printf "=> Create database '%s'... " "$DB_NAME"
  if [ ! "$(wp core is-installed --allow-root >/dev/null 2>&1 && echo $?)" ]; then

    sudo -u www-data wp db create >/dev/null 2>&1 || true
    printf "Done!\n"

    # If an SQL file exists in /data => load it
    if [ "$(stat -t /data/*.sql >/dev/null 2>&1 && echo $?)" ]; then
      DATA_PATH=$(find /data/*.sql | head -n 1)
      printf "=> Loading data backup from %s... " "$DATA_PATH"
      sudo -u www-data wp db import "$DATA_PATH" >/dev/null 2>&1 || \
        ERROR $LINENO "Could not import database"
      printf "Done!\n"

      # If SEARCH_REPLACE is set => Replace URLs
      if [ "$SEARCH_REPLACE" != false ]; then
        printf "=> Replacing URLs... "
        REPLACEMENTS=$(sudo -u www-data wp search-replace "$BEFORE_URL" "$AFTER_URL" \
          --no-quiet --skip-columns=guid | grep replacement) || \
          ERROR $((LINENO-2)) "Could not execute SEARCH_REPLACE on database"
        echo -ne "$REPLACEMENTS\n"
      fi
    else
      printf "=> No database backup found. Initializing new database... "
      sudo -u www-data wp core install >/dev/null 2>&1 || \
        ERROR $LINENO "WordPress Install Failed"
      printf "Done!\n"
    fi
  else
    printf "Already exists!\n"
  fi
}



# Make multisite
# ---------------
do_multisite() {
  printf "=> Turn wordpress multisite on... "
  if [ "$MULTISITE" == "true" ]; then
    sudo -u www-data wp core multisite-convert >/dev/null 2>&1 || \
      ERROR $LINENO "Failed to turn on wordpress multisite"
    printf "Done!\n"
  else
    printf "Skip!\n"
  fi
}

# TODO : Operations to perform on first build
# ------------------------------------
do_on_first_build() {
  if [ ! -f /var/www/html/wp-settings.php ]; then
    printf "is the first build \n"
  else
    printf "is NOT the first build \n"
  fi
}



run() {

  printf "starting run script......"
  cd /var/www/html

  pwd

  # Run functions
  printf "set envs \n"
  set_envs

  printf "setup wpcli config \n"
  wpcli_config

  printf "download wp \n"
  download_wp


  printf "\t%s\n" \
    "=======================================" \
    "    Begin WordPress Configuration" \
    "======================================="

  printf "wait for mysql \n"
  wait_for_mysql

  printf "setup wp config \n"
  setup_wp_config

  printf "setup db \n"
  setup_db

  printf "do multisite \n"
  do_multisite

  printf "do on first build \n"
  do_on_first_build

  printf "\t%s\n" \
    "=======================================" \
    "   WordPress Configuration Complete!" \
    "======================================="
}

# setup and prepare
run

# Start PHP processing
exec /usr/local/bin/docker-entrypoint.sh
