#!/bin/bash
if [ "$1" == "-h" ]; then
	echo "Useage: bash $0 pdb_file"
	echo "Delete the line if atomtype is H"
	exit 0
fi

cat $1 | awk '$1 == "TER" || ($1 == "ATOM" && $3 ~ /^[^0-9H]/)'

