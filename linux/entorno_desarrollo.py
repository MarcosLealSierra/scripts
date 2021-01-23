#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from shlex import split as sh_split
from subprocess import call
from sys import argv


def find(name, path):
    for root, dirs, files in os.walk(path):
        if name in dirs:
            return os.path.join(root, name)

proyecto = "{}".format(argv[1]).replace("@", "").replace("/", "").replace(" ", "")
#target = find(proyecto, '/home/mleal/src')
target = find(proyecto, '/srv/websites')
application = "{}/rootsystem/application".format(target)
modules = "{}/modules".format(application)
static= "{}/rootsystem/static".format(target)
core = "{}/core".format(application)
logs = "{}/logs".format(target)
panel = "tmux new-window -t {} -n seccion".format(proyecto)
plogs = "cd {}; tail -f error.log | grep -oP '(?<=AH01215:).*'".format(logs)
vim = "cd {}; vim ."
edit = "cd {}; vim -c"
interactive = "; bash -i"

panel_application = '{} "{}"'.format(panel, vim.format(application))
panel_modules = '{} "{}"'.format(panel, vim.format(modules))
panel_core = '{} "{}"'.format(panel, vim.format(core))
panel_static = '{} "{}"'.format(panel, vim.format(static))
panel_logs = '{} "{}"'.format(panel, plogs)

comandos = [
    "tmux new-session -A -d -s {} -c {} -n repo".format(proyecto, application),
    panel_logs.replace("seccion", "logs"),
    panel_application.replace("seccion", "application"),
    panel_modules.replace("seccion", "modules"),
    panel_core.replace("seccion", "core"),
    panel_static.replace("seccion", "static"),
    "tmux set-option -g pane-active-border-fg colour240",
    "tmux attach -t {}:0".format(proyecto, application)
]

for indice, comando in enumerate(comandos):
    comandos[indice] = sh_split(comando)

for comando in comandos:
    call(comando)
