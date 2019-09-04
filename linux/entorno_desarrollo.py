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
panel = "tmux new-window -t {} -n seccion".format(proyecto)
plogs = "cd /srv/websites/{}/logs; tail -f error.log | grep -oP '(?<=AH01215:).*'".format(proyecto)
vim = "cd {}; vim ."
edit = "cd {}; vim -c"
interactive = "; bash -i"

application_files = get_files(application)
files_application = "e {}".format(application_files[0])
application_files.pop(0)
for archivo in application_files:
    files_application += "|tabe {}".format(archivo)
panel_application = '{} "{} \'{}\'{}"'.format(
    panel, 
    edit.format(application), 
    files_application,
    interactive
)
panel_modules = '{} "{}"'.format(panel, vim.format(modules))
panel_core = '{} "{}"'.format(panel, vim.format(core))
panel_static = '{} "{}"'.format(panel, vim.format(static))
panel_logs = '{} "{}"'.format(panel, plogs)

comandos = [
    "tmux new-session -A -d -s {}".format(proyecto),
    panel_application.replace("seccion", "application"),
    panel_modules.replace("seccion", "modules"),
    panel_core.replace("seccion", "core"),
    panel_static.replace("seccion", "static"),
    panel_logs.replace("seccion", "logs"),
    "tmux set-option -g pane-active-border-fg colour240",
    "tmux attach -t {}".format(proyecto)
]

for indice, comando in enumerate(comandos):
    comandos[indice] = sh_split(comando)

for comando in comandos:
    call(comando)
