FROM wordpress:4.7.3

RUN apt-get update && apt-get install -y wget vim net-tools && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN mkdir -p /opt/etc/ /var/www/dehydrated/
ADD https://github.com/lukas2511/dehydrated/archive/v0.4.0.tar.gz /root/v0.4.0.tar.gz
RUN tar -zxvf /root/v0.4.0.tar.gz && cp /root/dehydrated-0.4.0/dehydrated /opt/etc/dehydrated && chmod 755 /opt/etc/dehydrated

ADD docker-php.conf /etc/apache2/conf-enabled/docker-php.conf
ADD default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
ADD ssl-params.conf /etc/apache2/conf-available/ssl-params.conf
ADD apache2.conf /etc/apache2/apache2.conf
ADD cmd.sh /

WORKDIR /var/www/html
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
