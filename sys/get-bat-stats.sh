#!/bin/bash

LC_CHR_CNT="20"
LC_PRN_PTY="true"
LC_BAT_DIR="/sys/class/power_supply/BAT1"

LC_CRG_STS="$(cat "$LC_BAT_DIR/status")"
LC_CRG_NOW="$(cat "$LC_BAT_DIR/charge_now")"
LC_CRG_FUL="$(cat "$LC_BAT_DIR/charge_full_design")"
LC_CRG_PCT="$(("$LC_CRG_NOW" * 100 / "$LC_CRG_FUL"))"

printf "%"$LC_CHR_CNT"s %s\n" "%: " "$LC_CRG_PCT"
printf "%"$LC_CHR_CNT"s %s\n" "charge: " "$LC_CRG_NOW"
printf "%"$LC_CHR_CNT"s %s\n" "capacity: " "$LC_CRG_FUL"
printf "%"$LC_CHR_CNT"s %s\n" "status: " "$LC_CRG_STS"

# printf "%"$LC_CHR_CNT"s %s\n" "$LC_CRG_PCT" ": %"
# printf "%"$LC_CHR_CNT"s %s\n" "$LC_CRG_NOW" ": current"
# printf "%"$LC_CHR_CNT"s %s\n" "$LC_CRG_FUL" ": capacity"
# printf "%"$LC_CHR_CNT"s %s\n" "$LC_CRG_STS" ": status"
