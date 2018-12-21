#!/bin/bash

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


APPLICATION=/srv/websites/$1/rootsystem/application
LOGS=/srv/websites/$1/logs
PLANTILLAS=/home/mleal/Plantillas/mvc_cgi

mkdir -p $APPLICATION/{core,modules}
touch $APPLICATION/__init__.py $APPLICATION/modules/__init__.py
cp $PLANTILLAS/settings.py $APPLICATION/settings.py
cp $PLANTILLAS/config.py $APPLICATION/config.py
cp $PLANTILLAS/xfc.py $APPLICATION/xfc.py

mkdir -p $LOGS
touch $LOGS/error.log $LOGS/access.log

cp $PLANTILLAS/vhost_cgi.conf /etc/apache2/sites-available/$1.conf
sed -i -e "s/<mvc_example>/$1/g" /etc/apache2/sites-available/$1.conf

a2dismod mpm_event
a2enmod mpm_prefork
service apache2 restart

a2enmod cgi
a2enmod rewrite
a2ensite $1
service apache2 restart
