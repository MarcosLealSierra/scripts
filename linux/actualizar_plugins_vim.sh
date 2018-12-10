#!/bin/bash

# Actualizar plugins de Vim.
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

DIR_PLUGINS=$HOME/.vim/pack/plugins/start

for i in $DIR_PLUGINS/*; do
    if [[ -d $i ]] && [[ -d $i/.git ]]; then
        echo -e "Plugin: $GREEN$(basename ${i}) $NC \n"
        cd $i
        git pull -v
        echo -e "\n---------------------------------------------------------\n"
    else
        echo -e "Plugin: $RED$(basename ${i}) $NC \n"
        echo "$(basename ${i}) no tiene repositorio"
        echo -e "\n---------------------------------------------------------\n"
    fi
done
