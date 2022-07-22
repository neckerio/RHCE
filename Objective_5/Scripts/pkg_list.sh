#! /bin/bash

NATIVEPKG="$(sudo pacman -Qen)"
FOREIGNPKG="$(sudo pacman -Qem)"

NATPAC="$(sudo pacman -Qen | cut -d ' ' -f 1)"
FORPAC="$(sudo pacman -Qem | cut -d ' ' -f 1)"

NATPACnum="$(echo $NATPAC | wc -w)"
FORPACnum="$(echo $FORPAC | wc -w)"

PACKAGES="$(echo $NATIVEPKG $FOREIGNPKG)"




echo "Create a natpac.txt file of all Native packages ($NATPACnum)"
read -p "(y/n):" NATCON

NATRECON="$(echo $NATCON | sed 's/[A-Z]/\L&/g')"

if [[ $NATRECON == y ]] || [[ $NATRECON == yes ]]
then
	echo "Creating natpac.txt"
	sleep 2
	echo $NATPAC | tr ' ' '\n' > natpac.txt
	echo DONE!
else
	echo "Skipping natpac.txt creation"
	sleep 2
fi



echo "Create a forpac.txt file of all Foreign packages ($FORPACnum)"
read -p "(y/n):" FORCON

FORRECON="$(echo $FORCON | sed 's/[A-Z]/\L&/g')"

if [[ $FORRECON == y ]] || [[ $FORRECON == yes ]]
then
	echo "Creating forpac.txt"
	sleep 2
	echo $FORPAC | tr ' ' '\n' > forpac.txt
	echo DONE!
else
	echo "Skipping forpac.txt creation"
	sleep 2
fi



