#!/usr/bin/env bash
set -euo pipefail

report=${1:-inventaire-300151835.txt}
temp_report=$(mktemp -- "$report.XXXXXX")
trap 'rm -f -- "$temp_report"' EXIT

{
    printf 'Inventaire Linux — 300151835\n'
    date -Is
    printf '\n=== Système ===\n'
    uname -srm
    hostname
    printf '\n=== Processeurs logiques ===\n'
    nproc
    printf '\n=== Mémoire ===\n'
    free -h
    printf '\n=== Disques ===\n'
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
    printf '\n=== Réseau ===\n'
    ip -br address
} > "$temp_report"

mv -- "$temp_report" "$report"
printf 'Rapport créé : %s\n' "$report"
