#! /bin/bash

#Update IP for SMTP Servers on Zentyal iptables rules
#Copyright © 2019 Marcos Leal Sierra <marcoslealsierra@gmail.com>

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

servers="
smtp.zoho.eu 
smtp.zoho.com 
smtppro.zoho.com
"

ip_lan=192.168.20.0/24

for server in ${servers}; do
    ip=$(ping -c 1 ${server} | awk '{print $3}' | head -1 | sed 's/[()]//g')    
    iptables -nL | grep ${ip}
    if [ $? -eq 1 ]; then
        iptables -A fglobal -s ${ip_lan} -d ${ip}/32 -p tcp -m tcp --dport 25 -j faccept
        iptables -A fglobal -s ${ip_lan} -d ${ip}/32 -p tcp -m tcp --dport 587 -j faccept
        iptables -A fglobal -s ${ip_lan} -d ${ip}/32 -p tcp -m tcp --dport 465 -j faccept
    fi
done

date=$(date +%Y%m%d)
iptables-save > /root/iptables_save_${date}
