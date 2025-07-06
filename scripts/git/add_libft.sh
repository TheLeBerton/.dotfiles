#!/bin/bash

LIB_SRC="$HOME/lab/libft/libft"
LIB_DST="libft"
HEADER_DIR="headers"
rm -rf "$LIB_DST"
cp -r "$LIB_SRC" "$LIB_DST"
if [ -d "$HEADER_DIR" ]; then
	if [ -f "$HEADER_DIR/libft.h" ]; then
		rm -f "$HEADER_DIR/libft.h"
		echo "Removed libft.h from $HEADER_DIR"
	fi
	cp "$LIB_SRC/libft.h" "$HEADER_DIR/"
    echo "libft.h copied in $HEADER_DIR/"
else
    echo "Directory $HEADER_DIR not found."
fi
echo "libft updated successfully!"


