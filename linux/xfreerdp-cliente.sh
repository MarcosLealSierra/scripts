# /bin/bash
#
# Automatizar conexiones RPD clientes
# Copyright © 2019 Marcos Leal Sierra

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


clientes="
    albella-servidor
    areaconsultores-castellon 
    boixbrokers-servidor
    boixbrokers-alicia 
    boixbrokers-elena 
    comexa-administracion
    comexa-contabilidad
    comexa-servidor
    comexa-comodin 
    durviz-servidor
    ebm-pcsat
    ebm-roser
    ebm-w7conta
    ebm-vmws2019sql
    espuny-cambiante
    espuny-dolores
    espuny-servidor
    espuny-toshiba
    fvbf-servidor
    lluisademarillac
    maeztu-valencia 
    maeztu-sedavi
    molinsehijos-servidor
    mundimold-w7aux
    mutuaarrocera-servidor
    secanet-servidor
    suministrosmaeztu-servidor
    suministrosmaeztusedavi-servidor
"

if [[ $2 == "laptop" ]]; then
    xfreerdp="xfreerdp +clipboard +fonts /cert-ignore /admin /w:1200 /h:685 /drive:ebmshare,/home/mleal/share"
else 
    xfreerdp="xfreerdp +clipboard +fonts /cert-ignore /admin /w:1820 /h:980 /drive:ebmshare,/home/mleal/share"
fi

case $1 in
    "albella-servidor")
        server="192.168.0.14"
        user="albellaadmin@albella"
        password="#131Lbl#"
        ;;
    "areaconsultores-castellon")
        server="192.168.20.5"
        user="usuario"
        password="'Ooph8Chaitaizi-'"
        ;;
    "boixbrokers-servidor")
        server="192.168.0.2"
        user="administrador@jjboix.local"
        password="CC:000206"
        ;;
    "boixbrokers-alicia")
        server="192.168.0.109"
        user="alicia@jjboix.local"
        password="misifu"
        ;;
    "boixbrokers-elena")
        server="192.168.0.108"
        user="elena@jjboix.local"
        password="nenibo"
        ;;
    "comexa-servidor")
        server="192.168.30.100"
        user="administrador"
        password="+-Adminis+-"
        ;;
    "comexa-administracion")
        server="192.168.30.10"
        user="nika"
        password="Nika"
        ;;
    "comexa-contabilidad")
        server="192.168.30.20"
        user="catia"
        password="MCG"
        ;;
    "comexa-comodin")
        server="192.168.30.220"
        user="comexa"
        password="Comexa"
        ;;
    "durviz-servidor")
        server="192.168.20.14"
        user="administrador"
        password="durviz987654!"
        ;;
    "ebm-pcsat")
        server="192.168.162.138"
        user="ebm"
        password="Abc1234"
        ;;
    "ebm-roser")
        server="192.168.161.98"
        user="roser"
        password="26022004"
        ;;
    "ebm-w7conta")
        server="192.168.161.96"
        user="david"
        password="EMC2_wtil"
        ;;
    "ebm-vmws2019sql")
        server="192.168.162.184"
        user="administrador"
        password="Abc1234"
        ;;
    "espuny-cambiante")
        server="192.168.40.116"
        user="dani"
        password="Abc1234"
        ;;
    "espuny-dolores")
        server="192.168.40.111"
        user="dolores"
        password="Abcd1234"
        ;;
    "espuny-servidor")
        server="192.168.40.42"
        user="victoria"
        password="victoria"
        ;;
    "espuny-toshiba")
        server="192.168.40.44"
        user="portatil"
        password="usuario"
        ;;
    "fvbf-servidor")
        server="192.168.1.2"
        user="administrador"
        password="'Fvbf1215;VTE*'"
        ;;
    "lluisademarillac")
        server="192.168.10.10"
        user="aads"
        password="Oozei2et"
        ;;
    "molinsehijos-servidor")
        server="192.168.2.155"
        user="aplicacionesmolins@molinsd.lan"
        password="prueba"
        ;;
    "mundimold-w7aux")
        server="192.168.81.247"
        user="salva@workgroup.lan"
        password='Eeng5eish'
        puerto='3392'
        ;;
    "mutuaarrocera-servidor")
        server="192.168.0.32"
        user="administrador"
        password="JUJARA"
        ;;
    "secanet-servidor")
        server="localhost"
        user="usuario"
        password="wxpp66dz10"
        ;;
    "suministrosmaeztu-servidor")
        server="192.168.0.200"
        user="administrador"
        password="Abc1234"
        ;;
    "suministrosmaeztusedavi-servidor")
        server="192.168.10.200"
        user="administrador"
        password="Abc1234"
        ;;
    *)
        echo -e "CLIENTES DISPONIBLES\n--------------------"
        for i in $clientes; do
            echo "${i}"
        done
esac

if [ -n "$1" ]; then
    if lsof -i :8888-9999 > /dev/null; then
        set -- "$(echo $1 | sed 's/-w7aux//g')" "${@:1}"
        set -- "$(echo $1 | sed 's/-servidor//g')" "${@:1}"
        cat /home/mleal/src/accesos/$1 | grep -e "-L"
        read -p "puerto de la máquina: " puerto
        server="localhost:${puerto}"
    fi
    conexion="${xfreerdp} /v:${server} /u:${user} /p:${password}"
    echo ${conexion}
    eval ${conexion}
fi
