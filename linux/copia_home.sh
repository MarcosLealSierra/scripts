#!/bin/bash

#Script para copia de seguridad de mi home y /etc en disco duro externo cifrado con LUKS
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


echo "Desbloqueando partición cifrada..."
sudo cryptsetup open --type luks /dev/sdb1 backupcifrado

echo "Montando partición cifrada..."
sudo mount -t ext4 /dev/mapper/backupcifrado || exit 1

sudo rsync -avh --delete --progress --exclude-from=/home/mleal/Otros/rsync/rsync_ignorelist /home/mleal /media/mleal/backupcifrado/backup/
sudo rsync -avh --delete --progress /etc /media/mleal/backupcifrado/backup/
echo "Backup done."

echo "Desmontando partición cifrada..."
sudo umount /media/mleal/backupcifrado

echo "Bloqueando partición cifrada..."
sudo cryptsetup close /dev/mapper/backupcifrado

echo "Quitando disco de forma seguroa..."
sudo udisksctl unmount -b /dev/sdb2
sudo udisksctl power-off -b /dev/sdb

echo "Puedes desenchufar tu HDD externo"
