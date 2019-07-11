#! /bin/bash 

#Replace and update Firefox ESR to Firefox Quantum
#Copyright © 2018 Marcos Leal Sierra <marcoslealsierra90@gmail.com>

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program. If not, see <http://www.gnu.org/licenses/>.


update_firefox () {
    path=/opt/firefox_quantum
    url="https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=es-ES"
    backup_lib=/usr/lib/firefox-esr/firefox-esr.bak
    backup_bin=/usr/bin/firefox.bak

    if [ ! -d ${path} ]; then
        mkdir -p ${path}
    fi

    echo "Descargando última versión de Firefox..."
    wget FirefoxSetup.tar.bz2 -O ${path}/FirefoxSetup.tar.bz2 -q ${url}
   
    if [ -d ${path}/firefox ]; then
        echo "Eliminando antigua versión..."
        rm -fr ${path}/firefox
    fi

    echo "Descomprimiendo archivos..."
    tar -jxf ${path}/FirefoxSetup.tar.bz2 -C ${path}
    
    if [ ! -f ${backup_lib} ] && [ ! -f ${backup_bin} ]; then
        echo "Creando backup de Firefox ESR..."
        mv /usr/lib/firefox-esr/firefox-esr ${backup_lib}
        mv /usr/bin/firefox ${backup_bin}
    fi
    
    echo "Creando enlaces..."
    rm -f /usr/lib/firefox-esr/firefox-esr /usr/bin/firefox
    ln -s /opt/firefox_quantum/firefox/firefox /usr/lib/firefox-esr/firefox-esr
    ln -s /opt/firefox_quantum/firefox/firefox /usr/bin/firefox
    
    echo "Actualizado."
}

firefox=$(declare -f update_firefox)
sudo bash << EOF 
${firefox}
update_firefox
EOF
