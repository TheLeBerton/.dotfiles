#!/bin/bash

if [ "$(hostname)" = "leberton-ubuntu" ]; then
    sudo hda-verb /dev/snd/hwC1D0 0x1b SET_UNSOLICITED_ENABLE 0x00
    sudo hda-verb /dev/snd/hwC1D0 0x14 SET_PIN_WIDGET_CONTROL 0x40
fi
