#!/bin/bash

EXEC=$HOME/lab/calc_lexr/calc

if [ ! -f $EXEC ]; then
    echo "Calc not found"
fi

$EXEC
