#! /bin/bash

#Generar estructura de desarrollo de aplicación web en MVC con CGI y python
#Copyright © 2018 Marcos Leal Sierra <marcoslealsierra@gmail.com>

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.


application=/srv/websites/$1/rootsystem/application
logs=/srv/websites/$1/logs
plantillas=/home/mleal/plantillas/mvc_cgi

mkdir -p $application/{core,modules}
touch $application/__init__.py $application/modules/__init__.py
cp $plantillas/settings.py $application/settings.py
cp $plantillas/config.py $application/config.py
cp $plantillas/xfc.py $application/xfc.py

mkdir -p $logs
touch $logs/error.log $logs/access.log

cp $plantillas/vhost_cgi.conf /etc/apache2/sites-available/$1.conf
sed -i -e "s/<mvc_example>/$1/g" /etc/apache2/sites-available/$1.conf

ls /etc/apache2/mods-enabled | grep "mpm_event"

if [ $? -eq 0 ]; then
    a2dismod mpm_event
    a2enmod mpm_prefork
    a2enmod cgi
    a2enmod rewrite
    a2ensite $1
    service apache2 restart
else
    a2ensite $1
    service apache2 restart
fi
