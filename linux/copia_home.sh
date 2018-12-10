#!/bin/bash

echo "Desbloqueando partición cifrada..."
sudo cryptsetup open --type luks /dev/sdb1 backupcifrado

echo "Montando partición cifrada..."
sudo mount -t ext4 /dev/mapper/backupcifrado || exit 1

sudo rsync -avh --delete --progress --exclude-from=/home/mleal/Otros/rsync_ignorelist /home/mleal /media/mleal/backupcifrado/backup/
sudo rsync -avh --delete --progress /etc /media/mleal/backupcifrado/backup/
echo "Backup done."

echo "Desmontando partición cifrada..."
sudo umount /media/mleal/backupcifrado

echo "Bloqueando partición cifrada..."
sudo cryptsetup close /dev/mapper/backupcifrado

echo "Quitando disco de forma seguroa..."
#sudo udisksctl unmount /dev/sdb2
#sudo udisksctl power-off /dev/sdb

echo "Puedes desenchufar tu HDD externo"
