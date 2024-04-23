# Docker PHP:8.2 Apache, MySQL and Xdebug

Add the following line to your hosts file (`/etc/hosts`) on your machine to resolve the custom domain.
```shell
# docker example
127.0.0.1       example.kitt api.example.kitt
```

**start container**
```shell
docker composer up
```

**Check the access for root directory:**
```shell
http://example.kitt
```

**Check access for api directory:**
```shell
http://api.example.kitt
```

**EXAMPLE: Apache config**
```apacheconf
# Tiny example vhosts config file
<VirtualHost *:80>
  ServerName api.example.kitt
  ServerAlias www.api.example.kitt
  ServerAdmin webmaster@localhost

  DocumentRoot /var/www/html/api
  <Directory /var/www/html/api>
    Options Indexes FollowSymlinks
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:80>
  ServerName example.kitt
  ServerAlias www.example.kitt
  ServerAdmin webmaster@localhost

  DocumentRoot /var/www/html
  <Directory /var/www/html>
    Options Indexes FollowSymlinks
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
# Create custom local domain HTTPS
# NOTE: mkcert is required
# https://github.com/FiloSottile/mkcert
# Create ./ssl directory and run inside => mkcert localhost 127.0.0.1 ::1 example.kitt \*.example.kitt
# Add the new certificates => mkcert -install
# Don't forget to set up the local /etc/hosts file => 127.0.0.1 example.kitt api.example.kitt
# <VirtualHost *:443>
#   # example.kitt:8443
#   ServerName example.kitt
#   ServerAlias www.example.kitt

#   SSLEngine on
#   SSLCertificateFile /var/www/html/ssl/cert.pem
#   SSLCertificateKeyFile /var/www/html/ssl/key.pem

#   ServerAdmin webmaster@localhost
#   DocumentRoot /var/www/html

#   ErrorLog ${APACHE_LOG_DIR}/error.log
#   CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>

# <VirtualHost *:443>
#   # api.example.kitt:8443
#   ServerName api.example.kitt
#   ServerAlias www.api.example.kitt

#   SSLEngine on
#   SSLCertificateFile /var/www/html/ssl/cert.pem
#   SSLCertificateKeyFile /var/www/html/ssl/key.pem

#   ServerAdmin webmaster@localhost
#   DocumentRoot /var/www/html/api

#   ErrorLog ${APACHE_LOG_DIR}/error.log
#   CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>
```
