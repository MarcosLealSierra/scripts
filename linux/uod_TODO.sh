#!/bin/bash

#UOD
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


ELECCION=$1
SERVIDOR=$2
PUERTO=$3
DATOS=$4
RUTA_UPLOAD=~/uploaded/

if [ -z $1 ] || [ -z $2 ]; then
    echo "Ej: uod.sh [OPTION] [USER@HOST] [PORT] [FILE1 DIRECTORY2]"
    exit 1
fi

RSYNC="rsync -av -e 'ssh -p $PUERTO'"

ssh -q -p $PUERTO $SERVIDOR exit


if [ $? = 0 ]; then
    case ${ELECCION} in
        (U | u)
            for path in $DATOS; do
                eval $RSYNC $DATOS $SERVIDOR:~/$RUTA_UPLOAD > /tmp/uod.log 2>&1
                if grep -q "rsync error" /tmp/uod.log; then
                    echo "$path no existe esta ruta"
                else
                    echo "$path....Ok"
                fi
            done
            ;;
        (D | d)
            for path in $DATOS; do
                eval $RSYNC $SERVIDOR:$path ~/Descargas/servidores/ > /tmp/uod.log 2>&1
                if grep -q "rsync error" /tmp/uod.log; then
                    echo "$path no existe esta ruta"
                else
                    echo "$path....Ok"
                fi
            done
            ;;
        (*)
            echo "<$ELECCION> no es una eleccion válida, escoge <u> o <d>"
    esac
    rm -fr /tmp/uod.log
else
    echo "\nNo se puede conectar con el host <$1>"
fi
