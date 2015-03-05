FROM atdocker/nginx:latest

RUN apt-get update; \
    apt-get install -y libxml2-dev libcurl4-openssl-dev pkg-config libjpeg-dev libpng-dev libxpm-dev libfreetype6-dev libc-client-dev; \
    mkdir -p mkdir -p /opt/php55; \
    wget http://sg3.php.net/distributions/php-5.5.22.tar.gz; \
    tar zxf php-5.5.22.tar.gz; \
    rm -f *.gz; \
    cd /opt/php55/php-5.5.22; \
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
      --prefix=/usr/php55 \
      --with-curl \
      --with-fpm-group=www-data \
      --with-fpm-user=www-data \
      --with-freetype-dir=/usr \
      --with-gd \
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
      --with-xmlrpc \
      --with-xpm-dir=/usr \
      --with-xsl \
      --with-zlib;
