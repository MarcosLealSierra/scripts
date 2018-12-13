#!/bin/bash

function ispacket {
    _=$(command -v $1);
    if [ "$?" != "0" ]; then
        printf -- 'You don\t seem to have '$1' installed.\n';
        printf -- 'Exiting with code 127...\n';
        exit 127;
    fi
}
