#!/bin/bash

# Actualizar repositorios Bazaar y Git en un mismo directorio.
# Copyright © 2018 Marcos Leal Sierra <marcoslealsierra90@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


source ~/.bash_lib

REPOS=$HOME/src
SEPARADOR="$DARKGRAY\n---------------------------------------------------------\n$NC"

function pull_local_repos() {
    for i in $REPOS/*; do 
        if [[ -d $i ]] && [[ -d $i/.git ]]; then
            echo -e "$GREEN$(basename $i)$NC \n"
            cd $i
            git pull -v
            echo -e "$SEPARADOR"
        elif [[ -d $i ]] && [[ -d $i/.bzr ]]; then
            echo -e "$(basename $i) \n"
            cd $i
            bzr pull -v
            echo -e "$SEPARADOR"
        else
            echo -e "$RED$(basename $i)$NC \n\n Sin repositorio encontrado/configurado"
            echo -e "$SEPARADOR"
        fi
    done
}

ping -c 1 -q 192.168.161.109

if [ $? != 0 ]; then
    nmcli c up eBM
    pull_local_repos
    nmcli c down eBM
else
    pull_local_repos
fi
