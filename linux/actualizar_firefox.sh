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
#along with this program.  If not, see <http://www.gnu.org/licenses/>.


update_firefox () {
    cd /opt/firefox_quantum

    echo "Descargando última versión de Firefox..."
    wget -O FirefoxSetup.tar.bz2 -q "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=es-ES"
    tar -jxf FirefoxSetup.tar.bz2
    rm -f FirefoxSetup.tar.bz2

    if [ ! -f /usr/lib/firefox-esr/firefox-esr.bak ] && [ ! -f /usr/bin/firefox.bak ]; then
        echo "Creando backup de Firefox ESR..."
        mv /usr/lib/firefox-esr/firefox-esr /usr/lib/firefox-esr/firefox-esr.bak
        mv /usr/bin/firefox /usr/bin/firefox.bak
    else
        echo "Ya existe backup de Firefox ESR, sustituyendo binarios por los de Quantum..."
        rm -f /usr/lib/firefox-esr/firefox-esr /usr/bin/firefox
        ln -s /opt/firefox_quantum/firefox/firefox /usr/lib/firefox-esr/firefox-esr
        ln -s /opt/firefox_quantum/firefox/firefox /usr/bin/firefox
    fi

    echo "Finalizado"
}

FIREFOX=$(declare -f update_firefox)

sudo bash << EOF 
$FIREFOX 
update_firefox
EOF
