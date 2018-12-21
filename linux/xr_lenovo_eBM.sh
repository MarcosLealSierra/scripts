#! /bin/bash

#Configuración de pantalla para la oficina y monitor 1080p no reconocido.
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


set -e

RESX=${1:-1920}
RESY=${2:-1080}

read X MODELINE MODE <<< $(cvt $RESX $RESY 60 | grep Modeline)

xrandr --newmode $MODELINE $MODE
xrandr --addmode HDMI-1 $MODELINE
xrandr --output HDMI-1 --mode $MODELINE
xrandr --output eDP-1 --mode 1366x768 --pos 0x1080
