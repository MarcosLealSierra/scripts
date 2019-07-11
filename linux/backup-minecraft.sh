#!/bin/bash


saves=/home/mleal/.minecraft/saves
dest=/home/mleal/Otros/minecraft

tar -cvzf $dest/mKWorld-$(date +%d-%m-%Y-%Hh_%Mm_%Ss).tar.gz $saves/Mundo\ nuevo
