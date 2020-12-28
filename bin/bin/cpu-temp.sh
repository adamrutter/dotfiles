#!/bin/bash
temp=$(sensors -u 2>/dev/null | awk '/k10temp-pci-00c3/,/^$/' | awk '/temp1_input/{print $2}' | cut -d'.' -f1)
echo "${temp}°"