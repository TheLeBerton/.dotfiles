#!/bin/bash

DIR=$HOME/lab/calc_lexr
EXEC=$DIR/calc

if [ ! -f $EXEC ]; then
    echo "Error: ${EXEC} not found."
    if [ ! -d $DIR ]; then
	echo "Error ${DIR} not found."
    else
	make -C $DIR
	$EXEC
    fi
else
    $EXEC
fi

