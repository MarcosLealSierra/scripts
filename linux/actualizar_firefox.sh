#!/bin/bash 

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


cd /opt/firefox_quantum

sudo wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=es-ES"
sudo tar -jxvf FirefoxSetup.tar.bz2
sudo rm -frv FirefoxSetup.tar.bz2

sudo mv /usr/lib/firefox-esr/firefox-esr /usr/lib/firefox-esr/firefox-esr.bak
sudo mv /usr/bin/firefox /usr/bin/firefox.bak

sudo ln -s /opt/firefox_quantum/firefox/firefox /usr/lib/firefox-esr/firefox-esr
sudo ln -s /opt/firefox_quantum/firefox/firefox /usr/bin/firefox
