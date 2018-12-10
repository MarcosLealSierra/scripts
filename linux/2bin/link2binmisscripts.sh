#! /bin/bash
# Enlaza los scripts de uso habitual con ~/bin
# Created: 2016-10-01

# Copyright (c) 2016: Hilario J. Montoliu <hmontoliu@gmail.com>
# Copyright (c) 2018: Marcos Leal Sierra <marcoslealsierra90@gmail.com> 

# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.  See http://www.gnu.org/copyleft/gpl.html for
# the full text of the license.

for file in ~/src/proyectos/scripts/linux/2bin/*; do
    case "$(basename $file)" in
        link2binmisscripts.sh) continue;;
    esac
    if [ -f "$file" ]; then
        chmod +x $file
        ln -s $file ~/bin/
    fi
done
