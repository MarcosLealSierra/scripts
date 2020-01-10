#! /bin/bash

#Copia de seguridad del home en disco duro externo cifrado con LUKS
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


backup () {
	usbdevice=/media/mleal/backupcifrado/backup/
	ignorelist=${HOME}/Otros/rsync/ignorelist

	echo "Desbloqueando partición cifrada..."
	sudo cryptsetup open --type luks /dev/sdb1 backupcifrado

	echo "Montando partición cifrada..."
	sudo mount -t ext4 /dev/mapper/backupcifrado || exit 1

	sudo rsync -avh --delete --progress --exclude-from=$ignorelist $HOME $usbdevice
	echo "Backup done."

	echo "Desmontando partición cifrada..."
	sudo umount /media/mleal/backupcifrado

	echo "Bloqueando partición cifrada..."
	sudo cryptsetup close /dev/mapper/backupcifrado

	echo "Quitando disco de forma segura..."
	sudo udisksctl unmount -b /dev/sdb2
	sudo udisksctl power-off -b /dev/sdb

	sleep 7
	echo "Puedes desenchufar tu HDD externo"
}

homebackup=$(declare -f backup)
sudo bash << EOF 
${homebackup}
backup
EOF
