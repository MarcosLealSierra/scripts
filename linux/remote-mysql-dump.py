
#ssh -p 9999 root@212.34.132.239 bash /root/db_export/db_export.sh
#scp -P 9999 root@212.34.132.239:/root/db_export/$(date +%d%m%y)areatiemposdb.sql /home/mleal/Descargas/servidores/areatiempos/db/

#mysql -u areatiempos -pdo4uxIgYcJMDbYy areatiempos < /home/mleal/Descargas/servidores/areatiempos/db/$(date +%d%m%y)areatiemposdb.sql

# PARAMIKO
# OPEN_SFTP

#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os import path
from paramiko import AutoAddPolicy, RSAKey, SSHClient


host = input('host: ')
port = input('port: ')
user = input('user: ')
comando = input('comando: ')

ssh = SSHClient()
ssh.load_system_host_keys()
ssh.set_missing_host_key_policy(AutoAddPolicy())
ssh.connect(hostname=host, port=port, username=user)

sftp = ssh.open_sftp()
sftp.get()
sftp.close()

#stdin, stdout, stderr = ssh.exec_command(comando)

#for line in stdout.readlines():
	#print(line)

ssh.close()

