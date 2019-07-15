#! /usr/bin/python3
#-*- coding: utf-8 -*-

from sys import argv


def pctj(porcentaje = argv[1], cantidad = argv[2]):
    
    val_pctj = int(cantidad) * int(porcentaje) / 100
    total_cantidad = int(cantidad) - val_pctj
    
    print("{}% sobre {}".format(porcentaje, cantidad))
    print("Descuento: {}".format(val_pctj))
    print("Resultado: {}".format(total_cantidad))

pctj()
