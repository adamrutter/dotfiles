#!/bin/bash
sensors | grep -i amd -A5 | grep temp1 | cut -d' ' -f 9 | cut -c 2- | rev | cut -c 6- | rev
sensors | grep -i amd -A5 | grep edge | cut -d' ' -f 10 | cut -c 2- | rev | cut -c 6- | rev
