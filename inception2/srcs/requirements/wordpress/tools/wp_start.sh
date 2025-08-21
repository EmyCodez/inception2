#!/usr/bin/env bash

cd "$WP_ROUTE"

# Download WordPress core files
wp core download --force --allow-root

# Create wp-config.php
wp config create \
  --path="$WP_ROUTE"  --allow-root \
  --dbname="$DB_NAME" --dbuser="$DB_USER" \
  --dbpass="$DB_PASS" --dbhost="$DB_HOST" \
  --dbprefix=wp_

if ! wp core is-installed --allow-root --path="$WP_ROUTE"; then
  wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

  # Update blog description (tagline)
  wp option update blogdescription "$WP_BLOG_DESCRIPTION" \
    --allow-root --path="$WP_ROUTE"

  # Install and activate theme
  wp theme install "$WP_THEME" --activate --allow-root --path="$WP_ROUTE"

  # Create additional author user
  wp user create "$WP_USER" "$WP_EMAIL" \
    --role=author \
    --user_pass="$WP_PASS" \
    --allow-root --path="$WP_ROUTE"
fi

php-fpm8.2 -F