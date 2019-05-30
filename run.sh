#! /bin/sh
echo Starting with UID=`id -u` and GID=`id -g` ...
rm -- /var/www/localhost/htdocs/var/.lock 

# cron task for check.php in background
while true; do
  sleep ${REFRESH:-60}
  echo `date` : php check starting
  php /var/www/localhost/htdocs/check.php
done &

exec httpd -DFOREGROUND
