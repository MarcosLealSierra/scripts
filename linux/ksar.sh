#! /bin/bash

#Lanzador de ksar para evaluar datos de systat
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


ksar_path="/home/mleal/Otros/kSar/ksar-5.2.4-SNAPSHOT-all.jar"
multiple="/home/mleal/Otros/kSar/kSar-5.0.6/kSar.jar"
file=$1

if [ -z $1  ] || [ -z $2  ]; then
    java -jar $ksar_path -input $file -tile cpuFixedAxis
else
    java -jar $multiple -input $1 -input $2
fi
