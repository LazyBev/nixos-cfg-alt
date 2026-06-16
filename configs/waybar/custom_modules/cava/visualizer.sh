#!/usr/bin/env bash

FIFO=/tmp/cava.fifo

if [ ! -p "$FIFO" ]; then
    echo ""
    exit 0
fi

while true; do
    if read -r line < "$FIFO"; then
        result=""
        for val in $line; do
            level=$(echo "$val * 8" | bc 2>/dev/null | cut -d. -f1)
            case $level in
                0|1) result="${result}▁";;
                2) result="${result}▂";;
                3) result="${result}▃";;
                4) result="${result}▄";;
                5) result="${result}▅";;
                6) result="${result}▆";;
                7) result="${result}▇";;
                8|9) result="${result}█";;
                *) result="${result} ";;
            esac
        done
        echo "$result"
    fi
done
