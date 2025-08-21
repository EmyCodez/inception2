FROM debian:bookworm

USER root

# Install PHP 8.2 and required packages
RUN apt-get update && apt-get install -y \
    curl \
    mariadb-client \
    php \
    php-fpm \
    php-mysql \
    php-mysqli \
    && mkdir -p /run/php \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM config for PHP 8.2
COPY ./requirements/wordpress/conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Copy entrypoint script
COPY ./requirements/wordpress/tools/wp_start.sh /usr/local/bin/wp_start.sh
RUN chmod +x /usr/local/bin/wp_start.sh

ENTRYPOINT ["/usr/local/bin/wp_start.sh"]
