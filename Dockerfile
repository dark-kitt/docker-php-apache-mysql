# Use an official PHP runtime
FROM php:8.2-apache
# Install necessary packages
RUN apt-get update && apt-get install -y \
    vim \
    iputils-ping
# Install any extensions you need
RUN docker-php-ext-install mysqli pdo pdo_mysql
# Get the Xdebug extension
RUN pecl install xdebug \
#    # Enable the installed Xdebug
    && docker-php-ext-enable xdebug
# Set the working directory to /var/www/html
WORKDIR /var/www/html
# --- APACHE | set up ---
# Enable APACHE modules
RUN a2enmod rewrite && a2enmod ssl && a2enmod socache_shmcb
# Insert custom vhosts file
RUN echo "Include /var/www/html/vhosts.conf" >> /etc/apache2/sites-available/vhosts.conf
# Copy new vhosts config file into the root dir
COPY --chown=root:root --chmod=711 ./vhosts.conf .
# Disable old default config file
RUN a2dissite 000-default.conf
# Enable new config file
RUN a2ensite vhosts.conf
# Docker PHP-APACHE container logs => docker logs wp-webserver
# Set the 'ServerName' directive globally to suppress this message
# NOTE: https://stackoverflow.com/questions/48868357/docker-php-apache-container-set-the-servername-directive-globally
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
# Describe which ports your application is listening on
EXPOSE 80