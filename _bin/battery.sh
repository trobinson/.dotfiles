#!/bin/sh

ON_BATTERY="Adapter 0: off-line"
BATTERY_PERCENT=$(acpi -b | cut -d "," -f 2 | tr -d " %")

if [ "$(acpi -a)" = "$ON_BATTERY" ]; then
    if [ "$BATTERY_PERCENT" -gt 66 ]; then
        echo "^fg(#dcdca3)^i(/home/tdr/.dotfiles/_icons/bat_full_01.xbm)^fg() $BATTERY_PERCENT%"
    elif [ "$BATTERY_PERCENT" -gt 33 ]; then
        echo "^fg(#f0dfaf)^i(/home/tdr/.dotfiles/_icons/bat_low_01.xbm)^fg() $BATTERY_PERCENT%"
    elif [ "$BATTERY_PERCENT" -gt 9 ]; then
        echo "^fg(#dca3a3)^i(/home/tdr/.dotfiles/_icons/bat_empty_01.xbm)^fg() $BATTERY_PERCENT%"
    else
        echo "^bg(#ff000)fg(#000000)^i(/home/tdr/.dotfiles/_icons/bat_empty_01.xbm) $BATTERY_PERCENT%^fg()^bg()"
    fi
else
    echo "^fg(#dcdca3)^i(/home/tdr/.dotfiles/_icons/ac.xbm)^fg() $BATTERY_PERCENT%"
fi
