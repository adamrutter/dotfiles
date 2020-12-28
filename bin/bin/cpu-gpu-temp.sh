#!/bin/bash
cpu_temp=$(sensors -u 2>/dev/null | awk '/k10temp-pci-00c3/,/^$/' | awk '/temp1_input/{print $2}' | cut -d'.' -f1)
gpu_temp=$(sensors -u 2>/dev/null | awk '/amdgpu-pci-0900/,/^$/' | awk '/temp1_input/{print $2}' | cut -d'.' -f1)
printf "CPU: ${cpu_temp}°\nGPU: ${gpu_temp}°" 