FROM alpine:3.9

ARG CHEKY_VERSION="4.4"
LABEL maintainer="Obyy https://github.com/obyy"

RUN apk add --no-cache \
    apache2 \
    php7 \
    php7-common \
    php7-iconv \
    php7-sqlite3 \
    php7-xml \
    php7-gd php7-phar \
    php7-posix \
    php7-recode \
    php7-simplexml \
    php7-snmp \
    php7-gettext php7-embed \
    php7-apache2 \
    php7-session \
    php7-curl \
    php7-json\
    php7-zip \
    php7-mysqli \
    php7-mbstring \
    php7-dom \
    tar \
    curl \
  && sed -ri \
    -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
    -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
    -e 's!^(\s*TransferLog)\s+\S+!\1 /proc/self/fd/1!g' \
    -e 's!Listen 80!Listen 8080!g' \
    "/etc/apache2/httpd.conf" \
  && sed -ri \
    -e 's!PidFile "/run/apache2/httpd.pid"!PidFile "/tmp/httpd.pid"!g' \
    /etc/apache2/conf.d/mpm.conf \
  && echo "Servername localhost" >> /etc/apache2/httpd.conf \
  && cd /var/www/localhost/htdocs && rm index.html \
  && curl -sSL https://github.com/Blount/Cheky/archive/${CHEKY_VERSION}.tar.gz | tar -xz --strip-components=1 \
  && chown -R apache:apache . \
  && ln -s /var/www/localhost/htdocs/var /config

USER apache
COPY run.sh /usr/local/bin
VOLUME /config
EXPOSE 8080
CMD ["run.sh"]

