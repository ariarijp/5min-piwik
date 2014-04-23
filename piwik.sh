MYSQL_PASSWORD="BADPASSWORD"

if [ $MYSQL_PASSWORD="BADPASSWORD" ]; then
    echo "YOU MUST CHANGE YOUR MYSQL_PASSWORD!"
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $MYSQL_PASSWORD"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $MYSQL_PASSWORD"
echo "Asia/Tokyo" > /etc/timezone
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sed -i s/us.archive.ubuntu.com/ftp.jaist.ac.jp/ /etc/apt/sources.list
apt-get update
apt-get install -y apache2 mysql-server php5 php5-mysql php5-gd libfreetype6 unzip curl
service apache2 restart
chown -R vagrant.vagrant /var/www
wget https://github.com/piwik/piwik/archive/master.zip
unzip master.zip
mv piwik-master /var/www/piwik
cd /var/www/piwik
curl -sS https://getcomposer.org/installer | php
php composer.phar install
chown -R www-data:www-data /var/www/piwik
chmod -R 0755 /var/www/piwik/tmp
