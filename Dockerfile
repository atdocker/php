FROM atdocker/nginx:latest

RUN apt-get update; \
  apt-get install -y libxml2-dev libcurl4-openssl-dev pkg-config libjpeg-dev libpng-dev; \
  mkdir -p mkdir -p /opt/php56; \
  wget http://sg3.php.net/distributions/php-5.6.6.tar.gz; \
  tar zxf php-5.6.6.tar.gz; \
  rm -f *.gz; \
  cd /opt/php56/php-5.6.6; \
    ./configure \
      --enable-bcmath \
      --enable-calendar \
      --enable-exif \
      --enable-fpm \
      --enable-ftp \
      --enable-gd-native-ttf \
      --enable-mbstring \
      --enable-opcache \
      --enable-pcntl \
      --enable-soap \
      --enable-zip \
      --prefix=/opt/php55 \
      --prefix=/usr/php56 \
      --with-curl \
      --with-curlwrappers \
      --with-fpm-group=www-data \
      --with-fpm-user=www-data \
      --with-freetype-dir=/usr \
      --with-gd \
      --with-gmp \
      --with-imap-ssl \
      --with-imap \
      --with-jpeg-dir=/usr \
      --with-kerberos \
      --with-ldap \
      --with-mcrypt \
      --with-mysql-sock=/var/run/mysqld/mysqld.sock \
      --with-mysql=/usr \
      --with-mysqli=/usr/bin/mysql_config \
      --with-openssl \
      --with-pdo-mysql=/usr \
      --with-pear \
      --with-png-dir=/usr \
      --with-t1lib=/usr \
      --with-xmlrpc \
      --with-xpm-dir=/usr \
      --with-xsl \
      --with-zlib; \
