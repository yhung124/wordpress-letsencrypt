#!/bin/bash
set -e
set -x

service apache2 status      
service apache2 reload                                                                                                                                                   
/opt/etc/dehydrated --register --accept-terms
/opt/etc/dehydrated -c -d asdf.run

a2enmod ssl    
a2enmod headers
a2ensite default-ssl
a2enconf ssl-params
apache2ctl configtest
service apache2 reload
