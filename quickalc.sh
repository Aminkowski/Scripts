#! /bin/bash

# first arg will be the calculation as a string, the second will be the degree of precision
# [ $# -ne 2 ] && exit 2

printf %.$2f "$((10**$2 * $1))e-$2"; echo
