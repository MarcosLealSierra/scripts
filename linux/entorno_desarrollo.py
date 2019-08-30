#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os import listdir, path
from shlex import split as sh_split
from subprocess import call, Popen, PIPE
from sys import argv

def get_files(target):
    archivos = []
    for fname in listdir(target):
        if path.isdir("{}/{}".format(target, fname)):
            continue
        else:
            archivos.append(fname)
    if not "static" in target:
        archivos.remove("__init__.py")
    return archivos

proyecto = "{}".format(argv[1])

target = "/home/mleal/src/proyectos/{}".format(proyecto)
application = "{}/rootsystem/application".format(target)
modules = "{}/modules".format(application)
static= "{}/rootsystem/static".format(target)
core = "{}/core".format(application)
logs = "/srv/websites/{}/logs".format(proyecto)

application_files = get_files(application)
module_files = get_files(modules)
core_files = get_files(core)
static_files = get_files(static)

panel = "tmux new-window -t {} -n seccion".format(proyecto)
edicion = "cd {}; vim -c"
plogs = "cd /srv/websites/{}/logs; tail -f error.log".format(proyecto)

files_application = "e {}".format(application_files[0])
application_files.pop(0)
for archivo in application_files:
    files_application += "|tabe {}".format(archivo)

files_module = "e {}".format(module_files[0])
module_files.pop(0)
for archivo in module_files:
    files_module += "|tabe {}".format(archivo)

files_core = "e {}".format(core_files[0])
core_files.pop(0)
for archivo in core_files:
    files_core += "|tabe {}".format(archivo)

files_static = "e {}".format(static_files[0])
static_files.pop(0)
for archivo in static_files:
    files_static += "|tabe {}".format(archivo)

llamada = "; bash -i"

panel_application = '{} "{} \'{}\'{}"'.format(panel, 
    edicion.format(application), files_application,
    llamada).replace("seccion", "application")

panel_modules = '{} "{} \'{}\'{}"'.format(panel, edicion.format(modules), 
    files_module, llamada).replace("seccion", "modules")

panel_static = '{} "{} \'{}\'{}"'.format(panel, edicion.format(static), 
    files_static, llamada).replace("seccion", "static")

panel_core = '{} "{} \'{}\'{}"'.format(panel, edicion.format(core), 
    files_core, llamada).replace("seccion", "core")

panel_logs = '{} "{}"'.format(panel, plogs).replace("seccion", "logs")

comandos = [
    "tmux new-session -A -d -s {}".format(proyecto),
    panel_application,
    panel_modules,
    panel_core,
    panel_static,
    panel_logs,
    "tmux set-option -g pane-active-border-fg colour240",
    "tmux attach -t {}".format(proyecto)
]


for indice, comando in enumerate(comandos):
    comandos[indice] = sh_split(comando)

for comando in comandos:
    call(comando)
